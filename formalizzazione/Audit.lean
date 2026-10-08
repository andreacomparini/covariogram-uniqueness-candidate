import CovariogramCheck
import Lean.Util.CollectAxioms

set_option autoImplicit false

/- Inspect every theorem in the project namespace, including transitive
dependencies. Any axiom other than Lean's three usual classical foundations
causes an error, rather than merely being printed for manual inspection. -/
open Lean Elab Command in
run_cmd do
  let env ← getEnv
  let mut count := 0
  let mut publicCount := 0
  for (name, info) in env.constants.toList do
    if (`CovariogramCheck).isPrefixOf name then
      match info with
      | .axiomInfo _ => throwError "Local axiom is forbidden: {name}"
      | .thmInfo _ =>
        let axs ← collectAxioms name
        for ax in axs do
          unless #[`propext, `Classical.choice, `Quot.sound].contains ax do
            throwError "Unapproved axiom in {name}: {ax}"
        if name.getPrefix == `CovariogramCheck then
          logInfo m!"{name}: {axs.qsort Name.lt |>.toList}"
          publicCount := publicCount + 1
        count := count + 1
      | _ => pure ()
  if count == 0 then
    throwError "No theorem was audited"
  logInfo m!"AUDIT OK: {publicCount} public theorems ({count} including generated helpers); only propext, Classical.choice, Quot.sound allowed."

-- The three principal conditional conclusions, printed with their hypotheses.
#check CovariogramCheck.logKernel_sum_linearization
#check CovariogramCheck.realParts_replacement_tendsto_zero
#check CovariogramCheck.measure_orientation_of_sum_product_transport
