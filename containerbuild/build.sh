#!/bin/bash
# Build a Vojtux live ISO inside a privileged container (podman or docker).
# The build toolchain comes from the container base image pinned by RELEASE,
# so the host release does not need to match the target release.
set -euo pipefail

REPO_DIR=$(cd "$(dirname "$0")/.." && pwd)
cd "$REPO_DIR"

if [ ! -f RELEASE ]; then
  echo "RELEASE file not found at the repository root ($REPO_DIR)" >&2
  exit 1
fi
RELEASE=$(tr -d '[:space:]' < RELEASE)

containerbuild/check-release.sh

# Select the container runtime: CONTAINER_TOOL when set, else podman, else docker.
if [ -n "${CONTAINER_TOOL:-}" ]; then
  RUNTIME=$CONTAINER_TOOL
  command -v "$RUNTIME" >/dev/null 2>&1 || {
    echo "CONTAINER_TOOL=$RUNTIME not found in PATH" >&2
    exit 1
  }
elif command -v podman >/dev/null 2>&1; then
  RUNTIME=podman
elif command -v docker >/dev/null 2>&1; then
  RUNTIME=docker
else
  echo "No container runtime found. Install podman (or docker), see Readme prerequisites." >&2
  exit 1
fi

OUTPUT=${OUTPUT_DIR:-$REPO_DIR/containerbuild/output}
mkdir -p "$OUTPUT"

IMAGE=vojtux-build:${RELEASE}

"$RUNTIME" build \
  --build-arg RELEASEVER="$RELEASE" \
  -t "$IMAGE" \
  -f containerbuild/Containerfile \
  .

# Privileged for the loop devices and mounts needed by livemedia-creator --no-virt.
run_flags=(--rm --privileged)
vol_label=""
if [ "$RUNTIME" = "podman" ]; then
  # SELinux: let the privileged container work on the bind mounts
  run_flags+=(--security-opt label=disable)
  vol_label=":Z"
else
  # docker: expose /dev so that loop device nodes are usable
  run_flags+=(-v /dev:/dev)
fi

tty_flags=()
if [ -t 0 ] && [ -t 1 ]; then
  tty_flags=(-t)
fi

"$RUNTIME" run "${tty_flags[@]}" "${run_flags[@]}" \
  -e RELEASEVER="$RELEASE" \
  -v "$REPO_DIR:/target${vol_label}" \
  -v "$OUTPUT:/output${vol_label}" \
  "$IMAGE"

# The container writes artifacts as root; return them to the calling user.
if [ "$(id -u)" != "0" ]; then
  "$RUNTIME" run --rm \
    --entrypoint chown \
    -v "$OUTPUT:/output${vol_label}" \
    "$IMAGE" -R "$(id -u):$(id -g)" /output
fi

ISO=$(find "$OUTPUT" -name "vojtux_${RELEASE}.iso" -print -quit)
if [ -z "$ISO" ]; then
  echo "Build finished but vojtux_${RELEASE}.iso was not found in $OUTPUT" >&2
  exit 1
fi
