"""Run disjoint Catalan-rank partitions; accept only all successful END logs."""
import argparse
import collections
import csv
import datetime
import json
import math
import pathlib
import re
import subprocess
import time

ROOT = pathlib.Path(__file__).resolve().parent
EXPECTED = dict(enumerate([1, 1, 1, 3, 4, 12, 27, 82, 228, 733, 2282, 7528,
                          24834, 83898, 285357, 983244, 3412420, 11944614,
                          42080170, 149197152, 531883768, 1905930975, 6861221666], 3))


def read_log(path):
    # A Windows bind mount can transiently return ENODATA while another process writes.
    for attempt in range(10):
        try:
            return path.read_text()
        except OSError as error:
            if error.errno != 61 or attempt == 9:
                raise
            time.sleep(0.2)


def completed_partition(path, n, part, parts):
    if not path.exists():
        return False
    text = read_log(path)
    if not text.endswith('END\n'):
        return False
    lines = [x for x in text.splitlines() if x.startswith('PART_COMPLETE ')]
    assert len(lines) == 1
    meta = dict(re.findall(r'(\w+)=([\d.]+)', lines[0]))
    cat = math.comb(2*(n-3), n-3)//(n-2)
    assert int(meta['n']) == n and int(meta['part']) == part and int(meta['parts']) == parts
    assert int(meta['ear']) == 1
    assert int(meta['rank_lower']) == cat*part//parts
    assert int(meta['rank_upper']) == cat*(part+1)//parts
    assert int(meta['labeled']) == int(meta['rank_upper'])-int(meta['rank_lower'])
    assert sum(int(c) for b,f,c in re.findall(r'^HIST (\d+) (\d+) (\d+)$',text,re.M)) == int(meta['count'])
    return True


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('n', type=int)
    parser.add_argument('--parts', type=int, default=16)
    parser.add_argument('--workers', type=int, default=16)
    parser.add_argument('--binary', default='./target-final/release/mop-ftmd-independent')
    parser.add_argument('--limit', type=int, default=540)
    parser.add_argument('--save', action='store_true')
    parser.add_argument('--oracle', action='store_true')
    parser.add_argument('--compare', action='store_true')
    parser.add_argument('--resume', action='store_true')
    parser.add_argument('--progress-seconds', type=int, default=30)
    args = parser.parse_args()
    start = time.monotonic()
    processes = []
    commands = []
    reused = set()
    for part in range(args.parts):
        cmd = [args.binary, str(args.n), str(args.limit),
               'oracle' if args.oracle else 'fast', str(part), str(args.parts), 'ear',
               'save' if args.save else 'summary']
        log = ROOT / 'logs' / f'part-{args.n}-{part}.log'
        processes.append((None, None, log))
        commands.append({'command': cmd, 'log': str(log)})
        if args.resume and completed_partition(log, args.n, part, args.parts):
            reused.add(part)
            commands[-1]['completion_evidence'] = 'validated END and PART_COMPLETE from prior attempt; original exit code unavailable'
    manifest = {'start_jst': datetime.datetime.now(datetime.timezone(datetime.timedelta(hours=9))).isoformat(),
                'n': args.n, 'parts': args.parts, 'workers':args.workers, 'commands': commands, 'status': 'RUNNING'}
    manifest_path = ROOT / 'results' / f'manifest-{args.n}.json'
    manifest_path.write_text(json.dumps(manifest, indent=2)+'\n')
    print('START', json.dumps({k:v for k,v in manifest.items() if k != 'commands'}), flush=True)
    print('RESUME_VALIDATED_PARTS', len(reused), flush=True)
    next_update = start+args.progress_seconds
    next_part = 0
    while next_part < args.parts or any(proc is not None and proc.poll() is None for proc, _, _ in processes):
        active = sum(proc is not None and proc.poll() is None for proc, _, _ in processes)
        while next_part < args.parts and active < args.workers:
            if next_part in reused:
                next_part += 1
                continue
            _, _, log = processes[next_part]
            if args.resume and log.exists():
                log.rename(log.with_suffix('.attempt1.log'))
            handle = log.open('w')
            proc = subprocess.Popen(commands[next_part]['command'], stdout=handle, stderr=subprocess.STDOUT, cwd=ROOT)
            processes[next_part] = proc, handle, log
            next_part += 1
            active += 1
        if time.monotonic()-start > args.limit+60:
            for proc, _, _ in processes:
                if proc is not None and proc.poll() is None:
                    proc.kill()
            break
        if time.monotonic() >= next_update:
            done = len(reused)+sum(proc is not None and proc.poll() is not None for proc, _, _ in processes)
            count = 0
            for part, (_, handle, log) in enumerate(processes):
                if handle is None and part not in reused:
                    continue
                if handle is not None:
                    handle.flush()
                tail = read_log(log)
                values = re.findall(r'count=(\d+)', tail)
                if values:
                    count += int(values[-1])
            print('PROGRESS', json.dumps({'n':args.n, 'done':done, 'parts':args.parts,
                                         'graphs_at_least':count, 'seconds':time.monotonic()-start}), flush=True)
            next_update = time.monotonic()+args.progress_seconds
        time.sleep(0.1)
    hist = collections.Counter()
    ranges = []
    total = labeled = 0
    for part, (proc, handle, log) in enumerate(processes):
        if proc is None and part not in reused:
            manifest['status'] = 'INCOMPLETE'
            manifest_path.write_text(json.dumps(manifest, indent=2)+'\n')
            raise RuntimeError(f'partition not started n={args.n} part={part}')
        code = proc.wait() if proc is not None else None
        if handle is not None:
            handle.close()
        manifest['commands'][part]['exit_code'] = code
        if code != 0 and part not in reused:
            manifest['status'] = 'INCOMPLETE'
            manifest_path.write_text(json.dumps(manifest, indent=2)+'\n')
            raise RuntimeError(f'partition failed n={args.n} part={part} code={code}')
        text = read_log(log)
        assert text.endswith('END\n')
        line = next(line for line in text.splitlines() if line.startswith('PART_COMPLETE '))
        meta = dict(re.findall(r'(\w+)=([\d.]+)', line))
        assert int(meta['n']) == args.n and int(meta['part']) == part and int(meta['parts']) == args.parts
        lower, upper = int(meta['rank_lower']), int(meta['rank_upper'])
        assert int(meta['labeled']) == upper-lower
        ranges.append((lower, upper))
        labeled += int(meta['labeled'])
        total += int(meta['count'])
        part_count = 0
        for b, f, c in re.findall(r'^HIST (\d+) (\d+) (\d+)$', text, re.M):
            hist[int(b), int(f)] += int(c)
            part_count += int(c)
        assert part_count == int(meta['count'])
    assert ranges[0][0] == 0
    assert all(ranges[j][1] == ranges[j+1][0] for j in range(len(ranges)-1))
    cat = math.comb(2*(args.n-3), args.n-3)//(args.n-2)
    assert ranges[-1][1] == labeled == cat
    assert total == sum(hist.values()) == EXPECTED[args.n]
    if args.compare:
        assert args.save
        baseline = (ROOT / 'results' / f'graphs-{args.n}.tsv').read_text().splitlines()[1:]
        rows = []
        for part in range(args.parts):
            rows += (ROOT / 'results' / f'graphs-{args.n}-part-{part}.tsv').read_text().splitlines()[1:]
        assert len(rows) == len(set(rows)) == len(baseline)
        assert sorted(rows) == sorted(baseline)
        print('PARTITION_GRAPH_BY_GRAPH_PASS', flush=True)
    result = {'n':args.n, 'count':total, 'ear_labeled':labeled,
              'max_beta_prime':max(f for b,f in hist),
              'bound':(args.n+1)//2, 'over_bound':sum(c for (b,f),c in hist.items() if f > (args.n+1)//2),
              'histogram':[{'beta':b, 'beta_prime':f, 'count':c} for (b,f),c in sorted(hist.items())],
              'seconds':time.monotonic()-start, 'status':'COMPLETE', 'parts':args.parts}
    (ROOT / 'results' / f'summary-{args.n}.json').write_text(json.dumps(result, indent=2)+'\n')
    manifest['status'] = 'COMPLETE'
    manifest['seconds'] = result['seconds']
    manifest_path.write_text(json.dumps(manifest, indent=2)+'\n')
    print('COMPLETE', json.dumps(result), flush=True)


if __name__ == '__main__':
    main()
