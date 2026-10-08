import Mathlib.Analysis.Analytic.Uniqueness
import Mathlib.Tactic

open Set Filter
open scoped Topology

namespace CovariogramCheck

/-- Identity-principle argument for the branch choice, on a connected open
subset of a real normed space. Applying it to sphere charts or radially
extended branches is a separate obligation, not assumed to be done here. -/
theorem analytic_factor_choice {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    {U : Set E} (hUo : IsOpen U) (hUc : IsPreconnected U)
    {P Q : E → ℂ} (hP : AnalyticOnNhd ℝ P U) (hQ : AnalyticOnNhd ℝ Q U)
    (hzero : ∀ x ∈ U, P x * Q x = 0) :
    (∀ x ∈ U, P x = 0) ∨ (∀ x ∈ U, Q x = 0) := by
  classical
  by_cases hp : ∀ x ∈ U, P x = 0
  · exact Or.inl hp
  · right
    push_neg at hp
    obtain ⟨x, hx, hpx⟩ := hp
    have hn : ∀ᶠ y in 𝓝 x, P y ≠ 0 :=
      (hP x hx).continuousAt.eventually_ne hpx
    have hq : Q =ᶠ[𝓝 x] (fun _ => 0) := by
      filter_upwards [hUo.mem_nhds hx, hn] with y hy hpy
      exact (mul_eq_zero.mp (hzero y hy)).resolve_left hpy
    exact hQ.eqOn_of_preconnected_of_eventuallyEq analyticOnNhd_const hUc hx hq

end CovariogramCheck
