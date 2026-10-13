# The half-order bound for the fault-tolerant metric dimension of maximal outerplanar graphs

This repository contains a computer-assisted proof, its finite certificate and verifier,
exhaustive computations for small orders, and a partial Lean 4 formalization for the
following question.

**Open problem 4** (C. Hernando, M. Maureso, M. Mora, J. Tejel, *On the fault-tolerant
metric dimension of maximal outerplanar graphs*, arXiv:2610.13374v1, Section 4).
Is it true that every maximal outerplanar graph G of order n >= 7 satisfies
beta'(G) <= ceil(n/2)?

Here a set W of vertices is a *fault-tolerant resolving set* if every two distinct vertices
u, v are distinguished by at least two vertices w in W, that is, d(w,u) != d(w,v); beta'(G) is
the minimum size of such a set. The paper proves beta'(G) <= ceil(2n/3) for n >= 5 and shows
that fans attain ceil(n/2).

## Result

We believe the following theorem answers Open problem 4 in the affirmative. The proof is
computer-assisted and has not been refereed.

**Theorem.** Every maximal outerplanar graph of order n >= 7 has a fault-tolerant resolving
set of size ceil(n/2). Hence beta'(G) <= ceil(n/2), and the bound is attained by fans.

The set is explicit. Label the boundary Hamilton cycle 0, 1, ..., n-1. For even n, either
perfect matching of the boundary cycle has a transversal (one vertex from each pair) that is
a fault-tolerant resolving set. For odd n, the same holds after taking one ear as a singleton
and pairing the remaining vertices consecutively. `code/construct.py` computes such a set
without any search.

## How the proof works

The full argument is in [proof.md](proof.md).

1. A transversal of boundary pairs dominates the graph. A dominating set distinguishes every
   pair at distance at least three twice (Lemma 1), so only pairs at distance one or two remain.
2. A maximal outerplanar graph is built by gluing two rooted pieces along a triangle. For such a
   piece, a finite *metric state* records what the rest of the graph can still learn about the
   near pairs: root-distance profiles, responses of the selected vertices, and how many more
   witnesses each unresolved pair needs (counted up to two).
3. The state of a glued piece is determined by the states of its two children (exact
   composition), and is monotone. This reduces the problem to finitely many *types*.
4. A finite certificate lists 168 types, 2,521 representative states and, for all 28,224
   ordered pairs of types, a target type with 281,843 explicit witnesses. Induction on the
   order then gives the theorem for every n >= 7.

The mathematical (non-computational) part of the proof covers steps 1-3 and the induction; the computer checks only the finite
premises of Section 7 of [proof.md](proof.md). Section 10 there lists exactly which part is
proved mathematically and which part is checked by the computer. The verifier recomputes graph
distances on representative graphs. It does not use the program that found the certificate,
and does not implement the composition formulas.

## Checking it

Python 3.10 or later (tested with CPython 3.13.1), standard library only; use `python3` where `python` is not Python 3. From the repository root:

```sh
cd code
python -I verify_universal.py
python -B negative_controls.py
```

The verifier checks the whole certificate in about one minute and ends with a line starting
`{"status": "PASS", "closed": true, ...` (exit code 0). The nine negative controls (eight corrupted certificates, and a run with Python assertions
disabled) confirm that each is rejected. Expected outputs,
running times and SHA-256 digests are in [verification.md](verification.md).

## Computation

Separately from the proof, beta' was computed exactly for every maximal outerplanar graph
(up to isomorphism) by two independently written programs: one for orders 7 to 21
(58,825,433 graphs), the other for orders 5 to 25 (9,507,058,998 graphs). For n >= 7 no graph
exceeds ceil(n/2).
Details and the code are in [computation.md](computation.md).

## Lean

[lean.md](lean.md) describes a partial formalization in Lean 4 with Mathlib (no `sorry`,
axioms only `propext`, `Classical.choice`, `Quot.sound`). It proves the definitions and basic
facts (the two equivalent definitions of fault-tolerant resolving sets, and agreement of a
computable distance with Mathlib's graph distance). It also checks 42 supplied examples of
order 7 and 132 of order 8. **The theorem for all orders is not formalized**, and the
completeness of the example lists is not proved in Lean.

## Prior work and novelty

The question was posed on 9 October 2026 in arXiv:2610.13374v1. On 13 October 2026 we found
no later version of the paper, no paper citing it (Semantic Scholar), and no other paper on
arXiv about the fault-tolerant metric dimension of outerplanar graphs. We did not search Google
Scholar. We do not claim more than this: the result may be known to the authors or others.

## How this was made

The proof, the certificate, the verifier, the Lean files and one of the two exhaustive
computations (`computation/gpt-independent/`) were written by an AI system (OpenAI GPT, through Codex). The other exhaustive
computation (`computation/claude-rust/`) and independent reviews of the proof, the certificate and the verifier
were done with another AI system (Anthropic Claude). The author directed the work and checked
the reports, but is not a specialist in this area. Please read the documents with this in mind.

## Contents

```
README.md, LICENSE
proof.md            the proof
verification.md     how to run the verifier and the negative controls, with expected output
code/               verifier, certificate, negative controls, construction
computation.md      exhaustive computations for small orders
computation/        code and logs for computation.md
lean.md             partial Lean 4 formalization (sources in the lean directory)
```

## Author

Hirotaka Shimizu

## License

MIT (see LICENSE).
