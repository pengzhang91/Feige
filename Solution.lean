import Feige.MainTheorem

/-!
# Sharp unit-slack Feige inequality: proved solution

This module reproduces the complete advertised statement from `Challenge` and
connects it to the substantive proof development. Comparator checks the two
declarations and all concrete definitions occurring in their types.
-/

open scoped BigOperators
open MeasureTheory ProbabilityTheory

namespace PalomarFeige

/-- The proposed sharp constant for the unit-slack inequality in dimension
`n`: `((n : ℝ) / (n + 1)) ^ n`. -/
noncomputable def sharpConstant (n : ℕ) : ℝ :=
  ((n : ℝ) / (n + 1)) ^ n

/-- `FixedDimensionalFeigeLowerBound n c` means that `c` is a universal lower
bound for the strict unit-slack event in dimension `n`. It quantifies over all
small-universe probability spaces and all measurable, integrable, independent,
pointwise nonnegative random variables whose individual expectations are at
most one. -/
def FixedDimensionalFeigeLowerBound (n : ℕ) (c : ℝ) : Prop :=
  letI : NormedSpace ℝ ℝ := NormedField.toNormedSpace
  ∀ (Ω : Type) (_mΩ : MeasurableSpace Ω) (μ : Measure Ω)
      (_hμ : IsProbabilityMeasure μ) (X : Fin n → Ω → ℝ),
    (∀ i, Measurable (X i)) →
    (∀ i, Integrable (X i) μ) →
    iIndepFun X μ →
    (∀ i ω, 0 ≤ X i ω) →
    (∀ i, (∫ ω, X i ω ∂μ) ≤ 1) →
    c ≤ μ.real
      {ω | (∑ i, X i ω) < (∫ ω', ∑ i, X i ω' ∂μ) + 1}

/-- A fixed-dimensional lower bound is optimal if it is valid and every other
valid universal lower bound is no larger. -/
def IsOptimalFixedDimensionalFeigeBound (n : ℕ) (c : ℝ) : Prop :=
  FixedDimensionalFeigeLowerBound n c ∧
    ∀ d : ℝ, FixedDimensionalFeigeLowerBound n d → d ≤ c

/-- In every positive finite dimension, `((n : ℝ) / (n + 1)) ^ n` is the
optimal universal lower bound for the strict unit-slack event. -/
theorem sharp_unit_slack_feige_complete
    {n : ℕ} (hn : 0 < n) :
    IsOptimalFixedDimensionalFeigeBound n (sharpConstant n) := by
  change Feige.IsOptimalFixedDimensionalFeigeBound n
    (Feige.sharpConstant n)
  exact Feige.sharp_unit_slack_feige_complete hn

end PalomarFeige
