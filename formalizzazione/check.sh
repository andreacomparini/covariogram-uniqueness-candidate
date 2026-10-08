#!/usr/bin/env bash
set -euo pipefail

project_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
cd "$project_dir"
if [[ -n "${LEAN_BIN:-}" ]]; then
  export PATH="$LEAN_BIN:$PATH"
elif ! command -v lake >/dev/null 2>&1; then
  export PATH="$project_dir/../.tools/lean/lean-4.24.0-darwin_aarch64/bin:$PATH"
fi
if ! command -v lean >/dev/null 2>&1 || ! command -v lake >/dev/null 2>&1; then
  echo "Install Lean/Lake 4.24.0, or set LEAN_BIN to their bin directory. See README." >&2
  exit 1
fi
lean_version="$(lean --version)"
if [[ "$lean_version" != *"version 4.24.0,"* ]]; then
  echo "Expected Lean 4.24.0; found: $lean_version" >&2
  exit 1
fi
mathlib_revision="$(git -C ../.tools/mathlib4 rev-parse HEAD)"
if [[ "$mathlib_revision" != "f897ebcf72cd16f89ab4577d0c826cd14afaafc7" ]]; then
  echo "Unexpected mathlib revision. See the pinned version in README." >&2
  exit 1
fi

mkdir -p verifica
lake build 2>&1 | tee verifica/build.log

# Re-elaborate every source, also when Lake's build was already up to date.
# Both parser/elaborator/kernel failures and warnings make the script fail.
for proof_file in CovariogramCheck/*.lean CovariogramCheck.lean; do
  echo "Checking $proof_file"
  lake env lean -DautoImplicit=false -DwarningAsError=true "$proof_file"
done 2>&1 | tee verifica/kernel.log

lake env lean -DautoImplicit=false -DwarningAsError=true Audit.lean \
  2>&1 | tee verifica/axioms.log

shasum -a 256 CovariogramCheck/*.lean CovariogramCheck.lean Audit.lean \
  lakefile.toml lean-toolchain lake-manifest.json check.sh > verifica/sources.sha256
{
  date -u '+UTC %Y-%m-%d %H:%M:%S'
  printf '%s\n' "$lean_version" "$mathlib_revision"
} > verifica/versions.txt

echo "Controllo completato. Il perimetro matematico verificato è descritto nel README."
