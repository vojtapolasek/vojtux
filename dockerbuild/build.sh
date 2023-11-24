#!/bin/sh
# Build a vojtx image in a docker container

OUTPUT=$(pwd)/dockerbuild/output
TMP=$(pwd)/dockerbuild/tmp

prepdir () {
  mkdir -p $1
  chmod 777 $1
}

if [ "$0" != "dockerbuild/build.sh" && "$0" != "./dockerbuild/build.sh" ]; then
  echo 'wrong usage! Please call from the vojtux root directory! e.g.'
  echo 'dockerbuild/build.sh'
  if [ -z "$1" ]; then
    exit 1
  elif [ "$1" == '--force' ]; then
    echo 'using the force, soft fail'
  else
    exit 1
  fi
fi

set -eu
prepdir $TMP
prepdir $OUTPUT
trap "rm -rf $TMP" EXIT

if [ -f "dockerbuild/Dockerfile" ]; then
  docker build \
    -t vojtux \
    -f dockerbuild/Dockerfile \
    ./
else
  echo 'Dockerfile not found'
  exit 1
fi

# we need priliged for the loopbacks and losetup to work
# likewise /dev needs to be mounted in also for the loopbacks
# but does not present to be a problem till after the squashfs runtime
docker run \
  --privileged=true \
  -it --rm \
  -v /dev:/dev \
  -v $TMP:/live/tmp \
  -v $OUTPUT:/output \
  vojtux:latest

sudo find $OUTPUT -name vojtux_38.iso
