# Lean formalization: definitions and supplied examples

## Scope

This package contains a partial formalization in **Lean 4.34.1 with Mathlib v4.34.1**. It proves general facts about fault-tolerant resolving sets and graph distance, and verifies **42 supplied examples of order seven and 132 supplied examples of order eight**. The examples are concrete rooted binary decomposition trees, distance tables, and selected vertex sets.

**The completeness of the example lists is not proved in Lean.** Their lengths equal the rooted triangulation counts 42 and 132, but the formal theorems quantify only over membership in the supplied lists. A general equivalence between the tree representation and maximal outerplanar graphs is also not formalized. **The all-orders theorem, the state-composition lemmas, and the 28,224-transition certificate are not formalized in this package.** The all-orders computer-assisted argument is in [proof.md](proof.md).

## Build

Enter the `lean` directory and run:

```sh
lake update
lake exe cache get
lake build
lake env lean MopFTMD.lean
```

The toolchain file selects Lean 4.34.1. `lakefile.toml` requires Mathlib from its public Git repository at revision `v4.34.1`. Even if Lake's build is already up to date, the last command reproduces the axiom output for the theorems imported by `MopFTMD.lean` (those of `One.lean`, and two auxiliary lemmas in `Negative.lean`, are printed only when those modules are compiled). The optional single-example benchmark can be checked with `lake env lean MopFTMD/One.lean` after the build; `MopFTMD/Baseline.lean` imports the data without a new verification theorem.

The source was successfully compiled and rebuilt with these Lean and Mathlib versions, using an already available Mathlib installation. The publication sources preserve those Lean files apart from line-ending normalization. The portable Git dependency configuration has not been tested by fetching and rebuilding dependencies from an empty machine. The measured clean rebuild deleted this package's own build directory and reused compiled Mathlib; it was not a Mathlib rebuild. No compiled artifacts, build logs, or machine-specific build scripts are included.

## Definitions and general theorems

All declarations below lie in namespace `MopFTMD`. Graphs use Mathlib's `SimpleGraph`; graph distances use `SimpleGraph.dist`. A landmark set is a `Finset`.

| Declaration or group | Formal content |
|---|---|
| `Resolving`, `FaultTolerantResolving` | One witness and two distinct witnesses, respectively, for each distinct vertex pair, using `SimpleGraph.dist`. |
| `DeletionResolving` | The original set resolves, and erasing any member leaves a resolving set. Including the original resolving property avoids a vacuous assertion for an empty set. |
| `faultTolerantResolving_iff_deletion` | Equivalence of the two-witness and deletion formulations. |
| `faultTolerantMetricDimension` | The natural-number infimum of cardinalities of fault-tolerant resolving sets. |
| `univ_faultTolerantResolving` | In a finite connected graph, the whole vertex set is fault-tolerant resolving. |
| `dimension_attained`, `dimension_le_card` | Attainment of the minimum in finite connected graphs, and the upper bound furnished by any fault-tolerant resolving set. |
| `within_iff`, `exists_within` | The bounded executable walk search is equivalent to existence of a walk of bounded length, and eventually succeeds in a connected graph. |
| `computableDist_eq_dist` | The executable least successful walk bound agrees with `SimpleGraph.dist` for finite connected graphs with decidable adjacency. |
| `certified_walk`, `certified_lower` | A valid distance table supplies walks of the stated length and lower bounds the length of every walk. |
| `distanceCertificate_eq_dist` | Every valid distance table agrees with Mathlib graph distance. |
| `distanceCertificate_connected`, `distanceCertificate_eq_computableDist` | A valid table on a nonempty vertex type gives connectedness and agrees with the executable distance. |
| `tableFTRS_sound`, `exampleCheck_sound`, `Example.sound` | Transfer the finite table checks to fault-tolerant resolution and the fault-tolerant metric-dimension bound for the interpreted `SimpleGraph`. |

The distance certificate requires zero diagonal, positive off-diagonal entries, the edge inequality $D(u,v)\le D(w,v)+1$ whenever $u,w$ are adjacent, and, for distinct $u,v$, an adjacent $w$ with $D(u,v)=D(w,v)+1$. These conditions prove equality with graph distance; the supplied distance tables are not trusted as an oracle.

## Concrete theorems and negative controls

`MopFTMD/Data.lean` contains the explicit data. The following theorems were checked:

| Theorems | Content |
|---|---|
| `checked_e7_000` through `checked_e7_041` | Each supplied order-seven example satisfies `Example.check`, by `decide +kernel`. |
| `checked_e8_000` through `checked_e8_131` | Each supplied order-eight example satisfies `Example.check`, by `decide +kernel`. |
| `cases7_checked`, `cases8_checked` | Every list entry passes the checker. |
| `cases7_count`, `cases8_count` | The respective list lengths are 42 and 132. |
| `cases7_sound`, `cases8_sound` | Each list member's selected set is fault-tolerant resolving, has size at most $(n+1)/2$ rounded down, and gives the same upper bound on the fault-tolerant metric dimension. |
| `one_checked`, `one_sound` | The first order-seven example, also provided as an individual benchmark. |
| `removedLandmark_size` | The mutated landmark set has exactly one fewer vertex. |
| `removedLandmark_rejected`, `removedLandmark_twoWitness_rejected` | Both the whole example check and the two-witness check evaluate to false after this deletion. |
| `brokenDistance_single_entry` | The distance mutation changes exactly the ordered entry $(0,1)$. |
| `brokenDistance_rejected` | The mutated distance certificate evaluates to false. |

