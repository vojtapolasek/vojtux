# Spec Delta

## ADDED Requirements

### Requirement: Containerized primary build
The live image SHALL be built primarily inside an OCI container whose base image tag is derived from `RELEASE`. The build SHALL run under podman or docker with the privileges required for loop devices and mounts; podman is the default and CI pins podman. Delivered by `containerbuild/Containerfile`, `containerbuild/build.sh`, `containerbuild/start.sh`, `RELEASE`. Verified by: CI packit test job building the ISO through the container path.

#### Scenario: Toolchain matches target release on a foreign host
- **WHEN** the image for release N is built on a host running a different Fedora release
- **THEN** the build succeeds using release N tooling from the container base image, without installing build packages on the host

#### Scenario: Building Vojtux 43 while host runs Fedora 44
- **WHEN** `containerbuild/build.sh` is executed on a Fedora 44 host for `RELEASE` 43
- **THEN** the ISO is produced by the Fedora 43 container and the user-creation step of the installation succeeds

#### Scenario: Docker-only host
- **WHEN** `containerbuild/build.sh` runs on a host that provides only docker
- **THEN** the build is executed with docker using equivalent privileges and produces the same ISO

## MODIFIED Requirements

### Requirement: Build host contract
Building SHALL be possible on any Fedora (or compatible) host that provides podman or docker capable of running one privileged container with loop-device access; the host's own release SHALL NOT need to match the target release and the host SHALL NOT need lorax/anaconda packages installed. Delivered by `containerbuild/build.sh` preconditions and `Readme.md`. Verified by: CI packit test job on its current executor.

#### Scenario: Prepare a build host
- **WHEN** a builder prepares to build the image
- **THEN** installing podman (or docker) is sufficient; no target-release packages or matching host release are required

### Requirement: Build invocation and output
The image SHALL be produced by running `containerbuild/build.sh`, which selects the container runtime (podman preferred, docker as fallback or explicit choice), builds the container image from `containerbuild/Containerfile` (base tag from the `RELEASE` file), runs `ksflatten` and `livemedia-creator --make-iso --no-virt --iso-only --anaconda-arg="--noselinux" --releasever <RELEASE> --iso-name vojtux_<RELEASE>.iso --project vojtux` inside it, and writes the resulting bootable live ISO labeled "vojtux" (release visible in the boot menu) to a host output directory; intermediate artifacts are discarded. A manual host-local build remains possible with the same livemedia-creator invocation but is not the spec'd path. Delivered by `containerbuild/build.sh`, `containerbuild/start.sh`. Verified by: TC1 boot of the produced ISO.

#### Scenario: Build finishes
- **WHEN** `containerbuild/build.sh` completes successfully
- **THEN** `vojtux_<N>.iso` exists in the host output directory and boots to a greeter with speech

#### Scenario: Version strings derived, not duplicated
- **WHEN** the build runs with `RELEASE` set to N
- **THEN** the container base tag, `--releasever` and the ISO name all reference N without any additional file being edited

### Requirement: Fedora rebase checklist
A Fedora rebase to release N SHALL update exactly: the `RELEASE` file, `ks/repos.ks` release references (fedora, updates, RPM Fusion, Copr baseurl), and Readme claims about the base release - the ISO name, container base tag and `--releasever` derive from `RELEASE` and MUST NOT need separate edits. Rationale: past rebases required a scavenger hunt (commits "s/38/43/g", "bump fedora to 43") and the CI executor mismatch (Fedora 44 toolchain vs Fedora 43 kickstart) was structurally prevented by the container build.

#### Scenario: Version bump is complete
- **WHEN** the project rebases to Fedora N
- **THEN** `RELEASE`, `ks/repos.ks` and the Readme reference N and no other build-relevant file carries a stale release number

### Requirement: Variants captured as-is
The supported build path SHALL be the containerized build of the English kickstart (`ks/vojtux_en.ks` via `containerbuild/`), runnable with podman or docker. The Czech variant (`ks/vojtux_cs.ks`) SHALL be treated as deprecated and carries no behavioral requirements here. The former `dockerbuild/` directory SHALL be removed, superseded by `containerbuild/`; the docker workflow it offered SHALL remain available through the runtime selection. Delivered by `containerbuild/`, absence of `dockerbuild/`.

#### Scenario: Identify the supported path
- **WHEN** a contributor asks how to build Vojtux today
- **THEN** the answer is `containerbuild/build.sh` (podman, or docker via runtime selection) with the English kickstart, not the cs kickstart and not the removed dockerbuild
