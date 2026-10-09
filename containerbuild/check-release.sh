#!/bin/sh
# Consistency check for the single release definition: every release
# reference in ks/repos.ks (fedora, updates, RPM Fusion, Copr baseurl) must
# match the version in the RELEASE file at the repository root.
# Run from anywhere: containerbuild/check-release.sh
set -eu

cd "$(dirname "$0")/.."

if [ ! -f RELEASE ]; then
  echo "RELEASE file not found at the repository root" >&2
  exit 1
fi
release=$(tr -d '[:space:]' < RELEASE)

versions=$(grep -oE 'fedora-[0-9]+|released-f?[0-9]+' ks/repos.ks | tr -cd '0-9\n' | sort -u)

if [ "$versions" = "$release" ]; then
  echo "OK: ks/repos.ks release references match RELEASE ($release)"
else
  echo "RELEASE ($release) and ks/repos.ks references ($versions) are out of sync." >&2
  echo "Update ks/repos.ks, e.g.:" >&2
  echo "  sed -i -e \"s/fedora-[0-9][0-9]*/fedora-$release/g\" -e \"s/released-f[0-9][0-9]*/released-f$release/g\" -e \"s/released-[0-9][0-9]*/released-$release/g\" ks/repos.ks" >&2
  exit 1
fi
