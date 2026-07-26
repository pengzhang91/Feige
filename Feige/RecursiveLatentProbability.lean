import Feige.ProductTwoPointKernel

/-!
# Probability instance for the recursive latent product
-/

open MeasureTheory

namespace Feige

noncomputable section

instance recursiveAugmentedLatent_isProbability
    (n : ℕ)
    (latent : Fin n → Measure AugmentedTwoPointParams)
    [∀ i, IsProbabilityMeasure (latent i)] :
    IsProbabilityMeasure (recursiveAugmentedLatent n latent) := by
  induction n with
  | zero =>
      unfold recursiveAugmentedLatent
      infer_instance
  | succ n ih =>
      letI : ∀ i : Fin n,
          IsProbabilityMeasure (latent (Fin.succ i)) :=
        fun i ↦ inferInstance
      letI : IsProbabilityMeasure
          (recursiveAugmentedLatent n
            (fun i ↦ latent (Fin.succ i))) :=
        ih (fun i ↦ latent (Fin.succ i))
      unfold recursiveAugmentedLatent
      exact Measure.isProbabilityMeasure_map
        (finHeadTailEquiv AugmentedTwoPointParams n).symm.measurable.aemeasurable

end

end Feige
