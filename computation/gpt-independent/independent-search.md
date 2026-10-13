# Independent exhaustive computation of metric dimensions of maximal outerplanar graphs

This note documents an independent implementation and a finite exhaustive
computation for the problem posed in Section 4, Open problem 4 of
[Hernando, Maureso, Mora and Tejel, arXiv:2610.13374v1](https://arxiv.org/html/2610.13374v1).
For every maximal outerplanar graph (MOP) of order $5\le n\le25$, up to
isomorphism, both the metric dimension $\beta$ and the fault-tolerant metric
dimension $\beta'$ were computed exactly. No graph of order $7\le n\le25$
violated $\beta'(G)\le\lceil n/2\rceil$.
This is a computational result for a bounded range, not a proof for arbitrary order.

## Definitions and scope

For a pair of distinct vertices, put

$$
M_{uv}=\{w\in V(G):d(w,u)\ne d(w,v)\}.
$$

A set $W$ is resolving precisely when $|W\cap M_{uv}|\ge1$ for every pair,
and is fault-tolerant resolving precisely when $|W\cap M_{uv}|\ge2$ for every
pair. The latter is equivalent to remaining resolving after deletion of any
one of its vertices, as stated in Section 1 of the paper. These definitions,
the definition of MOP, and the order restriction $n\ge7$ in Open problem 4
were checked against the paper before the computation.

Orders 5 and 6 are included as additional controls. Their three graphs exceeding
the numerical bound are outside the domain of Open problem 4. Orders greater
than 25 were not run. Neither a conjectural bound nor a bound from the paper
is used to restrict the optimization.

## Complete enumeration

The source comments refer to this note as `report.md` and to steps E1-E3; E1, E2 and E4
are described below, and E3 in the source is the rule that the completion record is written
only after the recursion returns (see S5 and the `END` record below).

### E1: polygon triangulations

Label the vertices in boundary order $0,\ldots,n-1$ and insert all boundary
edges. In an interval $[a,b]$, choose the third vertex $k$, with $a<k<b$,
of the triangle incident with the base edge $(a,b)$, then recurse on
$[a,k]$ and $[k,b]$. The triangle incident with a given base edge is unique,
so this recursion produces every triangulation once, with the boundary labels
fixed. Its leaf count is the Catalan number $C_{n-2}$.

### E2: isomorphism and ordered degree sequences

The boundary cycle is the unique Hamiltonian cycle of a MOP. Indeed, an
internal diagonal separates two nonempty boundary intervals. Deleting its
endpoints separates these intervals. A Hamiltonian cycle containing the
diagonal would give, after removing that edge, a Hamiltonian path between its
endpoints, which could not visit both separated interiors without revisiting
an endpoint. Thus a graph isomorphism acts on the boundary by a rotation or
a reflection.

The boundary-ordered degree sequence uniquely determines a triangulation.
For order greater than three there is a degree-two ear. Remove the first
such vertex in the current boundary order, decrement the degrees of its two
neighbors, and record the edge joining those neighbors. Iterating reconstructs
all diagonals, ending with a triangle. This deterministic reconstruction proves
uniqueness by induction. Consequently the implementation accepts exactly the
lexicographically least sequence among all rotations and reflections. Each
isomorphism class has exactly one accepted labelled triangulation, including
when its boundary sequence has nontrivial symmetry.

The accepted counts agree with [OEIS A000207](https://oeis.org/A000207), at
index $n-2$. This count comparison supplements the completeness argument;
it is not the sole justification for enumeration.

### E4: disjoint rank intervals and the ear restriction

Every canonical degree sequence begins with 2. Therefore the parallel search
may require vertex 0 to be an ear without losing any accepted representative.
After inserting the edge $(1,n-1)$, it enumerates triangulations of the
remaining polygon, giving $T=C_{n-3}$ leaves.

Each recursion branch contains the product of the Catalan numbers for its
unprocessed intervals. These products assign consecutive integer ranks to
all leaves. Partition $p$ of $P$ processes exactly

$$
[\lfloor Tp/P\rfloor,\lfloor T(p+1)/P\rfloor).
$$

These intervals are disjoint and cover all ranks. The implementation skips
branches outside its assigned interval and traverses branches inside it using
the same recursion. At completion, each partition checks that the number of
visited leaves equals its interval length. The runner checks adjacent
endpoints, total coverage, the Catalan total, the histogram sums, and the
known number of isomorphism classes before accepting an entire order.

For order 12, both 7-way partitioning and a 31-partition queue with four
workers were compared against the unpartitioned computation. All 733
representatives, both optimum values, and both selected witness sets agreed.

## Exact minimization and safe pruning

### D1-D4: direct evaluation of the definitions

Breadth-first search gives all distances, from which all masks $M_{uv}$ are
constructed. For each demand $r\in\{1,2\}$, the solver tests whether a set of
size at most $k$ satisfies all constraints, for $k=0,1,\ldots,n$ in increasing
order. The first feasible value is the exact minimum. Every returned witness
is checked against every original pair mask, before constraint reduction.
The Rust oracle additionally evaluates every subset using all original masks.

### S1-S5: correctness of the feasibility search

1. **S1, constraint reduction.** With the same demand for every mask, if
   $A\subseteq B$, the constraint on $A$ implies the constraint on $B$.
   Duplicate masks and supersets may therefore be removed. Masks are processed
   in increasing cardinality. Both endpoints distinguish their own vertex pair,
   so every original mask has cardinality at least two.
2. **S2, deficits and forcing.** Let $C$ be the chosen vertices and $A$ the
   undecided vertices. For an unsatisfied mask $M$, its deficit is
   $t=r-|C\cap M|$. If $|A\cap M|<t$, or the remaining budget is less than
   $t$, the state is impossible. If $|A\cap M|=t$, all these vertices are
   required. Adding forced vertices and rejecting budget overflow preserves
   precisely the feasible completions.
3. **S3, a disjoint-support lower bound.** Select any collection of unsatisfied
   constraints whose remaining supports $A\cap M$ are pairwise disjoint.
   The sum of their deficits is a lower bound on the number of additional
   vertices. Reject only when this sum exceeds the remaining budget. The
   greedy choice of such a collection affects the strength of the bound,
   not its validity.
4. **S4, exhaustive branching.** If forcing does not apply, select a vertex
   from the remaining support of an unsatisfied constraint and recurse on
   including and excluding it. Every possible completion belongs to exactly
   one of these branches. The tightness and coverage heuristics only choose
   the branching order.
5. **S5, termination.** A state succeeds when every constraint is satisfied.
   If a constraint remains unsatisfied and the budget is exhausted, it fails.
   Together with S1-S4, induction over the number of undecided vertices shows
   that no feasible set within the budget is discarded.

These arguments establish the intended correctness of the algorithm. They
do not constitute a proof of Open problem 4 for unbounded order.

## Independent small-order validation

The Python reference uses edge-set triangulation recursion, canonicalizes the
edge set itself under the dihedral group, computes distances by Floyd's
algorithm, and evaluates all $2^n$ subsets without optimization pruning.
For every order from 3 through 12, its representative classes correspond
bijectively to the Rust degree-sequence representatives. Both minima agree
graph by graph, ear reconstruction recovers the same graph, and both Rust
witnesses pass the original pair constraints. This covers 1,092 isomorphism
classes. The Rust unreduced all-subset oracle also agrees over this entire
range. See `logs/reference.log` and `logs/reference-check.json`.

## Results

All counts below are numbers of isomorphism classes. Runtime is elapsed
wall time in seconds, rounded to three decimals; a displayed zero denotes
less than 0.0005 seconds. Small orders used one process; large orders used
16 workers. The environment provided 16 logical CPUs and approximately
16 GB of memory. Timings are observations, not portable performance bounds.

| n | Isomorphism classes | Maximum beta prime | Above ceil(n/2) | Seconds |
|---:|---:|---:|---:|---:|
| 5 | 1 | 4 | 1 | 0.000 |
| 6 | 3 | 4 | 2 | 0.000 |
| 7 | 4 | 4 | 0 | 0.000 |
| 8 | 12 | 4 | 0 | 0.000 |
| 9 | 27 | 5 | 0 | 0.001 |
| 10 | 82 | 5 | 0 | 0.002 |
| 11 | 228 | 6 | 0 | 0.009 |
| 12 | 733 | 6 | 0 | 0.045 |
| 13 | 2,282 | 7 | 0 | 0.033 |
| 14 | 7,528 | 7 | 0 | 0.115 |
| 15 | 24,834 | 8 | 0 | 0.467 |
| 16 | 83,898 | 8 | 0 | 1.578 |
| 17 | 285,357 | 9 | 0 | 8.483 |
| 18 | 983,244 | 9 | 0 | 40.385 |
| 19 | 3,412,420 | 10 | 0 | 145.527 |
| 20 | 11,944,614 | 10 | 0 | 161.623 |
| 21 | 42,080,170 | 11 | 0 | 153.469 |
| 22 | 149,197,152 | 11 | 0 | 465.482 |
| 23 | 531,883,768 | 12 | 0 | 1256.565 |
| 24 | 1,905,930,975 | 12 | 0 | 4042.251 |
| 25 | 6,861,221,666 | 13 | 0 | 7673.013 |

The joint frequency table is supplied in `logs/frequency.csv.txt`, with CSV
columns `n,beta,beta_prime,count`; pairs absent from that table have frequency
zero. `logs/all-summary.json` contains the same histograms and per-order
metadata. The following columns make the parameters in Open problems 2 and 3
explicit.

| n | (beta,beta prime)=(2,4) | (2,5) | (2,6) | (3,4) |
|---:|---:|---:|---:|---:|
| 5 | 1 | 0 | 0 | 0 |
| 6 | 2 | 0 | 0 | 0 |
| 7 | 3 | 0 | 0 | 1 |
| 8 | 10 | 0 | 0 | 2 |
| 9 | 19 | 0 | 0 | 7 |
| 10 | 46 | 0 | 0 | 26 |
| 11 | 95 | 1 | 0 | 72 |
| 12 | 212 | 7 | 0 | 218 |
| 13 | 434 | 30 | 0 | 566 |
| 14 | 882 | 113 | 0 | 1,491 |
| 15 | 1,715 | 359 | 1 | 3,643 |
| 16 | 3,278 | 1,041 | 5 | 8,852 |
| 17 | 6,091 | 2,767 | 32 | 20,800 |
| 18 | 11,137 | 6,928 | 137 | 48,669 |
| 19 | 20,068 | 16,443 | 544 | 112,195 |
| 20 | 35,847 | 37,497 | 1,885 | 258,023 |
| 21 | 63,704 | 82,573 | 6,081 | 589,542 |
| 22 | 112,819 | 177,025 | 18,207 | 1,345,011 |
| 23 | 199,665 | 370,881 | 51,700 | 3,058,466 |
| 24 | 353,123 | 763,011 | 139,814 | 6,945,825 |
| 25 | 625,053 | 1,545,177 | 363,844 | 15,741,826 |

### All three graphs exceeding the bound at orders 5 and 6

Vertices are numbered in boundary order starting at 0. The degree sequence,
complete edge set, and example minimum resolving sets are listed below.
These are all such isomorphism classes at these orders. The machine-readable
version is `logs/over-bound-examples.json`, where witnesses are integer masks
whose bit $i$ selects vertex $i$.

1. Order 5, beta=2, beta prime=4. Boundary degrees: `[2, 3, 3, 2, 4]`.

   Edges: `[[0, 1], [0, 4], [1, 2], [1, 4], [2, 3], [2, 4], [3, 4]]`.

   Minimum resolving set: `[0, 1]`; minimum fault-tolerant resolving set: `[0, 1, 2, 3]`.

2. Order 6, beta=2, beta prime=4. Boundary degrees: `[2, 3, 3, 3, 2, 5]`.

   Edges: `[[0, 1], [0, 5], [1, 2], [1, 5], [2, 3], [2, 5], [3, 4], [3, 5], [4, 5]]`.

   Minimum resolving set: `[0, 4]`; minimum fault-tolerant resolving set: `[0, 1, 2, 3]`.

3. Order 6, beta=2, beta prime=4. Boundary degrees: `[2, 3, 4, 2, 3, 4]`.

   Edges: `[[0, 1], [0, 5], [1, 2], [1, 5], [2, 3], [2, 4], [2, 5], [3, 4], [4, 5]]`.

   Minimum resolving set: `[0, 1]`; minimum fault-tolerant resolving set: `[0, 1, 2, 4]`.

### The order-25 interruption and restart

The first order-25 runner failed while reading a progress log from a Windows
bind mount, with `OSError: [Errno 61] No data available`. That interrupted
attempt was not counted as a completed order. The search source and binary
were unchanged on restart; the runner was extended to retry this read error
and to reuse validated completed partitions.

Exactly 512 partitions were reused (`logs/resume-25-extract.log` keeps this record and the
error line; the full original runner logs are not included). Reuse required a final `END` record,
a unique `PART_COMPLETE` record, the correct order and partition identifiers,
the exact assigned rank endpoints, a matching leaf count, and a matching
histogram sum. The original exit codes of those partitions were unavailable;
they were recorded as null, with explicit completion evidence, rather than
reported as observed zero exit codes. `END` is emitted only after the search,
leaf-count check, and witness-output flush. The remaining 7,680 partitions
were recomputed from their interval starts and had observed zero exit codes.
Incomplete original logs were preserved separately, without contributing
to the final sum.

Before restart, reuse was tested on all 31 partitions of order 12, and on
a mixture of 30 reused partitions and one recomputed partition. Both tests
agreed with the original 733 representative and witness rows. Finally,
`audit_logs.py` independently reaggregated every completed partition for
orders 20 through 25, checking ranks, leaf totals, histograms, completion
records and the runner summaries. All checks passed.

The order-25 table entry is the resumed runner time, 7,673.013 seconds.
Elapsed time from the first attempt's start through final completion,
including the interruption and restart interval, was 16,504.047 seconds, computed from
the start-time records of the original runner logs (not included).

## Strength and limits of the evidence

- **Small-order agreement:** independent Python enumeration and all-subset
  minimization, Rust all-subset validation, and graph-by-graph comparisons
  through order 12.
- **Complete finite enumeration:** every MOP isomorphism class at each order
  from 5 through 25 was evaluated, a total of 9,507,058,998 classes. No
  restriction to a particular family or sampling is used. Both optima are
  computed exactly; completion requires full rank coverage and count checks.
- **Mathematical scope:** the enumeration and pruning arguments explain why
  the algorithm is exhaustive and exact. The finite computation is not a
  mathematical proof of the proposed bound for all orders.

Reaggregating saved logs is a check of the recorded results, not a fresh
enumeration or a fresh optimization run. Preparing this public package did
not repeat the large computations.

## Reproduction

The `code/` directory contains unchanged copies of `src/main.rs`,
`Cargo.toml`, `Cargo.lock`, `reference.py`, `parallel.py`, and `audit_logs.py`.
They use no external Rust crates or Python packages. Rust 1.85.1 and
Python 3.13 were used. Release builds enable integer overflow checks.

Let `<repository>` denote the absolute path of this folder (`computation/gpt-independent/`
in the published repository, not the repository root, whose `code/` folder holds the proof
verifier). In the commands
below, replace it before execution. Commands use a POSIX shell; `$PWD` in
the final example is the current directory. Docker images must be available
before using `--network none`.

```sh
cd <repository>/code
mkdir -p logs results
docker run --rm --network none -v "<repository>/code:/work" -w /work \
  -e RUSTFLAGS=-Ctarget-cpu=native rust:1.85 \
  cargo build --release --locked --target-dir target-final
```

Recorded image digests:

```text
rust:1.85
rust@sha256:e51d0265072d2d9d5d320f6a44dde6b9ef13653b035098febd68cce8fa7c0bc4
python:3.13-slim
python@sha256:bf44cdfcb76cd3b41e879bc058fc37ec5872002ccfde7fcb765e218cde0cd79c
```

Use these digest references instead of the tags to pin the images. Native
CPU optimization may be omitted for portability; it does not change the
algorithm. The recorded source and binary hashes are in
`logs/search-hashes.json`; a rebuild on another CPU need not produce the
same binary hash.

First generate the small-order baseline and run both independent checks:

```sh
cd <repository>/code
for n in $(seq 3 12); do
  docker run --rm --network none -v "<repository>/code:/work" -w /work \
    rust:1.85 ./target-final/release/mop-ftmd-independent "$n" 300 oracle \
    > "logs/run-$n.log" 2>&1 || exit 1
done
docker run --rm --network none -v "<repository>/code:/work" -w /work \
  python:3.13-slim python -u reference.py > logs/reference.log 2>&1 || exit 1
docker run --rm --network none -v "<repository>/code:/work" -w /work \
  python:3.13-slim python -u parallel.py 12 --parts 7 \
  --limit 300 --save --oracle --compare > logs/partition-check.log 2>&1 || exit 1
docker run --rm --network none -v "<repository>/code:/work" -w /work \
  python:3.13-slim python -u parallel.py 12 --parts 31 --workers 4 \
  --limit 300 --save --oracle --compare > logs/partition-queue-check.log 2>&1 || exit 1
```

The executable arguments are order, time limit in seconds, mode (`fast` or
`oracle`), partition index, partition count, optional `ear` restriction,
and output mode (`save` or `summary`). Defaults select an unpartitioned
full polygon and save every representative. Single-order production runs
for orders 13 through 19 used `fast` and limits of 300 seconds, except
540 seconds for order 19. For example:

```sh
docker run --rm --network none -v "<repository>/code:/work" -w /work \
  rust:1.85 ./target-final/release/mop-ftmd-independent 19 540 fast \
  > logs/run-19.log 2>&1 || exit 1
```

The large-order runner commands were as follows; run each through Docker
with the same mount and working directory as above, redirecting both output
streams to `code/logs/run-N.log` and checking the exit status.

```text
python -u parallel.py 20 --parts 16 --workers 16 --limit 540
python -u parallel.py 21 --parts 256 --workers 16 --limit 540
python -u parallel.py 22 --parts 1024 --workers 16 --limit 1800
python -u parallel.py 23 --parts 2048 --workers 16 --limit 3600
python -u parallel.py 24 --parts 4096 --workers 16 --limit 10800
python -u parallel.py 25 --parts 8192 --workers 16 --limit 21049
```

The order-25 restart used `--limit 12231 --resume --progress-seconds 1800`.
For a fresh uninterrupted reproduction, omit `--resume` and allow a suitable
time budget. Without `--save`, the solver still evaluates every graph and
checks both witnesses, but writes representative rows only for graphs
exceeding the bound. The runner produces full partition logs, summaries,
and manifests in `code/logs/` and `code/results/`.

After reproducing orders 20 through 25, audit all partition logs:

```sh
cd <repository>/code
docker run --rm --network none -v "$PWD:/work" -w /work \
  python:3.13-slim python -u audit_logs.py --max-n 25 \
  > logs/audit-through-25.log 2>&1 || exit 1
```

## Contents and deliberately omitted data

The `logs/` directory of this folder contains compact extracts of each completed
order's run log, preserving the completion record and histogram, plus the
small-order reference and partition-check summaries, the final audit log,
the summary JSON files, all three small-order exceptional graphs, the
joint frequency table, and a short extract of the order-25 interruption and
restart records (`resume-25-extract.log`). The CSV table has the filename `frequency.csv.txt`
so that text-only publication checks recognize it; its content is ordinary CSV.

Progress records, absolute paths and start-time metadata have been omitted
from these public summary extracts. Numerical completion records are retained
without changes. Source hashes permit comparison of the copied code.

Individual partition logs, execution manifests, all `results/graphs-*.tsv`
files, compiled binaries, build directories, and intermediate failed-run
logs are deliberately not included. Consequently the compact package alone
cannot replay the full partition-level audit or the graph-by-graph Python
comparison from saved data: regenerate the omitted files using the commands
above. The supplied audit log records the checks performed on the original
full logs; it is not a substitute for those logs or a proof certificate for
the optimization minima. The full frequency tables remain available in the
compact summaries.
