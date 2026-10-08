# Proposal

## Why

The image build currently happens directly on the host, so the build toolchain (lorax, anaconda, and the system `chpasswd` used during installation) comes from whatever release the host runs. Fedora 44's shadow-utils 4.19 rejected the legacy `locked` pseudo-hash used by the Fedora-43-pinned kickstart and broke CI with exactly this kind of host/target mismatch. Making a container build the primary path pins the toolchain to the target release: building Fedora 43 Vojtux always uses the Fedora 43 toolchain, no matter what the developer laptop or the CI executor runs.

## What Changes

- Introduce `containerbuild/` as the primary, documented way to build the Vojtux live image: a `Containerfile` based on `registry.fedoraproject.org/fedora:<N>` plus a `build.sh` host script that runs the build in a privileged container (for loop devices and mounts) with **podman or docker**; podman is the default/auto-detected runtime, docker remains fully supported so the workflow the original docker scripts provided keeps working.
- Add a single-source release definition (a `RELEASE` file at the repository root, e.g. `43`); the container base image tag, the `livemedia-creator --releasever` value and the ISO name are all derived from it.
- The old `dockerbuild/` directory (deprecated) is **BREAKING** removed and replaced by `containerbuild/`; the docker workflow itself is preserved through the runtime selection (only the invocation path changes, and the stale hardcoded release/ISO names are gone).
- The CI provisioning script `tests/vojtux_provision/setup.sh` builds the ISO through the same container path instead of installing `lorax-lmc-novirt` on the executor host; booting the Vojtux VM with libvirt stays on the executor host.
- Readme build instructions switch to the container path; the manual host-based build remains possible but is no longer the spec'd contract.

## Capabilities

### New Capabilities
<!-- none -->

### Modified Capabilities
- `live-image-build`: the build-host contract changes from "host runs Fedora N with lorax-lmc-novirt" to "host runs podman or docker and can run one privileged build container whose base image is the target release"; the build invocation goes through the container build script (podman preferred, docker supported, CI pins podman); the rebase checklist checks the single release definition instead of scattered version strings; the variants requirement no longer deprecates the container build (it becomes the supported path, replacing `dockerbuild/`).

## Impact

- New: `containerbuild/Containerfile`, `containerbuild/build.sh`, `containerbuild/start.sh`, `RELEASE` file.
- Removed: `dockerbuild/` (deprecated variant, superseded by `containerbuild/` which also runs on docker).
- Modified: `tests/vojtux_provision/setup.sh` (container-based ISO build in CI, explicitly using podman), `Readme.md` (build instructions), `openspec/specs/live-image-build` (via this change's deltas).
- CI: packit/Testing Farm executors no longer need the target release's lorax/anaconda packages; any executor release with a working podman and nested container privileges can build the image.
- Unchanged: kickstarts and their per-release repository pinning, the ISO-producing `livemedia-creator` command semantics, the acceptance-test VM boot/prepare flow (only how the ISO gets built changes).
