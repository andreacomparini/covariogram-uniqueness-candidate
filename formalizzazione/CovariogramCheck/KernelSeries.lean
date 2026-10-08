import CovariogramCheck.LogKernel
import Mathlib.Analysis.Normed.Group.InfiniteSum
import Mathlib.Topology.Algebra.InfiniteSum.Ring
import Mathlib.Topology.Algebra.Order.Field

open Filter
open scoped Topology

namespace CovariogramCheck

/-- A summable majorant for the logarithmic remainder. -/
theorem logKernel_remainder_majorant {x y t M : ℝ}
    (hx : x ≠ 0) (ht : 0 < t) (hy : |y| ≤ M) (hlarge : 4*M ≤ t) :
    |logKernel x y t + 4*t*y/(x^2+t^2)| ≤
      (36*M^3/t) * (1/x^2) := by
  have hA : 0 < x^2+t^2 := by positivity
  have hx2 := sq_pos_of_ne_zero hx
  have hM : 0 ≤ M := (abs_nonneg y).trans hy
  have hfrac : t/(x^2+t^2)^2 ≤ 1/(t*x^2) := by
    apply (div_le_div_iff₀ (sq_pos_of_pos hA) (mul_pos ht hx2)).mpr
    have hprod : t^2*x^2 ≤ (x^2+t^2)*(x^2+t^2) :=
      mul_le_mul (by nlinarith [sq_nonneg x]) (by nlinarith [sq_nonneg t])
        (sq_nonneg x) hA.le
    nlinarith
  calc
    _ ≤ 36*M^3*t/(x^2+t^2)^2 := logKernel_uniform_remainder hx ht hy hlarge
    _ = (36*M^3) * (t/(x^2+t^2)^2) := by ring
    _ ≤ (36*M^3) * (1/(t*x^2)) := mul_le_mul_of_nonneg_left hfrac (by positivity)
    _ = _ := by ring

