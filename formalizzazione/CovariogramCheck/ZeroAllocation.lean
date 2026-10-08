import CovariogramCheck.AnalyticChoice
import Mathlib.Analysis.Calculus.Deriv.Mul

namespace CovariogramCheck

/-- A simple zero of a product belongs to exactly one of the factors.
This checks the multiplicity argument used at a nonreal branch value. -/
theorem simple_product_root_allocation {F G : ℂ → ℂ} {z f' g' h' : ℂ}
    (hF : HasDerivAt F f' z) (hG : HasDerivAt G g' z)
    (hFG : HasDerivAt (fun w => F w * G w) h' z)
    (hsimple : h' ≠ 0) (hzero : F z * G z = 0) :
    (F z = 0 ∧ G z ≠ 0) ∨ (G z = 0 ∧ F z ≠ 0) := by
  have hn : ¬ (F z = 0 ∧ G z = 0) := by
    rintro ⟨hf, hg⟩
    have hd := (hF.mul hG).unique hFG
    apply hsimple
    simpa only [hf, hg, mul_zero, zero_mul, add_zero] using hd.symm
  rcases mul_eq_zero.mp hzero with hf | hg
  · exact Or.inl ⟨hf, fun hg => hn ⟨hf, hg⟩⟩
  · exact Or.inr ⟨hg, fun hf => hn ⟨hf, hg⟩⟩

/-- One point at which both factors cannot vanish makes the global analytic
choice exclusive. The geometric parametrization of the branches is separate. -/
theorem analytic_factor_choice_exclusive
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    {U : Set E} (hUo : IsOpen U) (hUc : IsPreconnected U)
    {P Q : E → ℂ} (hP : AnalyticOnNhd ℝ P U) (hQ : AnalyticOnNhd ℝ Q U)
    (hzero : ∀ x ∈ U, P x * Q x = 0)
    {x₀ : E} (hx : x₀ ∈ U) (hn : ¬ (P x₀ = 0 ∧ Q x₀ = 0)) :
    ((∀ x ∈ U, P x = 0) ∧ ¬ (∀ x ∈ U, Q x = 0)) ∨
    ((∀ x ∈ U, Q x = 0) ∧ ¬ (∀ x ∈ U, P x = 0)) := by
  rcases analytic_factor_choice hUo hUc hP hQ hzero with hp | hq
  · exact Or.inl ⟨hp, fun hq => hn ⟨hp x₀ hx, hq x₀ hx⟩⟩
  · exact Or.inr ⟨hq, fun hp => hn ⟨hp x₀ hx, hq x₀ hx⟩⟩

end CovariogramCheck
