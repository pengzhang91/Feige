import Feige.GrunbaumSimplexProperty
import Feige.PaperAssembly

/-!
# The unit-slack case of the sharp Feige main theorem

All probabilistic, analytic, and geometric inputs for the `δ = 1`
specialization of Theorem 1.1 are discharged here.
-/

namespace Feige

/-- The fully assembled `δ = 1` sharp fixed-dimensional bound from
Theorem 1.1, in every positive dimension. -/
theorem sharp_unit_slack_feige_complete
    {n : ℕ} (hn : 0 < n) :
    IsOptimalFixedDimensionalFeigeBound n (sharpConstant n) := by
  exact sharp_unit_slack_feige hn
    (simplexCentroidHalfspaceProperty_fin hn)

end Feige
