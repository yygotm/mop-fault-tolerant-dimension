"""Reconstruct completed parallel-order histograms from every partition log.
Does not enumerate graphs or solve the optimization problems again.
"""
import argparse
import collections
import hashlib
import json
import math
import pathlib
import re
import time

ROOT = pathlib.Path(__file__).resolve().parent


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--max-n', type=int, required=True)
    args = parser.parse_args()
    started = time.monotonic()
    audits = []
    for n in range(20, args.max_n+1):
        manifest = json.loads((ROOT / 'results' / f'manifest-{n}.json').read_text())
        summary = json.loads((ROOT / 'results' / f'summary-{n}.json').read_text())
        assert manifest['status'] == summary['status'] == 'COMPLETE'
        parts = manifest['parts']
        hist = collections.Counter()
        total = 0
        end = 0
        digest = hashlib.sha256()
        for part in range(parts):
            entry = manifest['commands'][part]
            assert entry['exit_code'] == 0 or (entry['exit_code'] is None and
                entry.get('completion_evidence') == 'validated END and PART_COMPLETE from prior attempt; original exit code unavailable')
            raw = (ROOT / 'logs' / f'part-{n}-{part}.log').read_bytes()
            digest.update(str(part).encode()+b'\0'+raw+b'\0')
            text = raw.decode()
            assert text.endswith('END\n')
            lines = [line for line in text.splitlines() if line.startswith('PART_COMPLETE ')]
            assert len(lines) == 1
            meta = dict(re.findall(r'(\w+)=([\d.]+)', lines[0]))
            assert int(meta['n']) == n and int(meta['part']) == part
            assert int(meta['parts']) == parts and int(meta['ear']) == 1
            lower, upper = int(meta['rank_lower']), int(meta['rank_upper'])
            assert lower == end and upper >= lower
            assert int(meta['labeled']) == upper-lower
            end = upper
            count = 0
            for b, f, c in re.findall(r'^HIST (\d+) (\d+) (\d+)$', text, re.M):
                hist[int(b), int(f)] += int(c)
                count += int(c)
            assert count == int(meta['count'])
            total += count
        assert end == summary['ear_labeled'] == math.comb(2*(n-3), n-3)//(n-2)
        assert total == summary['count']
        assert dict(hist) == {(x['beta'],x['beta_prime']):x['count'] for x in summary['histogram']}
        run_lines = (ROOT / 'logs' / f'run-{n}.log').read_text(encoding='utf-8-sig').splitlines()
        parent = [json.loads(line[len('COMPLETE '):]) for line in run_lines if line.startswith('COMPLETE {')]
        assert parent == [summary]
        audits.append({'n':n, 'parts':parts, 'graphs':total, 'ear_labeled':end,
                       'ordered_partition_logs_sha256':digest.hexdigest(), 'status':'PASS'})
        print(json.dumps(audits[-1]), flush=True)
    out = {'orders':audits, 'seconds':time.monotonic()-started, 'status':'PASS'}
    (ROOT / 'results' / f'log-audit-through-{args.max_n}.json').write_text(json.dumps(out,indent=2)+'\n')
    print('ALL_PARTITION_LOGS_AUDITED', flush=True)


if __name__ == '__main__':
    main()
