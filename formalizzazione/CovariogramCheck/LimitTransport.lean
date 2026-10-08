import CovariogramCheck.Algebra
import Mathlib.MeasureTheory.Measure.OpenPos
import Mathlib.Topology.Instances.Real.Lemmas

open Filter MeasureTheory
open scoped Topology

namespace CovariogramCheck

/-- The last limit argument of the transport lemma. Its hypotheses are the
asymptotic identity and the endpoint limits, NOT equality of covariograms.
The geometric/Fourier derivation of those hypotheses remains to be formalized. -/
theorem common_scalar_of_limits {U : Type*} (G : Set U)
    (g ell : U → ℝ) (M : ℝ → ℝ) (B : U → ℝ → ℝ)
    (u₀ : U) (hu₀ : u₀ ∈ G) (hg₀ : g u₀ ≠ 0)
    (hlim : ∀ u ∈ G, Tendsto (B u) atTop (𝓝 (ell u)))
    (hrem : ∀ u ∈ G,
      Tendsto (fun t => B u t - g u * M t) atTop (𝓝 0)) :
    ∃ c : ℝ, Tendsto M atTop (𝓝 c) ∧ ∀ u ∈ G, ell u = g u * c := by
  have hprod (u : U) (hu : u ∈ G) :
      Tendsto (fun t => g u * M t) atTop (𝓝 (ell u)) := by
    have h := (hlim u hu).sub (hrem u hu)
    simp only [sub_zero] at h
    convert h using 1
    funext t
    ring
  have hM : Tendsto M atTop (𝓝 (ell u₀ / g u₀)) := by
    have h := (hprod u₀ hu₀).div_const (g u₀)
    convert h using 1
    funext t
    field_simp
  refine ⟨ell u₀ / g u₀, hM, ?_⟩
  intro u hu
  exact tendsto_nhds_unique (hprod u hu) (tendsto_const_nhds.mul hM)

theorem limit_abs_le_one {M mass : ℝ → ℝ} {c : ℝ}
    (hM : Tendsto M atTop (𝓝 c)) (hs : Tendsto mass atTop (𝓝 1))
    (hb : ∀ᶠ t in atTop, |M t| ≤ mass t) : |c| ≤ 1 := by
  exact le_of_tendsto_of_tendsto hM.abs hs hb

/-- A single scalar cannot implement different local signs on nonzero data.
The full-support measure hypothesis makes the exceptional null set harmless. -/
theorem scalar_is_sign_ae {U : Type*} [TopologicalSpace U] [MeasurableSpace U]
    (μ : Measure U) [μ.IsOpenPosMeasure]
    (g d : U → ℝ) (c : ℝ) (hg : Continuous g)
    (hne : ∃ u, g u ≠ 0)
    (ht : ∀ᵐ u ∂μ, d u = c * g u)
    (hs : ∀ᵐ u ∂μ, d u = g u ∨ d u = -g u) : c = 1 ∨ c = -1 := by
  by_contra hc
  have hz : g =ᵐ[μ] (fun _ => 0) := by
    filter_upwards [ht, hs] with u hut hus
    by_contra hgu
    exact hc (scalar_is_sign hgu hut hus)
  have hfun : g = (fun _ => 0) :=
    (hg.ae_eq_iff_eq μ continuous_const).mp hz
  obtain ⟨u, hu⟩ := hne
  exact hu (congrFun hfun u)

/-- The density conclusion of the candidate proof, conditional on the two
central lemma outputs. This is not the convex-body uniqueness theorem. -/
theorem density_orientation_ae {U : Type*} [TopologicalSpace U] [MeasurableSpace U]
    (μ : Measure U) [μ.IsOpenPosMeasure]
    (a b p q w : U → ℝ) (c : ℝ)
    (ha : ∀ u, 0 < a u) (hb : ∀ u, 0 < b u) (hw : ∀ u, w u ≠ 0)
    (hg : Continuous (fun u => gamma (a u) (b u) (w u)))
    (hne : ∃ u, gamma (a u) (b u) (w u) ≠ 0)
    (hpair : ∀ᵐ u ∂μ, (p u = a u ∧ q u = b u) ∨ (p u = b u ∧ q u = a u))
    (ht : ∀ᵐ u ∂μ,
      gamma (p u) (q u) (w u) = c * gamma (a u) (b u) (w u)) :
    (p =ᵐ[μ] a ∧ q =ᵐ[μ] b) ∨ (p =ᵐ[μ] b ∧ q =ᵐ[μ] a) := by
  have hs : ∀ᵐ u ∂μ,
      gamma (p u) (q u) (w u) = gamma (a u) (b u) (w u) ∨
      gamma (p u) (q u) (w u) = -gamma (a u) (b u) (w u) := by
    filter_upwards [hpair] with u hu
    rcases hu with ⟨hp, hq⟩ | ⟨hp, hq⟩
    · exact Or.inl (by rw [hp, hq])
    · exact Or.inr (by rw [hp, hq, gamma_swap])
  rcases scalar_is_sign_ae μ _ _ c hg hne ht hs with hc | hc
  · left
    have ho : ∀ᵐ u ∂μ, p u = a u ∧ q u = b u := by
      filter_upwards [hpair, ht] with u hu htu
      apply ordered_pair_from_gamma (ha u) (hb u) (hw u) hu
      simpa only [hc, one_mul] using htu
    exact ⟨ho.mono (fun _ h => h.1), ho.mono (fun _ h => h.2)⟩
  · right
    have ho : ∀ᵐ u ∂μ, p u = b u ∧ q u = a u := by
      filter_upwards [hpair, ht] with u hu htu
      apply reversed_pair_from_gamma (ha u) (hb u) (hw u) hu
      simpa only [hc, neg_one_mul] using htu
    exact ⟨ho.mono (fun _ h => h.1), ho.mono (fun _ h => h.2)⟩

end CovariogramCheck
