# live-image-build Specification

## Purpose
How the Vojtux live image is composed, built, rebased and released.
## Requirements
### Requirement: Kickstart composition
The final kickstart SHALL be produced by flattening `ks/vojtux_en.ks` with `ksflatten -c ks/vojtux_en.ks -o vojtux.ks`; the include chain `vojtux_en -> vojtux_common -> (fedora-live-base, repos, fedora-mate-common)` is the composition contract, with the desktop defined as the Fedora MATE environment plus compiz and size-driven removals inherited from the MATE spin recipe. Delivered by `ks/*.ks`. Verified by: live boot (TC1).

#### Scenario: Flatten produces the buildable kickstart
- **WHEN** `ksflatten` is run against `ks/vojtux_en.ks`
- **THEN** a single self-contained kickstart results containing the base, repository, MATE and Vojtux layers

### Requirement: Build host contract
Building SHALL be done on Fedora, strongly recommended to match the target release, with `lorax-lmc-novirt` installed.

#### Scenario: Prepare a build host
- **WHEN** a builder prepares to build release N
- **THEN** the host runs Fedora N and has `lorax-lmc-novirt` installed

### Requirement: Build invocation and output
The image SHALL be produced by `livemedia-creator --make-iso --no-virt --iso-only --anaconda-arg="--noselinux" --iso-name vojtux_<N>.iso --project vojtux --releasever <N> --ks <flattened.ks>` yielding a bootable live ISO labeled "vojtux" with the release visible in the boot menu; all intermediate artifacts are discarded. Delivered by `Readme.md` build instructions and `dockerbuild/start.sh`. Verified by: TC1 boot of the produced ISO.

#### Scenario: Build finishes
- **WHEN** the livemedia-creator command completes successfully
- **THEN** `vojtux_<N>.iso` exists and boots to a greeter with speech

### Requirement: Fedora rebase checklist
A Fedora rebase to release N SHALL update every one of: `ks/repos.ks` release references (fedora, updates, RPM Fusion, Copr baseurl), the livemedia-creator `--releasever` and `--iso-name`, the ISO name in `dockerbuild/start.sh`, and Readme claims about the base release - so scattered version strings stay consistent. Rationale: past rebases required a scavenger hunt (commits "s/38/43/g", "bump fedora to 43").

#### Scenario: Version bump is complete
- **WHEN** the project rebases to Fedora N
- **THEN** all four locations above reference N and no stale release number remains in build-relevant files

### Requirement: Manual release practice
Releases SHALL be cut manually: a git tag `<releasever>.<patch>` (e.g. `43.0`), a GitHub Release named "Vojtux <version>" whose body links the ISO on self-hosted storage (cloud.vojtapolasek.eu, needed because GitHub rejects files over 2GiB), with the ISO's SHA256 checksum file attached as a release asset for verification via `sha256sum -c`. Verified by: release 43.0 exists as described.

#### Scenario: A new release is published
- **WHEN** the maintainer publishes release `<N>.<m>`
- **THEN** the GitHub Release shows the checksum asset and a working link to the ISO

### Requirement: Variants captured as-is
The supported build path SHALL be the English kickstart (`ks/vojtux_en.ks`). The Czech variant (`ks/vojtux_cs.ks`) and the container build (`dockerbuild/`) SHALL be treated as deprecated, as their own documentation states; they carry no behavioral requirements here and their remediation is tracked in the capturing change's Needs resolution list.

#### Scenario: Identify the supported path
- **WHEN** a contributor asks how to build Vojtux today
- **THEN** the answer is the host-based build of `ks/vojtux_en.ks`, not the cs kickstart nor dockerbuild

