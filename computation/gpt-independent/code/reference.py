"""Small independent reference: edge-set Catalan recursion, Floyd, all subsets.
Run in Docker Python; no third-party dependencies. No optimization pruning.
"""
import csv
import functools
import itertools
import json
import pathlib
import time

ROOT = pathlib.Path(__file__).resolve().parent


@functools.lru_cache(None)
def triangulations(lo, hi):
    if hi - lo < 2:
        return (frozenset(),)
    answer = []
    for k in range(lo + 1, hi):
        for left in triangulations(lo, k):
            for right in triangulations(k, hi):
                answer.append(left | right | {(lo, k), (k, hi), (lo, hi)})
    return tuple(answer)


def edge_canonical(edges, n):
    return min(tuple(sorted(tuple(sorted(((s + sign*u) % n, (s + sign*v) % n)))
                            for u, v in edges))
               for s in range(n) for sign in (1, -1))


def degree_canonical(edges, n):
    d = [sum(v in edge for edge in edges) for v in range(n)]
    return min(tuple(d[(s + sign*j) % n] for j in range(n))
               for s in range(n) for sign in (1, -1))


def distances(edges, n):
    d = [[0 if u == v else n for v in range(n)] for u in range(n)]
    for u, v in edges:
        d[u][v] = d[v][u] = 1
    for k in range(n):
        for u in range(n):
            for v in range(n):
                d[u][v] = min(d[u][v], d[u][k] + d[k][v])
    return d


def raw_minima(edges, n):
    d = distances(edges, n)
    masks = [sum(1 << w for w in range(n) if d[w][u] != d[w][v])
             for u in range(n) for v in range(u+1, n)]
    b = f = n
    # Every subset is evaluated, including after an optimum is already found.
    for subset in range(1 << n):
        counts = [(m & subset).bit_count() for m in masks]
        c = min(counts)
        if c >= 1:
            b = min(b, subset.bit_count())
        if c >= 2:
            f = min(f, subset.bit_count())
    return b, f


def main():
    start = time.monotonic()
    expected = {3:1, 4:1, 5:1, 6:3, 7:4, 8:12, 9:27, 10:82, 11:228, 12:733}
    checks = []
    for n in range(3, 13):
        reps = {edge_canonical(e, n) for e in triangulations(0, n-1)}
        assert len(reps) == expected[n]
        rows = list(csv.DictReader((ROOT / 'results' / f'graphs-{n}.tsv').open(), delimiter='\t'))
        rust = {tuple(map(int, row['degrees'].split(','))): row for row in rows}
        assert len(rows) == len(rust) == len(reps)
        checked = set()
        for edges in sorted(reps):
            key = degree_canonical(edges, n)
            assert key not in checked  # adjacency and degree representatives agree bijectively
            checked.add(key)
            row = rust[key]
            assert raw_minima(edges, n) == (int(row['beta']), int(row['beta_prime']))
            # Reconstruct the Rust labeling from its degree sequence and check its witnesses.
            rust_edges = reconstruct(key)
            assert edge_canonical(rust_edges, n) == edges
            d = distances(rust_edges, n)
            for col, req, cardinality in [('witness_beta', 1, 'beta'), ('witness_beta_prime', 2, 'beta_prime')]:
                witness = int(row[col])
                assert witness.bit_count() == int(row[cardinality])
                for u, v in itertools.combinations(range(n), 2):
                    assert sum(d[w][u] != d[w][v] for w in range(n) if witness >> w & 1) >= req
        checks.append({'n': n, 'labeled': len(triangulations(0, n-1)), 'graphs': len(reps),
                       'all_subsets_per_graph': 1 << n, 'status': 'PASS'})
        print(json.dumps(checks[-1]), flush=True)
    result = {'checks': checks, 'seconds': time.monotonic()-start, 'status': 'PASS'}
    (ROOT / 'results' / 'reference-check.json').write_text(json.dumps(result, indent=2)+'\n')
    print('REFERENCE_ALL_PASS', flush=True)


def reconstruct(degrees):
    n = len(degrees)
    live = list(range(n))
    d = list(degrees)
    edges = {(i, (i+1) % n) for i in range(n)}
    edges = {tuple(sorted(e)) for e in edges}
    while len(live) > 3:
        i = next(j for j, v in enumerate(live) if d[v] == 2)
        u, v = live[i-1], live[(i+1) % len(live)]
        edges.add(tuple(sorted((u, v))))
        d[u] -= 1
        d[v] -= 1
        live.pop(i)
    assert all(d[v] == 2 for v in live)
    return tuple(sorted(edges))


if __name__ == '__main__':
    main()
