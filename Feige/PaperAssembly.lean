import VlassisThomas
import Feige.ConditionalMainTheorem
import Feige.SimplexExponentialIdentification

/-!
# Final assembly of the sharp theorem

This module combines the public Vlassis--Thomas exact-calibration theorem
with the simplex/exponential identification.  The remaining parameter is
the specialized centroid-halfspace fact supplied by the independent
Grünbaum block.
-/

namespace Feige

/-- The sharp theorem with the probabilistic block fully discharged. -/
theorem sharp_unit_slack_feige
    {n : ℕ} (hn : 0 < n)
    (hcentroid : SimplexCentroidHalfspaceProperty (ι := Fin n)) :
    IsOptimalFixedDimensionalFeigeBound n (sharpConstant n) := by
  exact sharp_unit_slack_feige_of_paper_inputs hn
    VlassisThomas.exactCalibration
    (simplexExponentialIdentification n) hcentroid

end Feige
