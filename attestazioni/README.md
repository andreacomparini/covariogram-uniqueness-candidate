# Timestamp evidence for the first public manuscript

The archive in [9a401f4](9a401f4) contains all **38 tracked files** of commit
[`9a401f4a10f2ea685be6681eabaf594c6024602b`](https://github.com/andreacomparini/covariogram-uniqueness-candidate/tree/9a401f4a10f2ea685be6681eabaf594c6024602b).
It includes the manuscript, supplements, Lean sources and verification records,
diagnostic scripts, bibliography and research notes as initially published.

## Recorded timestamp

FreeTSA issued an RFC 3161 timestamp over the SHA-256 digest of the archive:

- **UTC:** 9 October 2026 at **00:05:42**.
- **Europe/Rome:** 9 October 2026 at **02:05:42 CEST**.
- **Receipt serial:** `0x090EC598`.
- **Archive SHA-256:** `7950b0928d6bfd0f6a0fc3b04c78fd39acec3963b06bfbe8ffc5e2d8434eecc0`.

The receipt attests the digest at the time stated by FreeTSA. Verification uses
the FreeTSA root certificate as its trust anchor. **This is presented as a
cryptographic timestamp; no qualified eIDAS status is asserted.** No qualified
electronic timestamp has been obtained as part of this step.

The signature, archive digest and request nonce were verified with OpenSSL.
A deliberately altered temporary copy of the archive was correctly rejected.
The downloaded public certificate files matched the SHA-256 hashes published
on the [provider's website](https://freetsa.org/index_en.php).
The timestamp request contained the digest and a nonce; the archive's contents
were not uploaded to FreeTSA.

This evidence concerns the existence and integrity of the archived bytes under
that trust model. It does not certify authorship, mathematical correctness,
originality or priority over other work. It does not backdate the evidence to
the earlier Git commit time.

## Evidence files

| File | Role |
| --- | --- |
| [Snapshot ZIP](9a401f4/covariogram-uniqueness-candidate-9a401f4.zip) | Exact archived bytes to retain for verification or submit for a qualified timestamp |
| [manifest.json](9a401f4/manifest.json) | Commit, tree, archive digest and SHA-256 inventory of the 38 files |
| [SHA256SUMS](9a401f4/SHA256SUMS) | Hashes of the archive and manifest |
| [archive.tsq](9a401f4/archive.tsq) | RFC 3161 request, including the archive digest and nonce |
| [archive.tsr](9a401f4/archive.tsr) | Signed timestamp response, including the signing certificate |
| [freetsa-ca.crt](9a401f4/freetsa-ca.crt) | Public root certificate used as the trust anchor |
| [freetsa-tsa.crt](9a401f4/freetsa-tsa.crt) | Public timestamp-signing certificate downloaded from FreeTSA |
| [timestamp-details.txt](9a401f4/timestamp-details.txt) | Readable decoding of the signed response |
| [timestamp-status.json](9a401f4/timestamp-status.json) | Machine-readable summary and explicit qualification limit |
| [verification.txt](9a401f4/verification.txt) | Results recorded during preparation |

The ZIP is a fixed snapshot. Later repository updates, including these evidence
files and the new README link, are **not** covered by this receipt. For a new
manuscript version, create a new archive and obtain a new timestamp; retain
this archive and receipt unchanged. Recreating a ZIP with different metadata
may produce different bytes even when its source files are identical.

## Independent verification

With Python 3.9+ and OpenSSL available, from the repository root:

```bash
python3 attestazioni/verify.py
```

The script checks the archive inventory, file hashes, embedded commit identifier,
signature, archive digest and request/response match. It does not query FreeTSA
or upload any data. It pins the downloaded root certificate's file hash; the
reader must still decide whether to trust that certificate authority.

The essential cryptographic check can also be run directly:

```bash
cd attestazioni/9a401f4
openssl ts -verify \
  -data covariogram-uniqueness-candidate-9a401f4.zip \
  -in archive.tsr -CAfile freetsa-ca.crt
openssl ts -reply -in archive.tsr -text
```

To compare every archived source with the Git commit, use the manifest's commit
and the archived paths. The files were compared byte for byte with `git show`
when the snapshot was created. The ZIP comment embeds the full commit ID.
The verifier checks that identifier, but does not establish the Git object's
identity solely from its label; the byte comparison supplies the link to the
repository contents.

## Qualified timestamp, if required

For the specific presumption of accuracy of time and date and integrity of the
linked data, Article 41(2) of eIDAS concerns **qualified** electronic timestamps;
Article 42 specifies their requirements. See the
[consolidated regulation](https://eur-lex.europa.eu/legal-content/IT/TXT/?uri=CELEX:02014R0910-20241018).

The ZIP above is ready to submit through a qualified trust service provider's
timestamping service. Select a service whose relevant qualified status can be
checked, apply its timestamp to these exact archive bytes, then retain and verify
the resulting receipt and validation evidence. That service will attest its
actual issue time, not the Git commit date or the time of this FreeTSA receipt.
