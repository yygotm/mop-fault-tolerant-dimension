"""Polygon triangulation and quiddity utilities for construct.py (stdlib only)."""
from functools import lru_cache


@lru_cache(None)
def triangulations(vertices):
    """Split at the triangle incident with the root boundary edge."""
    if len(vertices) < 3:
        return (frozenset(),)
    a, b = vertices[0], vertices[-1]
    result = []
    for i in range(1, len(vertices) - 1):
        c = vertices[i]
        edges = frozenset(((a, c), (c, b), (a, b)))
        for left in triangulations(vertices[:i + 1]):
            for right in triangulations(vertices[i:]):
                result.append(edges | left | right)
    return tuple(result)


def canonical(q):
    return min(q[i:] + q[:i] for q in (tuple(q), tuple(reversed(q)))
               for i in range(len(q)))


def adjacency(n, edges):
    adj = [set() for _ in range(n)]
    for a, b in edges:
        adj[a].add(b)
        adj[b].add(a)
    return adj


def from_quiddity(q):
    n = len(q)
    edges = {tuple(sorted((i, (i + 1) % n))) for i in range(n)}
    alive, values = list(range(n)), list(q)
    while len(alive) > 3:
        p = next(i for i, v in enumerate(alive) if values[v] == 1)
        a, b = alive[p - 1], alive[(p + 1) % len(alive)]
        edges.add(tuple(sorted((a, b))))
        values[a] -= 1
        values[b] -= 1
        del alive[p]
    assert all(values[v] == 1 for v in alive)
    adj = adjacency(n, edges)
    assert [len(a) - 1 for a in adj] == list(q)
    return adj


def mops(n):
    """All isomorphism classes, canonical quiddity labels; validate encoding."""
    seen = set()
    for edges in triangulations(tuple(range(n))):
        adj = adjacency(n, edges)
        q = tuple(len(a) - 1 for a in adj)
        key = canonical(q)
        if key in seen:
            continue
        seen.add(key)
        # A fresh ear-deletion reconstruction must reproduce the edge set.
        assert from_quiddity(q) == adj
        yield key, from_quiddity(key)

