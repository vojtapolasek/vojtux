# Design

## Context

Today the ISO is built by `tests/vojtux_provision/setup.sh` directly on the CI executor (dnf-install `lorax-lmc-novirt`, run `livemedia-creator --no-virt`), and the Readme documents the same host-local flow. A deprecated docker variant (`dockerbuild/`, FROM fedora:43, privileged `docker run`, `start.sh` doing `dbus-daemon` + `ksflatten` + `livemedia-creator`) already proves the container pattern works; it is stale (own hardcoded ISO name/releasever, docker-only) and deprecated by spec. The F44-executor CI breakage (shadow-utils 4.19 `chpasswd` vs the F43 kickstart's `locked` pseudo-hash) demonstrated the host/toolchain mismatch risk this change removes. Constraints: Fedora hosts have podman (no docker), SELinux is enforcing, the CI executor is a Testing Farm guest with nested-virtualization privileges.

## Goals / Non-Goals

**Goals:**
- One command (`containerbuild/build.sh`) produces the ISO on any Fedora host with podman (or docker).
- Build toolchain == target release, derived from one `RELEASE` value.
- CI builds the ISO via the same code path as developers (no separate host-toolchain contract).
- The docker workflow contributed via `dockerbuild/` keeps working (through runtime selection), honoring its author's intent.

**Non-Goals:**
- Not changing the acceptance-test VM boot/provision stage (stays libvirt on the executor host).
- Not hermetic/digest-pinned builds or reproducible-build guarantees.
- Not dropping kickstart repository pinning (`ks/repos.ks` stays release-pinned).
- Not supporting rootless podman for the build.

## Decisions

- **Dual runtime: podman preferred, docker supported.** `build.sh` uses `CONTAINER_TOOL` when set, else auto-detects podman, else docker, else fails with a pointer to prerequisites; CI (`setup.sh`) exports `CONTAINER_TOOL=podman` explicitly. Rationale: podman is Fedora-native/daemonless (project default and what CI runs), while docker support preserves the workflow the original docker scripts established for its contributor. Runtime-specific flags live in one `run_flags` case block: podman adds `--security-opt label=disable` and `:Z` volume labels (SELinux); docker gets `-v /dev:/dev` (as in the old `dockerbuild/build.sh`) and no SELinux options. Alternative (podman-only, docker "may work") rejected: knowingly breaking a contributor's supported workflow for no gain. Alternative (keep separate `dockerbuild/` and add `containerbuild/`): rejected — duplicated flow that drifts (exactly how dockerbuild rotted); one script with a runtime variable keeps a single source of truth. Buildah rejected: no benefit, same privileges needed.
- **New `containerbuild/` directory with `Containerfile`; delete `dockerbuild/`.** Clear rename signals the new contract and avoids "docker" in a podman world; history is preserved in git. Alternative (rename in place) rejected for review clarity in a PR.
- **`RELEASE` file at repo root as the single version source** (content: one integer, e.g. `43`). `build.sh` reads it and injects `--build-arg RELEASEVER=<N>` at image build time and passes the ISO name; `start.sh` uses `$RELEASEVER` for `--releasever`/`--iso-name`. Alternatives: derive N by parsing `ks/repos.ks` (fragile), Makefile (project has no make convention), env var only (no discoverable default).
- **Privileged container:** required for loop devices + mounts by `livemedia-creator --no-virt` (same requirement the old dockerbuild documented); granular capability grants are brittle across runtime releases. Podman invocation: `podman run --rm --privileged --security-opt label=disable -v <repo>:/target:Z -v <out>:/output:Z`; docker invocation mirrors it (`--privileged`, explicit `-v /dev:/dev`, no SELinux label options). The container does no untrusted work, so privileged mode is an accepted trade-off on both runtimes.
- **Container installs the build toolchain at image-build time** (`lorax-lmc-novirt`, `pykickstart`) from the release-pinned base `registry.fedoraproject.org/fedora:<N>`; tags the tool image `vojtux-build:<N>` so rebases invalidate cache naturally. Tool updates flow with the base/`dnf update`; digest pinning deferred as a possible refinement.
- **CI (`tests/vojtux_provision/setup.sh`)** replaces `dnf install … lorax-lmc-novirt` + host `livemedia-creator` with `dnf install -y podman` + `CONTAINER_TOOL=podman containerbuild/build.sh` (output dir on the executor), then continues exactly as today (move ISO into libvirt images, define/start VM, wait for IP) keeping the fail-fast hardening. Alternative (build in a plain F43 VM instead of container) rejected: heavier, needs base-image lifecycle management, same kernel-shared isolation level is sufficient here.

## Risks / Trade-offs

- [Testing Farm could restrict privileged containers] → Smoke-test the packit job early in implementation (task 4); host-local build path stays documented as fallback until proven.
- [Root-owned ISO/artifacts in the output dir] → `build.sh` chowns outputs to the invoking user (`podman run -u` mapping where practical, else explicit chown step).
- [Container adds pull/build time vs dnf on host] → roughly neutral (dnf of ~580 packages today vs ~200MB pull + small layer); image tag caching removes repeat builds.
- [Privileged container weakens isolation; kernel shared with host] → accepted: the build consumes only trusted repo content, same as today's host build (which is not sandboxed at all).
- [`RELEASE` and `ks/repos.ks` can still drift] → rebase checklist task + a cheap consistency grep (repos.ks mentions `RELEASE`) as a task in CI test plan.
- [podman vs docker behavioral gaps (e.g. `/dev` handling, SELinux labels, dbus in container)] → keep `dockerbuild/start.sh`'s proven dbus + lmc sequence, adapt only paths/args; per-runtime flag block reviewed against the old docker invocation.
- [docker path not exercised by CI (podman-only there), so it can rot silently] → manual docker smoke build required once during implementation (task 2.5) and listed in the release checklist; single shared script keeps drift bounded to the flag block.

## Migration Plan

1. Land `containerbuild/` + `RELEASE` + Readme update; keep `dockerbuild/` removal in the same PR — docker users keep working via `containerbuild/build.sh` (docker runtime), so nothing beyond the invocation path changes.
2. Switch `setup.sh` to the container path (pinned to podman); packit run on the PR validates privileged podman on Testing Farm (the go/no-go gate).
3. Rollback = revert the commit; the host-local invocation remains documented in git history and as an alternative paragraph in the Readme.

## Open Questions

- Whether to also verify the ISO's root lock state (the F44 `chpasswd` regression) as a scripted smoke test inside CI after boot — likely a follow-up change rather than part of this one.
