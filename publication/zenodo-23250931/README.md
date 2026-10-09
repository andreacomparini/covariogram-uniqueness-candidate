# Verification of the published deposit

Public record: https://zenodo.org/records/23250931

Version DOI: https://doi.org/10.5281/zenodo.23250931

`verification.json` is a locally generated report of the public API status,
DOI resolution, and a byte-for-byte comparison of all seven public downloads
against the staged files. It is not a Zenodo-issued or signed certificate.

`deposit-manifest.json` and `SHA256SUMS` are exact copies of the files uploaded
to Zenodo. Their filenames refer to the downloaded deposit files, not paths
relative to this Git directory. To use `SHA256SUMS`, first download the seven
files from the record into one directory, then run `shasum -a 256 -c SHA256SUMS`
there. The checksum list does not hash itself.

These verification records were committed after the deposit. The deposited
archive remains tied to commit `7fb853f751ab8238c033c5f3f3d2783f83681431`,
tagged `v1.0-candidate`; later Git commits do not alter that archive.
