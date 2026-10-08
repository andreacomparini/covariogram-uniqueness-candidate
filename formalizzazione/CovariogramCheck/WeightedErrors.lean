import Mathlib.Analysis.Normed.Group.InfiniteSum
import Mathlib.Topology.Algebra.InfiniteSum.Real
import Mathlib.Topology.Algebra.InfiniteSum.Ring
import Mathlib.Tactic

open Filter Finset
open scoped Topology

namespace CovariogramCheck

theorem summable_weighted_of_bounded {w e : ℕ → ℝ} {B : ℝ}
    (hw : Summable w) (hpos : ∀ n, 0 ≤ w n) (hb : ∀ n, |e n| ≤ B) :
    Summable (fun n => w n * e n) := by
  apply (hw.mul_right B).of_norm_bounded
  intro n
  simpa only [Real.norm_eq_abs, abs_mul, abs_of_nonneg (hpos n)] using
    mul_le_mul_of_nonneg_left (hb n) (hpos n)

/-- A bounded signed average never exceeds the mass of its positive weights. -/
theorem signed_sum_bound {w e : ℕ → ℝ}
    (hw : Summable w) (hpos : ∀ n, 0 ≤ w n) (he : ∀ n, |e n| ≤ 1) :
    |∑' n, w n * e n| ≤ ∑' n, w n := by
  rw [← Real.norm_eq_abs]
  apply tsum_of_norm_bounded hw.hasSum
  intro n
  simpa only [Real.norm_eq_abs, abs_mul, abs_of_nonneg (hpos n), mul_one] using
    mul_le_mul_of_nonneg_left (he n) (hpos n)

/-- The head/tail argument used to replace the imaginary parts of the zeros
by their limiting heights. Summability, bounded mass, and vanishing individual
weights are explicit hypotheses and all quantifiers are checked by Lean. -/
theorem weighted_errors_tendsto_zero {T : Type*} {l : Filter T}
    (w : T → ℕ → ℝ) (e : ℕ → ℝ) (C B : ℝ)
    (hC : 0 < C)
    (hpos : ∀ t n, 0 ≤ w t n)
    (hsum : ∀ t, Summable (w t))
    (hmass : ∀ᶠ t in l, (∑' n, w t n) ≤ C)
    (hpoint : ∀ n, Tendsto (fun t => w t n) l (𝓝 0))
    (he : Tendsto e atTop (𝓝 0))
    (hB : ∀ n, |e n| ≤ B) :
    Tendsto (fun t => ∑' n, w t n * e n) l (𝓝 0) := by
  rw [Metric.tendsto_nhds]
  intro ε hε
  let δ : ℝ := ε / (2*C)
  have hδ : 0 < δ := by dsimp [δ]; positivity
  have htail : ∀ᶠ n in atTop, |e n| < δ := by
    simpa only [Real.dist_eq, sub_zero] using (Metric.tendsto_nhds.mp he) δ hδ
  obtain ⟨N, hN⟩ := eventually_atTop.mp htail
  have hhead : Tendsto (fun t => ∑ n ∈ range N, w t n * e n) l (𝓝 0) := by
    have h := tendsto_finset_sum (range N) (fun n _ => (hpoint n).mul_const (e n))
    simpa only [zero_mul, sum_const_zero] using h
  have hheadε : ∀ᶠ t in l, |∑ n ∈ range N, w t n * e n| < ε/2 := by
    simpa only [Real.dist_eq, sub_zero] using
      (Metric.tendsto_nhds.mp hhead) (ε/2) (by positivity)
  filter_upwards [hmass, hheadε] with t hmt hht
  have hs := summable_weighted_of_bounded (hsum t) (hpos t) hB
  have hwtail : Summable (fun n => w t (n+N)) := (summable_nat_add_iff N).mpr (hsum t)
  have hmassTail : (∑' n, w t (n+N)) ≤ C := by
    have hsplit := (hsum t).sum_add_tsum_nat_add N
    have hnonneg : 0 ≤ ∑ n ∈ range N, w t n := sum_nonneg (fun n _ => hpos t n)
    linarith
  have htailBound : |∑' n, w t (n+N) * e (n+N)| ≤ δ*C := by
    have hnorm : |∑' n, w t (n+N) * e (n+N)| ≤ ∑' n, w t (n+N) * δ := by
      rw [← Real.norm_eq_abs]
      apply tsum_of_norm_bounded (hwtail.mul_right δ).hasSum
      intro n
      simp only [Real.norm_eq_abs, abs_mul, abs_of_nonneg (hpos t (n+N))]
      exact mul_le_mul_of_nonneg_left (hN (n+N) (by omega)).le (hpos t (n+N))
    rw [tsum_mul_right] at hnorm
    calc
      _ ≤ (∑' n, w t (n+N)) * δ := hnorm
      _ ≤ C*δ := mul_le_mul_of_nonneg_right hmassTail hδ.le
      _ = δ*C := mul_comm _ _
  rw [Real.dist_eq, sub_zero, ← hs.sum_add_tsum_nat_add N]
  calc
    _ ≤ |∑ n ∈ range N, w t n * e n| + |∑' n, w t (n+N) * e (n+N)| := abs_add_le _ _
    _ < ε/2 + δ*C := add_lt_add_of_lt_of_le hht htailBound
    _ = ε := by dsimp [δ]; field_simp; ring

end CovariogramCheck
