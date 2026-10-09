# Covariogram uniqueness: technical draft and separate supplements

Version: 9 October 2026. Author: Andrea Comparini, *A curious amateur with proof obligations*.

## Read the mathematical paper first

[Covariogram Uniqueness with One Regular Body in R³: A Candidate Proof via Area Measures and Fourier–Laplace Zeros](covariogram-uniqueness-candidate.tex) is the current English manuscript.

It starts with the precise extension identified as open in Bianchi's work: a body K of class C⁹₊ in R³ is to be determined among all convex competitors L, up to translation and central reflection. The introduction briefly explains the purpose of the AI-assisted investigation. The rest of the paper presents the mathematical argument for expert assessment.

The main text has five sections:

1. Introduction and purpose.
2. Geometric reduction for the competitor.
3. A common orientation from the spectral data.
4. Completion of the candidate argument.
5. Scope of verification and accompanying materials.

The four appendices provide the detailed proposed proofs:

- **A. Geometric transfer and endpoint sections:** support regularity, the full surface area measure, singular and positive definite quadratic data, endpoint Laplace limits, and antipodal density pairs.
- **B. Allocation of zeros and the paired canonical product:** global analytic allocation, multiplicities, exceptional zeros, Hadamard factorization and logarithms.
- **C. Kernel estimates and replacement of the zeros:** summable remainders, bounded positive masses, finite-head/tail arguments and dominated convergence.
- **D. The common mean and proof of the transport proposition:** normalization of the specific weights and the common orientation parameter.

The two central propositions remain proposed steps subject to independent review. The paper's mathematical argument is written without requiring the reader to inspect the Lean files, numerical scripts or interaction history.

## Separate supplements

- [Supplement S1 — Partial Lean Verification](lean-verification-supplement.tex): coverage map, all 33 theorem names, hypotheses, unformalized dependencies, versions and verification records.
- [Supplement S2 — Computational Diagnostics](computational-diagnostics.tex): the scalar test profile, observed numerical results, exact rational checks and repetition commands.

The actual Lean proofs remain in [formalizzazione/CovariogramCheck](../formalizzazione/CovariogramCheck), with their [entry point](../formalizzazione/CovariogramCheck.lean), [audit](../formalizzazione/Audit.lean), [checking script](../formalizzazione/check.sh) and [recorded results](../formalizzazione/verifica).

S1 documents a successful kernel check of supporting and conditional statements. The full covariogram theorem and the geometric/spectral derivation of the hypotheses are **not** certified in Lean. In particular, neither central proposition is fully formalized.

## Preserved research materials

- [Original Italian research notebook](../ricerca/rigidita-scambi-covariogramma.tex).
- [Bibliographic register and search record](../bibliografia/registro.md).
- [Study essay](../saggi/evoluzione-e-percorso.md).
- [Spectral diagnostic script](../ricerca/verifica_media_zeri.py).
- [Rational diagnostic script](../ricerca/verifica_scambi.py).
- [Previous methodological outline](ai-assisted-covariogram-outline.tex), retained as an earlier planning artifact. It is superseded by the technical manuscript and is not the paper to send for mathematical review.

The original notebook contains additional approaches and weaker-regularity investigations not used in the present paper. It remains separate to avoid expanding the technical manuscript beyond its stated target.

The available written research record consists of these documents and scripts. A full verbatim export of the conversation has not been added to this directory; no reconstructed text is presented as such an export.

## Verification records for this draft

The three current LaTeX documents compiled successfully with the document editor's compiler. All main-paper labels, cross-references and bibliography keys were checked for missing or duplicate entries.

The Lean checks are recorded in formalizzazione/verifica, including source hashes and environment versions. The proof sources were not changed during manuscript or publication preparation; the checking script was adapted to accept Lean/Lake on PATH or via LEAN_BIN and to enforce the pinned versions.

The two diagnostic scripts were rerun. Their outputs, Python version and source hashes are in [diagnostics](diagnostics). Numerical discrepancies and uncertified truncation errors are described in S2.

Each LaTeX document is self-contained. The editor provides its PDF preview; a conventional LaTeX installation can also compile the documents independently. No externally included source or bibliography file is required.

## Public review edition

The public repository is [andreacomparini/covariogram-uniqueness-candidate](https://github.com/andreacomparini/covariogram-uniqueness-candidate). It contains the LaTeX sources, supplements, Lean sources and records, diagnostics, and research documents. No exported PDF is included in this initial edition.

Downloaded toolchains and dependency caches are excluded. See the [root README](../README.md#reproduce-the-checks) for setup instructions and the distinction between a successful local check and an untested fresh-machine installation. The paper and original documentation are licensed under CC BY 4.0, with MIT for the original code; see [LICENSE.md](../LICENSE.md). No contact with, review by, or endorsement from Bianchi is asserted.
