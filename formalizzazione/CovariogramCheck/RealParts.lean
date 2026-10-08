import Mathlib.Analysis.Normed.Group.Tannery
import Mathlib.Topology.Algebra.Order.Field
import Mathlib.Tactic

open Filter
open scoped Topology

namespace CovariogramCheck

/-- Perturbing a real part by a bounded amount admits a summable majorant.
This avoids differentiating an infinite series. -/
theorem rationalKernel_difference_bound {x a t D : ℝ}
    (hx : 0 < x) (ha : 0 < a) (ht : 0 < t) (hd : |x-a| ≤ D) :
    |t/(x^2+t^2) - t/(a^2+t^2)| ≤ D*(1/x^2 + 1/a^2) := by
  let A := x^2+t^2
  let B := a^2+t^2
  have hA : 0 < A := by dsimp [A]; positivity
  have hB : 0 < B := by dsimp [B]; positivity
  have hD : 0 ≤ D := (abs_nonneg (x-a)).trans hd
  have hid : t/A - t/B = (a-x)*(t*(a+x)/(A*B)) := by
    dsimp [A, B]
    field_simp
    ring
  have hnum : t*(a+x) ≤ A+B := by
    dsimp [A, B]
    nlinarith [sq_nonneg (a-t), sq_nonneg (x-t), sq_nonneg a, sq_nonneg x, sq_nonneg t]
  change |t/A-t/B| ≤ _
  rw [hid, abs_mul, abs_of_nonneg (by positivity : 0 ≤ t*(a+x)/(A*B)), abs_sub_comm]
  calc
    _ ≤ D*(t*(a+x)/(A*B)) := mul_le_mul_of_nonneg_right hd (by positivity)
    _ ≤ D*((A+B)/(A*B)) := by gcongr
    _ = D*(1/A+1/B) := by field_simp; ring
    _ ≤ D*(1/x^2+1/a^2) := by
      apply mul_le_mul_of_nonneg_left _ hD
      apply add_le_add
      · apply div_le_div_of_nonneg_left (by norm_num) (sq_pos_of_pos hx)
        dsimp [A]
        nlinarith [sq_nonneg t]
      · apply div_le_div_of_nonneg_left (by norm_num) (sq_pos_of_pos ha)
        dsimp [B]
        nlinarith [sq_nonneg t]

theorem rationalKernel_tendsto_zero (x : ℝ) :
    Tendsto (fun t : ℝ => t/(x^2+t^2)) atTop (𝓝 0) := by
  have hb : ∀ᶠ t : ℝ in atTop, 0 ≤ t/(x^2+t^2) ∧ t/(x^2+t^2) ≤ 1/t := by
    filter_upwards [eventually_gt_atTop (0 : ℝ)] with t ht
    have hA : 0 < x^2+t^2 := by positivity
    refine ⟨by positivity, ?_⟩
    apply (div_le_div_iff₀ hA ht).mpr
    nlinarith [sq_nonneg x]
  exact squeeze_zero' (hb.mono (fun _ h => h.1)) (hb.mono (fun _ h => h.2))
    (tendsto_const_nhds.div_atTop tendsto_id)

/-- Replacing all real parts by their model changes the signed series by o(1).
Growth/summability assumptions are explicit; they are not imported from Bianchi. -/
theorem realParts_replacement_tendsto_zero (x a e : ℕ → ℝ) (D : ℝ)
    (hx : ∀ n, 0 < x n) (ha : ∀ n, 0 < a n)
    (hd : ∀ n, |x n-a n| ≤ D) (he : ∀ n, |e n| ≤ 1)
    (hsx : Summable (fun n => 1/(x n)^2))
    (hsa : Summable (fun n => 1/(a n)^2)) :
    Tendsto (fun t : ℝ => ∑' n,
      e n*(t/((x n)^2+t^2)-t/((a n)^2+t^2))) atTop (𝓝 0) := by
  have hpoint (n : ℕ) : Tendsto (fun t : ℝ =>
      e n*(t/((x n)^2+t^2)-t/((a n)^2+t^2))) atTop (𝓝 (0 : ℝ)) := by
    have h := ((rationalKernel_tendsto_zero (x n)).sub
      (rationalKernel_tendsto_zero (a n))).const_mul (e n)
    simpa only [sub_self, mul_zero] using h
  have hb : ∀ᶠ t : ℝ in atTop, ∀ n,
      ‖e n*(t/((x n)^2+t^2)-t/((a n)^2+t^2))‖ ≤
        D*(1/(x n)^2+1/(a n)^2) := by
    filter_upwards [eventually_gt_atTop (0 : ℝ)] with t ht n
    rw [Real.norm_eq_abs, abs_mul]
    calc
      _ ≤ 1*|t/((x n)^2+t^2)-t/((a n)^2+t^2)| :=
        mul_le_mul_of_nonneg_right (he n) (abs_nonneg _)
      _ ≤ _ := by simpa only [one_mul] using
        rationalKernel_difference_bound (hx n) (ha n) ht (hd n)
  have h := tendsto_tsum_of_dominated_convergence ((hsx.add hsa).mul_left D) hpoint hb
  simpa only [tsum_zero] using h

end CovariogramCheck
