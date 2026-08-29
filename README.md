# Feige's 1/e Conjecture in Lean

This repository gives a machine-checked Lean formalization of the sharp
unit-slack (`delta = 1`) form of Feige's `1/e` conjecture. In every fixed
positive dimension `n`, it proves the stronger optimal bound
`(n / (n + 1))^n`, which implies the conjectured universal `1/e` bound.

The proof is presented in
[*Sharp Small-Deviation Inequalities for Sums of Independent Nonnegative
Random Variables*](https://arxiv.org/abs/2607.23980) by Weibo Fu, Yanjun Han,
Guanyang Wang, Jun Yan, Peng Zhang, and Zhengqing Zhou.

Specifically, it proves

$$
  \Pr \left[\sum_{i=1}^n X_i
    < \mathbb{E} \left(\sum_{i=1}^n X_i\right)+1\right]
  \ge \left(\frac{n}{n+1}\right)^n
$$

for any independent, nonnegative, integrable random variables satisfying
`E[Xᵢ] ≤ 1`. The constant is optimal for that fixed `n`.

The machine-checked entry point, defined in
[`Feige/MainTheorem.lean`](Feige/MainTheorem.lean), is:

```lean
theorem Feige.sharp_unit_slack_feige_complete
    {n : ℕ} (hn : 0 < n) :
    Feige.IsOptimalFixedDimensionalFeigeBound n
      (Feige.sharpConstant n)
```

## Palomar statement alignment

The registration surface keeps the advertised statement separate from the
proof development:

```text
Feige's original universal 1/e conjecture
        is implied by
Fu--Han--Wang--Yan--Zhang--Zhou, Theorem 1.1 at delta = 1
        is stated independently in
Challenge.lean: PalomarFeige.sharp_unit_slack_feige_complete
        is matched by Comparator to
Solution.lean: the same declaration and concrete definitions
        is proved through
Feige.sharp_unit_slack_feige_complete
```

The source paper treats every `delta > 0` and proves sharpness for
`delta >= 1`; this Lean entry treats only `delta = 1`, including optimality in
each fixed positive dimension. When every `E[X_i] = 1`, the threshold becomes
`n + 1`. The formalized constant `(n / (n + 1))^n` is strictly larger than
`exp (-1)` for finite positive `n` and converges to `exp (-1)`, so the result
implies the classical `1/e` conjecture.

The Palomar-facing files are:

| File | Role |
|---|---|
| [`Challenge.lean`](Challenge.lean) | Small Mathlib-only statement surface |
| [`Solution.lean`](Solution.lean) | Thin bridge to the completed proof |
| [`comparator.json`](comparator.json) | Declaration and axiom comparison configuration |
| [`formalization.yaml`](formalization.yaml) | Scope, sources, authorship, automation, and review record |

After author verification and a green Linux CI run, submit the exact
40-character commit SHA through the
[Palomar submission form](https://submit.palomar-registry.org/).

## Proof architecture

The proof of the Feige conjecture depends on two substantive
mathematical results:

1. the [Vlassis--Thomas exact Dirichlet calibration
   theorem](https://arxiv.org/abs/2607.08415) for independent nonnegative
   random variables; and
2. Grünbaum's centroid halfspace theorem, including the sharp simplex case.

This repository independently formalizes both results.  Each has its own
public interface, build target, and kernel-axiom audit.  A third block connects
them through the normalized-exponential/simplex identification and assembles
the Feige theorem.

### Three independently buildable blocks

| Block | Public entry point | Build command |
|---|---|---|
| Vlassis--Thomas exact calibration | `VlassisThomas.exactCalibration` | `lake build VlassisThomas` |
| Grünbaum centroid halfspace theorem | `Grunbaum.lean` | `lake build Grunbaum` |
| Feige deduction and final assembly | `Feige.sharp_unit_slack_feige_complete` | `lake build Feige` |

The Vlassis--Thomas block reconstructs the main theorem of
Nikos Vlassis and Philip S. Thomas,
[*An Exact Distribution-Free Test for Means of Nonnegative Random Variables*](https://arxiv.org/abs/2607.08415).
It contains the two-point reduction, calibrated chains, exponential transfer,
local insertion, boundary approximation, measurable two-point mixing, and the
reduction to arbitrary independent nonnegative marginals.

The Grünbaum block proves the centroid halfspace inequality and its sharp
simplex model.  The Feige block uses only the public exact-calibration theorem,
the normalized-exponential/simplex identification, and the specialized
Grünbaum interface.  The intermediate theorem in
[`Feige/ConditionalMainTheorem.lean`](Feige/ConditionalMainTheorem.lean)
exposes those three structural inputs explicitly; `Feige/MainTheorem.lean`
discharges all three.

Here, “independently buildable” refers to theorem and build-target boundaries;
the targets share internal utility modules.  A theorem-by-theorem account,
including the precise scope of the Vlassis--Thomas reconstruction, is in
[`FORMALIZATION.md`](FORMALIZATION.md).

## Reproducible build

The repository pins Lean and Mathlib:

- Lean `v4.31.0`
- Mathlib tag `v4.31.0`
- Mathlib commit `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`

From a fresh clone:

```bash
lake exe cache get
lake build VlassisThomas
lake build Grunbaum
lake build Feige
lake build Challenge
lake build Solution
```

Running `lake build` builds all five default targets.

## Proof audit

The three public results have dedicated kernel-axiom audits:

```bash
lake env lean VlassisThomas/Audit.lean
lake env lean Grunbaum/Audit.lean
lake env lean Feige/FinalAudit.lean
```

The final theorem uses only Lean's standard logical foundations:
`propext`, `Classical.choice`, and `Quot.sound`. The substantive proof
development contains no `sorry`, `admit`, `sorryAx`, or project-defined axiom.
`Challenge.lean` contains exactly one deliberate theorem placeholder, as
required by the statement/proof separation; CI rejects such placeholders in
every other Lean file.

On Linux, the same pinned Comparator, lean4export, NanoDa, and Landrun stack
used by Palomar's template can be run with:

```bash
bash scripts/verify-comparator.sh
```

GitHub Actions runs this independent statement comparison and NanoDa replay.

## Scope

The final theorem is stated for positive finite dimensions and
small-universe probability spaces (`Ω : Type`).  It uses pointwise
nonnegativity and measurable, integrable representatives of the random
variables, coordinatewise means at most one, and a strict probability event.
It does not formalize the source paper's cases `delta != 1`.

## Related work

Contemporaneous independent work includes
[Nie--Wei](https://arxiv.org/abs/2607.24528) on the sharp equal-means
unit-slack bound and [Stander](https://doi.org/10.5281/zenodo.21626794) on a
conditional sharp finite-dimensional bound. [Zhi Ling](https://arxiv.org/abs/2608.18392)
later proved a broader sharp form of Samuels' conjecture from which Feige's
conjecture follows. None of these works is used by this Lean development.

## Attribution

- The formalization authors and maintainers are Guanyang Wang and Peng Zhang.
  AI and automation provenance is recorded separately in
  [`formalization.yaml`](formalization.yaml).
- The exact calibration theorem and its proof strategy are due to Nikos
  Vlassis and Philip S. Thomas (arXiv:2607.08415).
- The centroid halfspace theorem is due to Branko Grünbaum,
  *Pacific Journal of Mathematics* 10 (1960), 1257--1261.
- The Brunn--Minkowski support files under `LeanPool/Isoperimetric/` are from
  `Vilin97/lean-pool`; see [`NOTICE.md`](NOTICE.md).

## License

Apache License 2.0.  See [`LICENSE`](LICENSE) and [`NOTICE.md`](NOTICE.md).
