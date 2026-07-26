import Feige.IndependentCalibrationAssembly
import Feige.TwoPointBoundary

/-!
# Exact calibration for means of nonnegative random variables

This is the public interface for the main theorem of Vlassis and Thomas,
*An Exact Distribution-Free Test for Means of Nonnegative Random Variables*
(arXiv:2607.08415).  Its implementation includes the two-point reduction,
chain calibration, exponential-transfer argument, boundary approximation,
measurable two-point mixing, and normalization to coordinatewise means at
most one.
-/

namespace VlassisThomas

/-- The Vlassis--Thomas exact calibration theorem, uniformly over
small-universe probability spaces. -/
theorem exactCalibration {n : ℕ} :
    Feige.UniversalCalibration
      (Feige.dirichletK : (Fin n → ℝ) → ℝ) :=
  Feige.universalCalibration_dirichletK_of_twoPointRejectionBound
    Feige.twoPointRejectionBound

end VlassisThomas
