# Formalization coverage

This file records the mathematical boundary of each independently buildable
target.  It distinguishes a machine-checked main theorem from historical,
statistical, and expository material in the cited papers.

## Vlassis--Thomas

The source is Nikos Vlassis and Philip S. Thomas,
[*An Exact Distribution-Free Test for Means of Nonnegative Random
Variables*](https://arxiv.org/abs/2607.08415), arXiv:2607.08415v1.

The public theorem `VlassisThomas.exactCalibration` formalizes Theorem 1 of
that paper.  Its proof includes the complete chain needed for Theorem 1:

| Paper result | Lean implementation |
|---|---|
| Exponential definition of `K` and coordinatewise monotonicity | `Feige.KStatistic` |
| Lemma 2 (monotonicity on the Boolean lattice) | `Feige.TwoPoint` |
| Proposition 3 (two-point validity) | `Feige.OrderedTwoPointInduction`, `Feige.TwoPointReindex`, `Feige.TwoPointBoundary` |
| Lemma 5 (exponential transfer) | `Feige.Lemma43FiniteSigned` and its analytic dependencies |
| Lemma 6 (local insertion) | `Feige.InsertionAlgebra`, `Feige.InsertionExpectation`, `Feige.StrictLocalInsertion` |
| Lemma 7 (two-point mixture) | `Feige.TwoPointMixture`, `Feige.MeasurableTwoPointKernel` |
| Reduction to arbitrary independent nonnegative marginals | `Feige.IndependentCalibrationAssembly` |

The implementation sometimes proves an equivalent boundary case by a
different route: zero lower-side parameters in Proposition 3 are handled by
finite-dimensional continuity rather than by deleting deterministic
coordinates.

The standalone target takes the paper's equivalent independent-exponential
formula as the definition of `K`.  The repository also proves that this equals
the original Dirichlet/uniform-simplex definition in
`Feige.SimplexExponentialIdentification`; that bridge lives in the Feige
assembly rather than in the probability-only `VlassisThomas` import closure.

The paper's Remark 4 is only partially represented.  The one-step,
payoff-independent insertion weights and their averaged domination inequality
are formalized in `Feige.InsertionAlgebra`.  The repository does not yet
construct the global random permutation law, independent of the payoff, that
simultaneously dominates every increasing payoff.

The introductory historical and asymptotic results, the interpretation as a
statistical decision procedure, and bibliographical remarks are not separate
Lean declarations.  They are not used by Theorem 1 or by the Feige result.

## Grünbaum

The `Grunbaum` target proves the centroid halfspace inequality for convex
bodies, the strict/open-boundary bridge used by the application, and the
simplex sharpness calculation.  It has no dependency on the Vlassis--Thomas
or Feige targets.

## Feige assembly

The `Feige` target combines:

1. `VlassisThomas.exactCalibration`;
2. the normalized-exponential identification of the Dirichlet statistic;
3. the specialized Grünbaum centroid-halfspace interface; and
4. the extremizing family proving optimality.

Its public theorem is `Feige.sharp_unit_slack_feige_complete`, defined in
`Feige/MainTheorem.lean`.  The preceding conditional assembly, with exact
calibration, simplex/exponential identification, and the centroid-halfspace
property as explicit hypotheses, is in `Feige/ConditionalMainTheorem.lean`.

## Kernel audit

The public theorems are checked by:

```bash
lake env lean VlassisThomas/Audit.lean
lake env lean Grunbaum/Audit.lean
lake env lean Feige/FinalAudit.lean
```

The intended output contains only Lean's standard logical foundations:
`propext`, `Classical.choice`, and `Quot.sound`.
