import CovariogramCheck.LimitTransport
import Mathlib.MeasureTheory.Measure.WithDensity

open Filter MeasureTheory
open scoped Topology

namespace CovariogramCheck

/-- The final density argument, including the case of identically zero
asymmetry. The sum, product and transport identities remain explicit premises;
their derivation from equality of covariograms is not asserted here. -/
theorem density_orientation_of_sum_product_transport
    {U : Type*} [TopologicalSpace U] [MeasurableSpace U]
    (μ : Measure U) [μ.IsOpenPosMeasure]
    (a b p q w : U → ℝ) (c : ℝ)
    (ha : ∀ u, 0 < a u) (hb : ∀ u, 0 < b u) (hw : ∀ u, w u ≠ 0)
    (hg : Continuous (fun u => gamma (a u) (b u) (w u)))
    (hs : ∀ᵐ u ∂μ, p u + q u = a u + b u)
    (hp : ∀ᵐ u ∂μ, p u * q u = a u * b u)
    (ht : ∀ᵐ u ∂μ,
      gamma (p u) (q u) (w u) = c * gamma (a u) (b u) (w u)) :
    (p =ᵐ[μ] a ∧ q =ᵐ[μ] b) ∨ (p =ᵐ[μ] b ∧ q =ᵐ[μ] a) := by
  have hpair : ∀ᵐ u ∂μ,
      (p u = a u ∧ q u = b u) ∨ (p u = b u ∧ q u = a u) := by
    filter_upwards [hs, hp] with u hus hup
    exact pair_from_sum_product hus hup
  by_cases hne : ∃ u, gamma (a u) (b u) (w u) ≠ 0
  · exact density_orientation_ae μ a b p q w c ha hb hw hg hne hpair ht
  · have heq (u : U) : a u = b u := by
      apply (gamma_eq_zero_iff (ha u) (hb u) (hw u)).mp
      by_contra hu
      exact hne ⟨u, hu⟩
    left
    have ho : ∀ᵐ u ∂μ, p u = a u ∧ q u = b u := by
      filter_upwards [hpair] with u hu
      rcases hu with h | ⟨hpu, hqu⟩
      · exact h
      · exact ⟨hpu.trans (heq u).symm, hqu.trans (heq u)⟩
    exact ⟨ho.mono (fun _ h => h.1), ho.mono (fun _ h => h.2)⟩

/-- Equality of density-defined measures, not an assertion that those
measures have already been identified with convex-body surface area measures. -/
theorem measure_orientation_of_sum_product_transport
    {U : Type*} [TopologicalSpace U] [MeasurableSpace U]
    (μ : Measure U) [μ.IsOpenPosMeasure]
    (a b p q w : U → ℝ) (c : ℝ)
    (ha : ∀ u, 0 < a u) (hb : ∀ u, 0 < b u) (hw : ∀ u, w u ≠ 0)
    (hg : Continuous (fun u => gamma (a u) (b u) (w u)))
    (hs : ∀ᵐ u ∂μ, p u + q u = a u + b u)
    (hp : ∀ᵐ u ∂μ, p u * q u = a u * b u)
    (ht : ∀ᵐ u ∂μ,
      gamma (p u) (q u) (w u) = c * gamma (a u) (b u) (w u)) :
    (μ.withDensity (fun u => ENNReal.ofReal (p u)) =
       μ.withDensity (fun u => ENNReal.ofReal (a u)) ∧
     μ.withDensity (fun u => ENNReal.ofReal (q u)) =
       μ.withDensity (fun u => ENNReal.ofReal (b u))) ∨
    (μ.withDensity (fun u => ENNReal.ofReal (p u)) =
       μ.withDensity (fun u => ENNReal.ofReal (b u)) ∧
     μ.withDensity (fun u => ENNReal.ofReal (q u)) =
       μ.withDensity (fun u => ENNReal.ofReal (a u))) := by
  have hd := density_orientation_of_sum_product_transport μ a b p q w c ha hb hw hg hs hp ht
  rcases hd with ⟨hpa, hqb⟩ | ⟨hpb, hqa⟩
  · exact Or.inl ⟨withDensity_congr_ae (hpa.fun_comp ENNReal.ofReal),
      withDensity_congr_ae (hqb.fun_comp ENNReal.ofReal)⟩
  · exact Or.inr ⟨withDensity_congr_ae (hpb.fun_comp ENNReal.ofReal),
      withDensity_congr_ae (hqa.fun_comp ENNReal.ofReal)⟩

end CovariogramCheck