/-- The remainder series converges, and the sum is bounded by O(1/t).
No interchange of a divergent series and a limit is used. -/
theorem logKernel_remainder_sum_bound (x y : ℕ → ℝ) (M t : ℝ)
    (hx : ∀ n, x n ≠ 0) (ht : 0 < t)
    (hy : ∀ n, |y n| ≤ M) (hlarge : 4*M ≤ t)
    (hs : Summable (fun n => 1/(x n)^2)) :
    Summable (fun n => logKernel (x n) (y n) t + 4*t*y n/((x n)^2+t^2)) ∧
    |∑' n, (logKernel (x n) (y n) t + 4*t*y n/((x n)^2+t^2))| ≤
      (36*M^3/t) * (∑' n, 1/(x n)^2) := by
  have hbound (n : ℕ) :
      ‖logKernel (x n) (y n) t + 4*t*y n/((x n)^2+t^2)‖ ≤
        (36*M^3/t) * (1/(x n)^2) := by
    rw [Real.norm_eq_abs]
    exact logKernel_remainder_majorant (hx n) ht (hy n) hlarge
  have hmajor := hs.mul_left (36*M^3/t)
  refine ⟨hmajor.of_norm_bounded hbound, ?_⟩
  have h := tsum_of_norm_bounded hmajor.hasSum hbound
  simpa only [Real.norm_eq_abs, tsum_mul_left] using h

/-- Conditional only on bounded heights and inverse-square summability of
the real parts, the *entire* summed logarithmic remainder tends to zero. -/
theorem logKernel_remainder_sum_tendsto_zero (x y : ℕ → ℝ) (M : ℝ)
    (hx : ∀ n, x n ≠ 0) (hy : ∀ n, |y n| ≤ M)
    (hs : Summable (fun n => 1/(x n)^2)) :
    Tendsto (fun t => ∑' n,
      (logKernel (x n) (y n) t + 4*t*y n/((x n)^2+t^2))) atTop (𝓝 0) := by
  have hbound : ∀ᶠ t : ℝ in atTop,
      ‖∑' n, (logKernel (x n) (y n) t + 4*t*y n/((x n)^2+t^2))‖ ≤
        (36*M^3/t) * (∑' n, 1/(x n)^2) := by
    filter_upwards [eventually_gt_atTop (0 : ℝ), eventually_ge_atTop (4*M)] with t ht hlarge
    rw [Real.norm_eq_abs]
    exact (logKernel_remainder_sum_bound x y M t hx ht hy hlarge hs).2
  have hlim : Tendsto (fun t : ℝ =>
      (36*M^3/t) * (∑' n, 1/(x n)^2)) atTop (𝓝 0) := by
    have hc : Tendsto (fun t : ℝ => 36*M^3/t) atTop (𝓝 (0 : ℝ)) :=
      tendsto_const_nhds.div_atTop tendsto_id
    have hh := hc.mul_const (∑' n, 1/(x n)^2)
    rw [zero_mul] at hh
    exact hh
  exact squeeze_zero_norm' hbound hlim

theorem linearKernel_summable (x y : ℕ → ℝ) (M t : ℝ)
    (hx : ∀ n, x n ≠ 0) (hy : ∀ n, |y n| ≤ M)
    (hs : Summable (fun n => 1/(x n)^2)) :
    Summable (fun n => y n/((x n)^2+t^2)) := by
  have hM : 0 ≤ M := (abs_nonneg (y 0)).trans (hy 0)
  apply (hs.mul_left M).of_norm_bounded
  intro n
  have hx2 : 0 < (x n)^2 := sq_pos_of_ne_zero (hx n)
  have hA : 0 < (x n)^2+t^2 := by positivity
  rw [Real.norm_eq_abs, abs_div, abs_of_pos hA]
  calc
    _ ≤ M/((x n)^2+t^2) := div_le_div_of_nonneg_right (hy n) hA.le
    _ ≤ M/(x n)^2 := div_le_div_of_nonneg_left hM hx2 (by nlinarith [sq_nonneg t])
    _ = _ := by ring

/-- The difference of the two convergent series tends to zero. In addition
to the remainder bound, this checks the splitting of the infinite sum. -/
theorem logKernel_sum_linearization (x y : ℕ → ℝ) (M : ℝ)
    (hx : ∀ n, x n ≠ 0) (hy : ∀ n, |y n| ≤ M)
    (hs : Summable (fun n => 1/(x n)^2)) :
    Tendsto (fun t => (∑' n, logKernel (x n) (y n) t) +
      4*t*(∑' n, y n/((x n)^2+t^2))) atTop (𝓝 0) := by
  have heq : ∀ᶠ t : ℝ in atTop,
      (∑' n, (logKernel (x n) (y n) t + 4*t*y n/((x n)^2+t^2))) =
        (∑' n, logKernel (x n) (y n) t) + 4*t*(∑' n, y n/((x n)^2+t^2)) := by
    filter_upwards [eventually_gt_atTop (0 : ℝ), eventually_ge_atTop (4*M)] with t ht hlarge
    have he := (logKernel_remainder_sum_bound x y M t hx ht hy hlarge hs).1
    have hl : Summable (fun n => 4*t*y n/((x n)^2+t^2)) := by
      convert (linearKernel_summable x y M t hx hy hs).mul_left (4*t) using 1
      funext n
      ring
    have hr : Summable (fun n => logKernel (x n) (y n) t) := by
      convert he.sub hl using 1
      funext n
      ring
    rw [hr.tsum_add hl]
    congr 1
    calc
      _ = ∑' n, (4*t)*(y n/((x n)^2+t^2)) := tsum_congr (fun n => by ring)
      _ = _ := tsum_mul_left
  exact (logKernel_remainder_sum_tendsto_zero x y M hx hy hs).congr' heq

end CovariogramCheck
