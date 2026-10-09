# Covariogram Uniqueness with One Regular Body in R³

## A candidate proof for independent mathematical review

**Andrea — A curious amateur with proof obligations**

Draft dated 9 October 2026.

This repository presents a candidate argument for an extension explicitly identified as open in Gabriele Bianchi’s work: if a convex body **K has C⁹ boundary with positive Gaussian curvature in R³**, does its covariogram determine it **among all convex bodies**, up to translation and central reflection?

**The argument has not been independently validated. The complete theorem is not formalized or certified in Lean.** The accompanying Lean project checks 33 explicitly stated supporting and conditional theorems; its hypotheses and unformalized dependencies are documented separately.

## Start with the technical paper

[**Covariogram Uniqueness with One Regular Body in R³: A Candidate Proof via Area Measures and Fourier–Laplace Zeros**](paper/covariogram-uniqueness-candidate.tex)

The main text gives the geometric reduction, the spectral orientation argument and the proposed conclusion. Four appendices develop the proposed proofs. The two central propositions require expert scrutiny. The paper is self-contained and does not require reading the interaction history or Lean sources.

| Material | Purpose |
| --- | --- |
| [Main paper and reading guide](paper/README.md) | English manuscript, section map and review status |
| [Supplement S1](paper/lean-verification-supplement.tex) | Precise scope of the partial Lean verification |
| [Lean sources and audit](formalizzazione/README.md) | Formal statements, proofs and recorded checks |
| [Supplement S2](paper/computational-diagnostics.tex) | Numerical diagnostics and their limitations |
| [Original notebook](ricerca/rigidita-scambi-covariogramma.tex) | Detailed research record in Italian |
| [Bibliographic register](bibliografia/registro.md) | Sources, chronology and literature-search record |
| [Study essay](saggi/evoluzione-e-percorso.md) | Background and learning path in Italian |
| [Timestamp evidence](attestazioni/README.md) | First-publication snapshot and verified RFC 3161 receipt; no qualified eIDAS status asserted |

The target is described in [Bianchi’s 2016 paper, Remark 5.2](https://arxiv.org/abs/1312.7816), and in the [2023 survey, discussion after Theorem 3.25](https://people.dimai.unifi.it/bianchi/lavori/covariogram_survey14.pdf). The literature search documented here did not identify a subsequent solution in the sources checked; it is not an exhaustive priority certification.

## Reproduce the checks

### Lean

Install Lean/Lake **4.24.0**, for example using [elan](https://github.com/leanprover/elan), which reads `formalizzazione/lean-toolchain`. Then, from a fresh checkout of this repository:

```bash
mkdir -p .tools
git clone --depth 1 --branch v4.24.0 https://github.com/leanprover-community/mathlib4.git .tools/mathlib4
git -C .tools/mathlib4 checkout --detach f897ebcf72cd16f89ab4577d0c826cd14afaafc7
cd formalizzazione
lake exe cache get
./check.sh
```

The mathlib checkout must resolve to the exact commit shown above. Lake resolves the remaining dependencies from the committed manifest. `check.sh` uses `lean` and `lake` on `PATH`; alternatively set `LEAN_BIN` to the directory containing both executables. A fallback preserves the original local macOS setup. The script rejects a different Lean version or mathlib revision.

The script builds the library, re-elaborates every project source with warnings treated as errors, and audits all theorems in the project namespace. The audit allows only `propext`, `Classical.choice` and `Quot.sound`, and rejects `sorryAx` and additional axioms. It includes generated auxiliary theorems: **71 declarations in the recorded audit, corresponding to 33 explicitly stated theorems**.

Results and source hashes are in [formalizzazione/verifica](formalizzazione/verifica). Running the script updates these records. The checked environment is macOS arm64; a fresh installation on another platform has not yet been tested. Successful checks do not establish the unformalized geometric and spectral premises.

### Computational diagnostics

Python 3 and its standard library are sufficient:

```bash
python3 ricerca/verifica_scambi.py
python3 ricerca/verifica_media_zeri.py
```

[Recorded output and source hashes](paper/diagnostics) accompany Supplement S2. Numerical agreement is diagnostic, not a proof or certified error bound.

### Read or compile the manuscript

The manuscript and both supplements are standalone LaTeX sources with embedded references. Open a `.tex` file in a LaTeX editor or compile it with a conventional installation containing the packages listed in its preamble. Run the compiler twice to resolve cross-references. The three current documents passed compilation with the document editor used to prepare them. This initial publication contains the LaTeX sources; no exported PDF is included.

## Research context and status

The project arose from AI-assisted exploration by a nonprofessional, nonspecialist author. The technical paper concentrates on the mathematics; the supporting materials preserve the reasoning, tests and limitations available in written form. A complete verbatim conversation export is not included.

The repository is a review draft. Publication is not a claim that the open problem has been solved, and does not imply review or endorsement by Bianchi or any other mathematician. Corrections and precise mathematical objections are welcome as repository issues.

Downloaded Lean distributions, mathlib sources and build caches are excluded. No reuse license has yet been selected for the original materials; this initial publication does not add one. Dependencies retain their own licenses.

[Italian project overview](README.it.md)
