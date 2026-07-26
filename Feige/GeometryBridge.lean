import Feige.KStatistic
import Feige.Reduction
import Feige.SimplexMeasure

/-!
# From simplex geometry to the exponential statistic

The paper uses two equivalent presentations of `K`: normalized simplex
volume (equation (3)) and independent exponentials (equation (4)).  This
file records the identification as a named property and proves that, once it
is available, the specialized centroid-halfspace theorem supplies exactly
the `LargeSumBridge` consumed by the final reduction.
-/

namespace Feige

/-- Equality of the simplex-volume and exponential presentations of the
Dirichlet statistic. -/
def SimplexExponentialIdentification (n : ℕ) : Prop :=
  ∀ y : Fin n → ℝ, dirichletK y = simplexK y

/-- Proposition 2.3 for `dirichletK`, reduced to the two precise geometric
inputs: the distributional identification and the simplex centroid
halfspace bound. -/
theorem dirichletK_largeSumBridge_of_simplex
    {n : ℕ} (hid : SimplexExponentialIdentification n)
    (hcentroid : SimplexCentroidHalfspaceProperty (ι := Fin n)) :
    LargeSumBridge (dirichletK : (Fin n → ℝ) → ℝ) := by
  intro y hy hsum
  rw [hid y]
  simpa using
    (simplex_largeSumBridge hcentroid y hy (by simpa using hsum))

end Feige
