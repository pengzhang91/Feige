import Feige.GrunbaumSimplexProperty
import Feige.PaperAssembly

/-!
# Sharp unit-slack Feige main theorem

All probabilistic, analytic, and geometric inputs are discharged here.
-/

namespace Feige

/-- The fully assembled sharp fixed-dimensional Feige bound in every
positive dimension. -/
theorem sharp_unit_slack_feige_complete
    {n : ℕ} (hn : 0 < n) :
    IsOptimalFixedDimensionalFeigeBound n (sharpConstant n) := by
  exact sharp_unit_slack_feige hn
    (simplexCentroidHalfspaceProperty_fin hn)

end Feige
