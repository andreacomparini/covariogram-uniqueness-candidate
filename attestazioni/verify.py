#!/usr/bin/env python3
"""Verify the stamped snapshot without extracting or executing its contents."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import zipfile


def require(condition, message):
    if not condition:
        raise SystemExit(message)


base = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(__file__).parent / "9a401f4"
manifest = json.loads((base / "manifest.json").read_text())
archive = base / manifest["archive"]["file"]
ca = base / "freetsa-ca.crt"
require(
    hashlib.sha256(ca.read_bytes()).hexdigest()
    == "2151b61137ffa86bf664691ba67e7da0b19f98c758e3d228d5d8ebf27e044438",
    "Unexpected FreeTSA trust anchor. Compare it with the provider's official source.",
)
require(
    hashlib.sha256(archive.read_bytes()).hexdigest() == manifest["archive"]["sha256"],
    "Archive SHA-256 does not match the manifest.",
)
with zipfile.ZipFile(archive) as z:
    prefix = "covariogram-uniqueness-candidate/"
    names = [i.filename for i in z.infolist() if not i.is_dir()]
    expected_names = [prefix + entry["path"] for entry in manifest["files"]]
    require(len(names) == len(set(names)), "Duplicate archive entries.")
    require(set(names) == set(expected_names), "Archive file list does not match.")
    require(len(names) == manifest["file_count"], "Incorrect file count.")
    require(z.comment.decode("ascii") == manifest["commit"], "Commit identifier differs.")
    for entry in manifest["files"]:
        data = z.read(prefix + entry["path"])
        require(len(data) == entry["bytes"], "Size mismatch: " + entry["path"])
        require(
            hashlib.sha256(data).hexdigest() == entry["sha256"],
            "Content mismatch: " + entry["path"],
        )

for options in (["-data", str(archive)], ["-queryfile", str(base / "archive.tsq")]):
    subprocess.run(
        ["openssl", "ts", "-verify", *options, "-in", str(base / "archive.tsr"),
         "-CAfile", str(ca)],
        check=True,
    )
print("Verified:", manifest["file_count"], "files; commit", manifest["commit"])
print("Trust model: FreeTSA certificate authority; no qualified eIDAS status is asserted.")
