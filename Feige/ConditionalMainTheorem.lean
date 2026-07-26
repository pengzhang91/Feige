import Feige.GeometryBridge
import Feige.Sharpness

/-!
# Conditional assembly of the sharp unit-slack theorem

This module states the paper's main result in terms of its three remaining
structural inputs.  The reduction and extremal construction are fully
discharged: exact calibration, the simplex/exponential identification, and
the specialized centroid-halfspace inequality are the only inputs.
-/

namespace Feige

/-- Theorem 1.1, assembled from the exact calibration theorem and the two
geometric facts identifying and bounding the Dirichlet statistic. -/
theorem sharp_unit_slack_feige_of_paper_inputs
    {n : ℕ} (hn : 0 < n)
    (hcal : UniversalCalibration
      (dirichletK : (Fin n → ℝ) → ℝ))
    (hid : SimplexExponentialIdentification n)
    (hcentroid : SimplexCentroidHalfspaceProperty (ι := Fin n)) :
    IsOptimalFixedDimensionalFeigeBound n (sharpConstant n) := by
  exact sharpConstant_is_optimal_of_structural_inputs hn
    (dirichletK : (Fin n → ℝ) → ℝ) hcal
    (dirichletK_largeSumBridge_of_simplex hid hcentroid)

end Feige
