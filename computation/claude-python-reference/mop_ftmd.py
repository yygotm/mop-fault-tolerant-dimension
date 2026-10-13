"""Reference implementation: exhaustive computation of β and β′ for maximal outerplanar graphs (MOPs) for small n.

Source: Hernando–Maureso–Mora–Tejel, arXiv:2610.13374 v1.
- W is a resolving set: for every pair of vertices u≠v there is w∈W with d(w,u)≠d(w,v). β is the minimum size of such W
- W is a fault-tolerant resolving set: every pair of vertices is distinguished by at least 2 vertices of W. β′ is the minimum size of such W
- Open problem 4: does β′ ≤ ⌈n/2⌉ hold for every MOP with n≥7?

A MOP is the same thing as a triangulation of an n-gon (the outer Hamiltonian cycle is unique),
so isomorphism classes are triangulations modulo the dihedral group.

Usage: python mop_ftmd.py <n_min> <n_max>
"""
import sys
from itertools import combinations


def triangulations(n):
    """Return all triangulations of the n-gon (vertices 0..n-1), each as a frozenset of diagonals."""
    memo = {}

    def rec(i, j):
        # triangulations of the polygon i,i+1,...,j with base edge (i,j)
        if j - i < 2:
            return [frozenset()]
        if (i, j) in memo:
            return memo[(i, j)]
        out = []
        for k in range(i + 1, j):
            here = set()
            if k - i >= 2:
                here.add((i, k))
            if j - k >= 2:
                here.add((k, j))
            for a in rec(i, k):
                for b in rec(k, j):
                    out.append(frozenset(here) | a | b)
        memo[(i, j)] = out
        return out

    return rec(0, n - 1)


def canonical(diags, n):
    """The lexicographically smallest image of the diagonal set under the dihedral group (rotations and reflections)."""
    best = None
    for r in range(n):
        for s in (1, -1):
            img = tuple(sorted(tuple(sorted(((s * a + r) % n, (s * b + r) % n))) for a, b in diags))
            if best is None or img < best:
                best = img
    return best


def mops(n):
    seen = set()
    for t in triangulations(n):
        c = canonical(t, n)
        if c not in seen:
            seen.add(c)
            yield c


def distances(n, diags):
    adj = [set() for _ in range(n)]
    for v in range(n):
        adj[v].add((v + 1) % n)
        adj[(v + 1) % n].add(v)
    for a, b in diags:
        adj[a].add(b)
        adj[b].add(a)
    dist = []
    for s in range(n):
        d = [-1] * n
        d[s] = 0
        q = [s]
        for x in q:
            for y in adj[x]:
                if d[y] < 0:
                    d[y] = d[x] + 1
                    q.append(y)
        dist.append(d)
    return dist


def resolvers(n, dist):
    """For each vertex pair (u,v), return the set of vertices that distinguish it, as a bit mask."""
    out = []
    for u in range(n):
        for v in range(u + 1, n):
            m = 0
            for w in range(n):
                if dist[w][u] != dist[w][v]:
                    m |= 1 << w
            out.append(m)
    return out


def min_size(n, res, need):
    """The minimum |W| such that every pair is distinguished by at least `need` vertices of W."""
    for k in range(1, n + 1):
        for W in combinations(range(n), k):
            mask = 0
            for w in W:
                mask |= 1 << w
            if all(bin(m & mask).count("1") >= need for m in res):
                return k, W
    return None, None


def main():
    lo, hi = int(sys.argv[1]), int(sys.argv[2])
    for n in range(lo, hi + 1):
        count = 0
        worst = 0
        worst_ex = None
        hist = {}
        for diags in mops(n):
            count += 1
            dist = distances(n, diags)
            res = resolvers(n, dist)
            b, _ = min_size(n, res, 1)
            bp, Wp = min_size(n, res, 2)
            hist[(b, bp)] = hist.get((b, bp), 0) + 1
            if bp > worst:
                worst, worst_ex = bp, (diags, Wp)
        bound = (n + 1) // 2
        print(f"n={n} MOPs={count} max_beta'={worst} ceil(n/2)={bound} "
              f"{'VIOLATION' if worst > bound else 'ok'}")
        print(f"  (beta,beta') histogram: {dict(sorted(hist.items()))}")
        print(f"  a worst example: diagonals={worst_ex[0]} W={worst_ex[1]}")
        sys.stdout.flush()


if __name__ == "__main__":
    main()
