# Proposal

## Why

The packit pull-request test job still targets `fedora-42` (`.packit.yaml`), even though the project is based on Fedora 43 and 42 is moving toward end of life. The test job only selects the operating system of the CI executor that provisions and drives the Vojtux VM, so keeping it current avoids running acceptance tests on an aging, soon-unsupported executor. The maintainer explicitly wants the executor on Fedora 44.

## What Changes

- Update the packit `tests` job target in `.packit.yaml` from `fedora-42` to `fedora-44`.
- Leave the Vojtux base release and shipped artifacts untouched: this is only the CI executor OS, not the distro being built. The kickstarts, `--releasever`, ISO name, and repositories stay on Fedora 43, and the test job still provisions the same Vojtux VM.

## Capabilities

### New Capabilities
<!-- none -->

### Modified Capabilities
- `acceptance-testing`: record the Fedora release the CI/packit executor runs on and keep it aligned with the project's supported Fedora target, so the target can be validated on rebase.

## Impact

- `.packit.yaml` only (the `tests` job `targets` entry).
- CI: packit pull-request tests now execute on a Fedora 44 executor under Testing Farm; tmt plan (`plans/vojtux.fmf`) and test code are unchanged.
- No change to the built live image, RPM packages, kickstarts, or release process.
- Assumption recorded: the Vojtux base stays on Fedora 43; this change does not trigger the `live-image-build` rebase checklist.
