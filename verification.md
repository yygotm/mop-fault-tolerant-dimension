# Reproducing the finite verification

## Environment and commands

Requires Python 3.10 or later (`int.bit_count`); tested with CPython 3.13.1 on Windows, using only the standard library. Use `python3` where `python` is not Python 3. No Python package installation is required. Run the following from the package root:

```sh
cd code
python -I verify_universal.py
python -B negative_controls.py
python -B construct.py --max-n 10 --fan-max-n 30 --random-count 20 --random-max-n 50
python -B construct.py --quiddity '[1,2,2,2,3,1,2,5]'
```

Use ordinary assertion-enabled Python. The verifier explicitly rejects `-O`. The negative-control program deliberately checks this rejection. Its own invocation must also keep assertions enabled. `-I` isolates the standalone verifier from user Python configuration; the other programs use sibling imports, so their commands use `-B` to avoid bytecode files. All certificate paths are relative to the current directory, except that negative controls locate the verifier and certificate next to their own script.

The verifier writes `universal-verification.json`; negative controls write `negative-controls.json`; the construction suite writes `construction-checks.json`. Negative-control certificate mutations are temporary and are removed after each test. These generated outputs are not required as inputs.

## Full certificate verification

The verifier exited with code **0**, checking all 28,224 ordered transitions and 281,843 transition witnesses. It reported **46.070 seconds**. The final output line was:

```json
{"status": "PASS", "closed": true, "base_counts": {"2": 1, "3": 1, "4": 2, "5": 5, "6": 14}, "types": 168, "large_types": 145, "representative_states": 2521, "accepting_types": 96, "ordered_binary_transitions": 28224, "transition_witnesses": 281843, "certificate_sha256": "38bff9e26a93c480c1326eeb1a531a6be898f414f6a07b4d94ba56cf90b4754a", "seconds": 46.06951000000117}
```

On another run, `seconds` will vary. The remaining fields should agree exactly, including `status: PASS`, `closed: true`, the base counts, type and witness counts, and the certificate digest. This is exhaustive verification of the finite certificate's closure conditions. Together with the mathematical lemmas and induction in [proof.md](proof.md), it supports the all-orders theorem; it is not a bounded graph enumeration claimed to cover all orders.

## Negative controls

The negative-control suite exited with code **0** in **31.161 seconds**. All nine deliberately invalid runs were rejected with exit code 1. Its final output line was:

```json
{"status": "PASS", "controls": [{"name": "selected-root-in-internal-set", "rejected": true, "returncode": 1, "expected_error": "AssertionError"}, {"name": "inflated-pair-witness-count", "rejected": true, "returncode": 1, "expected_error": "incorrect representative state"}, {"name": "missing-binary-transition", "rejected": true, "returncode": 1, "expected_error": "AssertionError"}, {"name": "wrong-target-order-parity", "rejected": true, "returncode": 1, "expected_error": "AssertionError", "rejecting_check": "assert (nt==n if n<=6 else nt>=7 and nt%2==n%2)", "mutation": {"transition": 9, "joined_order": 7, "target_order": 14}}, {"name": "missing-unique-accepting-state", "rejected": true, "returncode": 1, "expected_error": "missing accepting state", "mutation": {"record": 264, "order": 14, "bucket": 0, "entry": 0, "removed_entries": 1}}, {"name": "wrong-selected-set-size", "rejected": true, "returncode": 1, "expected_error": "AssertionError", "rejecting_check": "assert paired(n,start,selected_mask(n,w,a,b))", "mutation": {"record": 264, "order": 14, "required_size": 7, "before": 7, "after": 6}}, {"name": "missing-small-order-base", "rejected": true, "returncode": 1, "expected_error": "incomplete base", "mutation": {"record": 22, "order": 6, "removed_representatives": 1}}, {"name": "insufficient-transition-witness", "rejected": true, "returncode": 1, "expected_error": "transition dominance failed"}, {"name": "disabled-python-assertions", "rejected": true, "returncode": 1}]}
```

The nine controls cover an internal mask containing a root, an inflated pair counter, a missing transition, wrong target-order parity, deletion of the unique accepting state of a required type, an undersized selected set, deletion of a small base representative, an insufficient transition witness with valid indices, and disabled Python assertions. For the undersized-set control, deleting one landmark breaks the boundary-pair condition; rejection occurs there before the explicit cardinality assertion. The controls test rejection of these mutations, rather than exhaustively testing arbitrary malformed input.

## Construction checks

The bounded construction command above exited with code **0**. It checked all 125 isomorphism classes generated at orders 7 through 10, with counts 4, 12, 27, 82; fans at every order 7 through 30; and 20 pseudorandom triangulations generated with seed 261013374 and requested orders between 7 and 50. Its measured final line was:

```json
{"status": "PASS", "seconds": 0.4688375999976415}
```

The supplied quiddity example prints a JSON object with order 8, a selected vertex list of size 4, and `verified: true`. A quiddity entry is the number of triangles incident with that vertex; the list follows the cyclic boundary order. `Construction.construct` also accepts an adjacency list with vertices in that order and returns the selected original labels. `check.py` contains only the triangulation and quiddity utilities needed by the command-line interface.

These checks have distinct scopes: concrete examples give small-case consistency; the fan range is a bounded check within one fixed family; the order-7-to-10 loop is complete over that bounded enumeration; and the all-orders conclusion follows from the mathematical induction plus the finite certificate. Random examples establish only consistency for the generated samples. The Lean checks are described separately in [lean.md](lean.md), including their unproved enumeration completeness.

## SHA-256

These are hashes of the exact UTF-8 files in this package:

| File | SHA-256 |
|---|---|
| `proof.md` | `a1504a013b9cced94ebc96c0cf38dcfb36fa0b5f78807691202e050e5e48a556` |
| `code/verify_universal.py` | `8428b468abfa590fa9697af1aa15a0ed9dba2952f715312a451f9f55229cd201` |
| `code/universal-certificate.json` | `38bff9e26a93c480c1326eeb1a531a6be898f414f6a07b4d94ba56cf90b4754a` |

The certificate is the file that was reviewed by the second AI system (see "How this was made" in the README). The verifier differs from the reviewed file only in the first line of its docstring. Line endings in the package are LF.
