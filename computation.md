# Exhaustive computations for small orders

These computations are independent of the proof in [proof.md](proof.md). They are not used
as premises there. They compute beta and beta' exactly for every maximal outerplanar graph
of small order, up to isomorphism.

## 1. Rust search, orders 4 to 21 (`computation/claude-rust/`)

**Enumeration.** A maximal outerplanar graph of order n >= 3 is a triangulation of an n-gon,
and its boundary Hamilton cycle is unique. A triangulation is determined by its *quiddity
sequence* (the number of triangles at each boundary vertex, a_i = deg(i) - 1). Isomorphism
classes are quiddity sequences up to the dihedral group; the lexicographically smallest image
is the canonical form. Order n+1 is generated from order n by inserting an ear between two
adjacent boundary vertices. The numbers of classes agree with OEIS A000207 (whose term a(k) counts (k+2)-gons) for n = 4, ..., 21.

**Exact beta and beta'.** For each graph, all pairs of distinct vertices and the vertices
resolving each pair are computed by BFS. The minimum size of a set covering every pair once
(beta) or twice (beta') is found by branch and bound: branch on the deficient pair with the
fewest candidate resolvers, and forbid candidates already tried in earlier branches. Every
set returned by the search is checked again by a separate function.

**Cross-check.** `computation/claude-python-reference/mop_ftmd.py` enumerates triangulations
by diagonals and finds beta and beta' by trying all vertex subsets. For n = 5, ..., 14 the
number of classes and the full (beta, beta') histogram agree with the Rust program
(`ref-n5-14.log` and `logs/run-n5-14.log`).

**Results** (complete search over all classes in the stated range):

| n | classes | max beta' | ceil(n/2) | classes with beta' = ceil(n/2) |
|---:|---:|---:|---:|---:|
| 7 | 4 | 4 | 4 | 4 |
| 8 | 12 | 4 | 4 | 12 |
| 9 | 27 | 5 | 5 | 1 |
| 10 | 82 | 5 | 5 | 10 |
| 11 | 228 | 6 | 6 | 1 |
| 12 | 733 | 6 | 6 | 19 |
| 13 | 2,282 | 7 | 7 | 1 |
| 14 | 7,528 | 7 | 7 | 26 |
| 15 | 24,834 | 8 | 8 | 1 |
| 16 | 83,898 | 8 | 8 | 54 |
| 17 | 285,357 | 9 | 9 | 1 |
| 18 | 983,244 | 9 | 9 | 90 |
| 19 | 3,412,420 | 10 | 10 | 1 |
| 20 | 11,944,614 | 10 | 10 | 200 |
| 21 | 42,080,170 | 11 | 11 | 1 |

No graph of order 7 to 21 has beta' > ceil(n/2) (58,825,433 classes). For n = 5 and 6 the
maximum exceeds ceil(n/2), which agrees with the condition n >= 7 in the question. For odd
n = 9, ..., 21 the fan is the only class attaining ceil(n/2); for even n there are others
(listed, up to 40 per order, in `logs/tight-n7-19.log`). The counts for n = 20 and 21 are
read from the (beta, beta') histograms in `logs/run-n15-21.log`; those examples are not listed.

**Logs.**

- `logs/run-n5-14.log`: orders up to 14 with histograms.
- `logs/tight-n7-19.log`: orders up to 19, with the tight examples.
- `logs/run-n15-21.log`: orders up to 21. This run was made with an earlier build that did not
  yet print the tight examples; otherwise the source is the same as in `src/`. The current
  program prints the extra lines `tight (beta' = ceil(n/2))` and `TIGHT ...` for every order
  with statistics.

The n = 21 step took 675 seconds with 16 threads.

**Running.** Rust 1.85 in Docker; `overflow-checks = true` in the release profile.
The arguments are `<n_max> <first order with statistics> <threads>`.

```sh
docker run --rm -v "$PWD/computation/claude-rust:/w:ro" -w /w -e CARGO_TARGET_DIR=/tmp/t rust:1.85 \
  bash -c "cargo build --release --locked && /tmp/t/release/mop_ftmd 14 5 16"
```

For `logs/tight-n7-19.log` use `19 7 16`; for `logs/run-n15-21.log` use `21 15 16`. The Python
reference runs with `python -I computation/claude-python-reference/mop_ftmd.py 5 14`
(about 5 minutes).

## 2. Independent search

`computation/gpt-independent/` is a second program, written separately from the one in Section 1;
neither program's code was seen when the other was written. It is described in detail in
[computation/gpt-independent/independent-search.md](computation/gpt-independent/independent-search.md).
In short:

- **Enumeration.** All triangulations of the n-gon are generated recursively, and a class is
  kept only when its boundary degree sequence is the lexicographically smallest under the
  dihedral group. For the large orders the leaves are split into disjoint rank intervals, and
  each order is accepted only after the interval coverage, the Catalan total and the class
  count are checked.
- **Exact beta and beta'.** For k = 0, 1, ..., n the program decides whether a set of size k
  resolves every pair once (beta) or twice (beta'), with constraint reduction, forcing, a
  disjoint-support lower bound and exhaustive branching. Every returned set is checked against
  all original pairs.
- **Cross-check.** A Python reference implementation enumerates edge sets and tries all vertex
  subsets. For n = 3, ..., 12 it agrees with the Rust program graph by graph (1,092 classes).

**Results.** The search was completed for every order n = 5, ..., 25: 9,507,058,998 classes
in total. No graph of order 7 to 25 has beta' > ceil(n/2). Orders 5 and 6 contain three
graphs with beta' = 4 > ceil(n/2); they are listed in the note.

| n | classes | max beta' | ceil(n/2) |
|---:|---:|---:|---:|
| 22 | 149,197,152 | 11 | 11 |
| 23 | 531,883,768 | 12 | 12 |
| 24 | 1,905,930,975 | 12 | 12 |
| 25 | 6,861,221,666 | 13 | 13 |

For n = 7, ..., 21 the class counts and the maximum of beta' are the same as in the table of
Section 1. The n = 25 run took 7,673 seconds with 16 workers after a restart (an I/O error on
the first attempt; the restart reused 512 completed partitions after checking them, as the
note explains). The per-partition logs and per-graph result files (several hundred megabytes)
are not included; the note lists what is included and how to regenerate the rest.
