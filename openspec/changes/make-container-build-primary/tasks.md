# Tasks

## 1. Single release definition

- [x] 1.1 Add `RELEASE` file at the repository root containing `43`; verify `cat RELEASE` prints `43`
- [x] 1.2 Add a consistency check (script or documented grep) that `ks/repos.ks` release references match `RELEASE`; verify it passes and fails when `RELEASE` is temporarily edited

## 2. Container build

- [x] 2.1 Create `containerbuild/Containerfile`: `ARG RELEASEVER`, `FROM registry.fedoraproject.org/fedora:${RELEASEVER}`, install `lorax-lmc-novirt pykickstart`, copy the repo tree, entrypoint `start.sh`
- [x] 2.2 Create `containerbuild/start.sh`: dbus setup (as in `dockerbuild/start.sh`), `ksflatten -c ks/vojtux_en.ks`, `livemedia-creator --make-iso --no-virt --iso-only --anaconda-arg="--noselinux" --project vojtux --releasever ${RELEASEVER} --iso-name vojtux_${RELEASEVER}.iso --tmp /live/tmp`, move the ISO to `/output`
- [x] 2.3 Create `containerbuild/build.sh`: read `RELEASE`; select runtime from `CONTAINER_TOOL` else auto-detect (podman preferred, docker fallback, clear error if neither); `<runtime> build --build-arg RELEASEVER=<N> -t vojtux-build:<N> -f containerbuild/Containerfile .`; runtime-specific run flags (podman: `--privileged --security-opt label=disable` + `:Z` volumes; docker: `--privileged -v /dev:/dev`) with repo and output bind mounts; fail fast (`set -euo pipefail`); chown artifacts to the calling user
- [x] 2.4 Verify the container build end-to-end with podman on a Fedora 44 host: `containerbuild/build.sh` produces `vojtux_43.iso` (LMC exit 0) and the ISO boots in the existing libvirt flow to a speech-enabled greeter (TC1) — verified on this F44 host: LMC SUMMARY ok, `containerbuild/output/vojtux_43.iso` produced, VM (repo `vojtux.xml` + findings-documented patches: 4G RAM/keyboard input, patched net subnet, initrd `systemd-sysroot-fstab-check` fix for the pre-existing dracut defect) boots to the MATE live desktop with lightdm active and orca running; logs in `buildlogs/`
- [x] 2.5 Smoke-test the docker runtime once: `CONTAINER_TOOL=docker containerbuild/build.sh` produces the same ISO (or document any docker gap in the Readme) — Fedora 44 offers no docker package, so the gap ("docker runtime implemented but exercised only by podman in CI; report docker-specific problems") is documented in the Readme instead

## 3. Remove the docker variant directory and update docs

- [x] 3.1 Delete `dockerbuild/`; verify `git grep -l dockerbuild -- ':!openspec/changes'` returns no references outside spec history; the docker workflow itself stays available via `containerbuild/build.sh` with docker selected
- [x] 3.2 Update `Readme.md` build instructions to `containerbuild/build.sh` (podman default, docker via `CONTAINER_TOOL=docker`, output location, host-local build kept as one-paragraph alternative); verify the prerequisites section mentions podman-or-docker

## 4. CI through the container path

- [x] 4.1 Rework `tests/vojtux_provision/setup.sh`: install `podman` instead of `lorax-lmc-novirt pykickstart`, build via `CONTAINER_TOOL=podman containerbuild/build.sh` into a temp dir, keep the ISO existence check and the bounded IP wait hardening; keep the libvirt VM define/start stage unchanged
- [ ] 4.2 Push and let the packit pull-request job run: verify the Testing Farm executor runs the privileged podman build successfully and the tmt test executes against the VM (this is the go/no-go gate for privileged containers on Testing Farm)

## 5. Verify

- [x] 5.1 `openspec validate make-container-build-primary --strict` passes
- [x] 5.2 Confirm rebase surface: bumping only `RELEASE` + `ks/repos.ks` + Readme is sufficient for a rebase (checklist walkthrough, no other version strings found by `git grep -n '\b43\b'` outside those files and archives) — the only remaining hits are narrative changelog text in `rpm/vojtux-settings.spec` and `TESTING.md` ("since Fedora 43 ..."), not build-relevant versions

## Workflow follow-up

- Maintainer reviews the spec deltas (removal of the `dockerbuild/` directory marked BREAKING in the proposal; docker capability itself is preserved via runtime selection).
- Archive the change so deltas merge into `openspec/specs/live-image-build/spec.md`.
