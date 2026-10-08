import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Tactic

/-!
Algebraic steps of the candidate proof. These theorems do not assume or prove
the geometric recovery of the hypotheses from equality of covariograms.
-/
namespace CovariogramCheck

/-- Equal sums and products recover an unordered pair, including repeated roots. -/
theorem pair_from_sum_product {a b p q : ℝ}
    (hs : p + q = a + b) (hp : p * q = a * b) :
    (p = a ∧ q = b) ∨ (p = b ∧ q = a) := by
  have hsp : p * (p + q) = p * (a + b) := congrArg (p * ·) hs
  have hz : (p - a) * (p - b) = 0 := by nlinarith [hsp]
  rcases mul_eq_zero.mp hz with h | h
  · left
    constructor <;> linarith
  · right
    constructor <;> linarith

/-- The logarithmic ratio used in the manuscript, expressed in area densities. -/
noncomputable def gamma (p q w : ℝ) : ℝ :=
  (Real.log p - Real.log q) / (2 * w)

theorem gamma_swap (p q w : ℝ) : gamma q p w = -gamma p q w := by
  unfold gamma
  ring

theorem gamma_eq_zero_iff {p q w : ℝ} (hp : 0 < p) (hq : 0 < q)
    (hw : w ≠ 0) : gamma p q w = 0 ↔ p = q := by
  unfold gamma
  rw [div_eq_zero_iff]
  have hden : 2 * w ≠ 0 := mul_ne_zero (by norm_num) hw
  simp only [hden, or_false, sub_eq_zero]
  exact Real.log_injOn_pos.eq_iff hp hq

/-- The ordered logarithmic ratio selects one member of the unordered pair. -/
theorem ordered_pair_from_gamma {a b p q w : ℝ}
    (ha : 0 < a) (hb : 0 < b) (hw : w ≠ 0)
    (hpair : (p = a ∧ q = b) ∨ (p = b ∧ q = a))
    (hg : gamma p q w = gamma a b w) : p = a ∧ q = b := by
  rcases hpair with h | ⟨hp, hq⟩
  · exact h
  · rw [hp, hq, gamma_swap] at hg
    have hz : gamma a b w = 0 := by linarith
    have hab := (gamma_eq_zero_iff ha hb hw).mp hz
    exact ⟨hp.trans hab.symm, hq.trans hab⟩

theorem reversed_pair_from_gamma {a b p q w : ℝ}
    (ha : 0 < a) (hb : 0 < b) (hw : w ≠ 0)
    (hpair : (p = a ∧ q = b) ∨ (p = b ∧ q = a))
    (hg : gamma p q w = -gamma a b w) : p = b ∧ q = a := by
  apply ordered_pair_from_gamma hb ha hw hpair.symm
  exact hg.trans (gamma_swap a b w).symm

theorem scalar_is_sign {c g d : ℝ} (hg : g ≠ 0)
    (ht : d = c * g) (hs : d = g ∨ d = -g) : c = 1 ∨ c = -1 := by
  rcases hs with hs | hs
  · left
    apply (mul_right_cancel₀ hg)
    simpa only [one_mul] using ht.symm.trans hs
  · right
    apply (mul_right_cancel₀ hg)
    simpa only [neg_one_mul] using ht.symm.trans hs

/-- Exact coefficient in the independent finite-difference check. -/
theorem finite_difference_kernel (x t y : ℝ) (h₁ : x^2 + t^2 ≠ 0)
    (h₂ : x^2 + 4*t^2 ≠ 0) :
    -4*y*(2*t)/(x^2+(2*t)^2) - 2*(-4*y*t/(x^2+t^2)) =
      24*y*t^3/((x^2+t^2)*(x^2+4*t^2)) := by
  have he : (2*t)^2 = 4*t^2 := by ring
  rw [he]
  field_simp [h₁, h₂]
  ring

end CovariogramCheck