For clarity, the aggregate semantic statements are:

```lean
MopFTMD.cases7_sound (e : MopFTMD.Example 7) :
  e ∈ MopFTMD.Data.cases7 → e.result
MopFTMD.cases8_sound (e : MopFTMD.Example 8) :
  e ∈ MopFTMD.Data.cases8 → e.result
```

Here `e.result` asserts fault-tolerant resolution in `e.tree.graph n` using Mathlib distance, the selected-set cardinality bound, and the fault-tolerant metric-dimension bound. It does not assert that an arbitrary maximal outerplanar graph belongs to either list.

## Kernel checks and axioms

The concrete decisions use `decide +kernel`, not native evaluation. The source contains no `sorry`, `admit`, custom axiom declaration, or use of `native_decide`. The axiom reports below contain only `propext`, `Classical.choice`, and `Quot.sound`; in particular they contain neither `Lean.ofReduceBool` nor `sorryAx`.

The following is the actual `#print axioms` output from the successful build, with duplicate lines omitted.

```text
'MopFTMD.faultTolerantResolving_iff_deletion' depends on axioms: [propext, Classical.choice, Quot.sound]
'MopFTMD.dimension_le_card' depends on axioms: [propext, Classical.choice, Quot.sound]
'MopFTMD.univ_faultTolerantResolving' depends on axioms: [propext, Classical.choice, Quot.sound]
'MopFTMD.dimension_attained' depends on axioms: [propext, Classical.choice, Quot.sound]
'MopFTMD.within_iff' depends on axioms: [propext, Classical.choice, Quot.sound]
'MopFTMD.exists_within' depends on axioms: [propext, Classical.choice, Quot.sound]
'MopFTMD.computableDist_eq_dist' depends on axioms: [propext, Classical.choice, Quot.sound]
'MopFTMD.certified_walk' depends on axioms: [propext, Quot.sound]
'MopFTMD.certified_lower' depends on axioms: [propext]
'MopFTMD.distanceCertificate_eq_dist' depends on axioms: [propext, Classical.choice, Quot.sound]
'MopFTMD.distanceCertificate_connected' depends on axioms: [propext, Quot.sound]
'MopFTMD.distanceCertificate_eq_computableDist' depends on axioms: [propext, Classical.choice, Quot.sound]
'MopFTMD.tableFTRS_sound' depends on axioms: [propext, Classical.choice, Quot.sound]
'MopFTMD.exampleCheck_sound' depends on axioms: [propext, Classical.choice, Quot.sound]
'MopFTMD.Example.sound' depends on axioms: [propext, Classical.choice, Quot.sound]
'MopFTMD.cases7_checked' depends on axioms: [propext, Quot.sound]
'MopFTMD.cases7_sound' depends on axioms: [propext, Classical.choice, Quot.sound]
'MopFTMD.cases7_count' depends on axioms: [propext, Quot.sound]
'MopFTMD.cases8_checked' depends on axioms: [propext, Quot.sound]
'MopFTMD.cases8_sound' depends on axioms: [propext, Classical.choice, Quot.sound]
'MopFTMD.cases8_count' depends on axioms: [propext, Quot.sound]
'MopFTMD.removedLandmark_rejected' depends on axioms: [propext, Classical.choice, Quot.sound]
'MopFTMD.removedLandmark_twoWitness_rejected' depends on axioms: [propext, Classical.choice, Quot.sound]
'MopFTMD.brokenDistance_rejected' depends on axioms: [propext, Quot.sound]
'MopFTMD.one_checked' depends on axioms: [propext, Quot.sound]
'MopFTMD.one_sound' depends on axioms: [propext, Classical.choice, Quot.sound]
'MopFTMD.removedLandmark_size' depends on axioms: [propext, Classical.choice, Quot.sound]
'MopFTMD.brokenDistance_single_entry' depends on axioms: [propext, Quot.sound]
```

## Recorded performance

The clean rebuild of the ten source modules (the eight modules built by `lake build`, plus `One.lean` and `Baseline.lean` compiled separately) took 352.085 seconds with compiled Mathlib reused. Per-process measurements used one Lean thread and `--profile`; memory is the Windows process peak working set. The profiler's cumulative type-checking time includes all declarations in that module, not only the decision theorem.

| Module workload | Wall time (seconds) | Type checking (seconds) | Peak memory (MiB) |
|---|---:|---:|---:|
| Import-only baseline | 21.054 | Not separately reported | 973.07 |
| One order-seven example | 22.212 | 0.443 | 1015.91 |
| 42 order-seven examples | 43.148 | 21.3 | 1039.14 |
| 132 order-eight examples | 121.165 | 97.6 | 1111.17 |

These measurements concern the supplied-example checker. They are not timings for formal verification of the all-orders certificate, which has not been implemented in Lean.
