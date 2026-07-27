import VlassisThomas
import Feige.ConditionalMainTheorem
import Feige.SimplexExponentialIdentification

/-!
# Final assembly of the unit-slack theorem

This module combines the Vlassis--Thomas calibration theorem (Theorem 2.1)
with the simplex/exponential identification for the statistic in (2.1).
The remaining parameter is the `α = 0` centroid-halfspace bound used by the
`δ = 1` specialization of the geometric argument in §2.2.
-/

namespace Feige

/-- The `δ = 1` specialization of Theorem 1.1 with the probabilistic block
fully discharged. -/
theorem sharp_unit_slack_feige
    {n : ℕ} (hn : 0 < n)
    (hcentroid : SimplexCentroidHalfspaceProperty (ι := Fin n)) :
    IsOptimalFixedDimensionalFeigeBound n (sharpConstant n) := by
  exact sharp_unit_slack_feige_of_paper_inputs hn
    VlassisThomas.exactCalibration
    (simplexExponentialIdentification n) hcentroid

end Feige
