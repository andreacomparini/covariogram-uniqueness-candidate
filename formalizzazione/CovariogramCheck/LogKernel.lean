import Mathlib.Analysis.SpecialFunctions.Log.Deriv
import Mathlib.Tactic

namespace CovariogramCheck

/-- The odd logarithmic expression: the quadratic Taylor terms cancel.
This is a checked remainder estimate, not a numerical test. -/
theorem log_ratio_cubic_remainder {v : ℝ} (hv : |v| < 1) :
    |Real.log (1-v) - Real.log (1+v) + 2*v| ≤
      2*|v|^3/(1-|v|) := by
  have hp := Real.abs_log_sub_add_sum_range_le hv 2
  have hm := Real.abs_log_sub_add_sum_range_le (x := -v) (by simpa using hv) 2
  norm_num [Finset.sum_range_succ] at hp hm
  have he : Real.log (1-v) - Real.log (1+v) + 2*v =
      (v + v^2/2 + Real.log (1-v)) -
        (-v + v^2/2 + Real.log (1+v)) := by ring
  rw [he]
  calc
    _ ≤ |v + v^2/2 + Real.log (1-v)| +
        |-v + v^2/2 + Real.log (1+v)| := abs_sub _ _
    _ ≤ |v|^3/(1-|v|) + |v|^3/(1-|v|) := add_le_add hp hm
    _ = _ := by ring

theorem log_ratio_cubic_remainder_half {v : ℝ} (hv : |v| ≤ 1/2) :
    |Real.log (1-v) - Real.log (1+v) + 2*v| ≤ 4*|v|^3 := by
  have hv' : |v| < 1 := by linarith
  refine (log_ratio_cubic_remainder hv').trans ?_
  apply (div_le_iff₀ (by linarith : 0 < 1-|v|)).mpr
  nlinarith [pow_nonneg (abs_nonneg v) 3]

noncomputable def logKernel (x y t : ℝ) : ℝ :=
  Real.log ((x^2+(t-y)^2)/(x^2+(t+y)^2))

/-- Exact change of variables from each paired zero to the Taylor kernel. -/
theorem logKernel_normalization {x y t : ℝ} (hx : x ≠ 0) :
    logKernel x y t =
      Real.log (1 - 2*t*y/(x^2+t^2+y^2)) -
      Real.log (1 + 2*t*y/(x^2+t^2+y^2)) := by
  have hx2 : 0 < x^2 := sq_pos_of_ne_zero hx
  have hA : 0 < x^2+t^2+y^2 := by positivity
  have hN : 0 < x^2+(t-y)^2 := by positivity
  have hD : 0 < x^2+(t+y)^2 := by positivity
  have hn : 1 - 2*t*y/(x^2+t^2+y^2) =
      (x^2+(t-y)^2)/(x^2+t^2+y^2) := by field_simp; ring
  have hd : 1 + 2*t*y/(x^2+t^2+y^2) =
      (x^2+(t+y)^2)/(x^2+t^2+y^2) := by field_simp; ring
  rw [hn, hd, Real.log_div hN.ne' hA.ne', Real.log_div hD.ne' hA.ne']
  unfold logKernel
  rw [Real.log_div hN.ne' hD.ne']
  ring

/-- Kernel remainder before replacing the denominator A+y² by A.
The hypotheses make the bound uniform in x; the sum over zeros is separate. -/
theorem logKernel_cubic_bound {x y t : ℝ} (hx : x ≠ 0)
    (hv : |2*t*y/(x^2+t^2+y^2)| ≤ 1/2) :
    |logKernel x y t + 4*t*y/(x^2+t^2+y^2)| ≤
      4*|2*t*y/(x^2+t^2+y^2)|^3 := by
  rw [logKernel_normalization hx]
  convert log_ratio_cubic_remainder_half hv using 1
  congr 1
  ring

/-- The denominator correction, with its sign preserved exactly. -/
theorem kernel_denominator_correction {x y t : ℝ}
    (hA : x^2+t^2 ≠ 0) (hB : x^2+t^2+y^2 ≠ 0) :
    4*t*y/(x^2+t^2) - 4*t*y/(x^2+t^2+y^2) =
      4*t*y^3/((x^2+t^2)*(x^2+t^2+y^2)) := by
  field_simp
  ring

/-- A uniform bound with a deliberately nonoptimal constant. The threshold
`t ≥ 4M` is sufficient for the limiting argument in the manuscript. -/
theorem logKernel_uniform_remainder {x y t M : ℝ}
    (hx : x ≠ 0) (ht : 0 < t) (hy : |y| ≤ M) (hlarge : 4*M ≤ t) :
    |logKernel x y t + 4*t*y/(x^2+t^2)| ≤
      36*M^3*t/(x^2+t^2)^2 := by
  let A := x^2+t^2
  let B := A+y^2
  have hA : 0 < A := by dsimp [A]; positivity
  have hB : 0 < B := by dsimp [B]; positivity
  have hAB : A ≤ B := by dsimp [B]; nlinarith [sq_nonneg y]
  have htA : t^2 ≤ A := by dsimp [A]; nlinarith [sq_nonneg x]
  have hM : 0 ≤ M := (abs_nonneg y).trans hy
  have hvabs : |2*t*y/B| = 2*t*|y|/B := by
    rw [abs_div, abs_mul, abs_mul, abs_of_pos hB, abs_of_pos ht]
    norm_num
  have hv : |2*t*y/B| ≤ 1/2 := by
    rw [hvabs]
    apply (div_le_iff₀ hB).mpr
    nlinarith [mul_nonneg ht.le (show 0 ≤ t-4*|y| by linarith)]
  have hc := logKernel_cubic_bound hx hv
  change |logKernel x y t + 4*t*y/B| ≤ 4*|2*t*y/B|^3 at hc
  have hvA : 2*t*|y|/B ≤ 2*t*|y|/A :=
    div_le_div_of_nonneg_left (by positivity) hA hAB
  have hcub : 4*|2*t*y/B|^3 ≤ 32*t*|y|^3/A^2 := by
    rw [hvabs]
    calc
      _ ≤ 4*(2*t*|y|/A)^3 := by gcongr
      _ = (32*t*|y|^3/A^2)*(t^2/A) := by field_simp; ring
      _ ≤ 32*t*|y|^3/A^2 :=
        mul_le_of_le_one_right (by positivity) ((div_le_one hA).mpr htA)
  have hcorr : |4*t*y/A - 4*t*y/B| ≤ 4*t*|y|^3/A^2 := by
    rw [kernel_denominator_correction hA.ne' hB.ne']
    change |4*t*y^3/(A*B)| ≤ _
    rw [abs_div, abs_mul, abs_mul, abs_pow,
      abs_of_pos (mul_pos hA hB), abs_of_pos ht]
    norm_num only [abs_of_pos (by norm_num : (0 : ℝ) < 4)]
    apply div_le_div_of_nonneg_left (by positivity) (sq_pos_of_pos hA)
    nlinarith [mul_le_mul_of_nonneg_left hAB hA.le]
  calc
    _ = |(logKernel x y t + 4*t*y/B) + (4*t*y/A - 4*t*y/B)| := by
      congr 1
      dsimp [A]
      ring
    _ ≤ |logKernel x y t + 4*t*y/B| + |4*t*y/A - 4*t*y/B| := abs_add_le _ _
    _ ≤ 32*t*|y|^3/A^2 + 4*t*|y|^3/A^2 := add_le_add (hc.trans hcub) hcorr
    _ = 36*|y|^3*t/A^2 := by ring
    _ ≤ 36*M^3*t/A^2 := by gcongr

end CovariogramCheck
