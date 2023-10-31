#!/bin/sh
# Build a vojtx image in a docker container
set -eux

docker build -t vojtux .

TMP=./tmp
mkdir -p $TMP
chmod 777 $TMP
trap "rm -rf $TMP" EXIT

mkdir -p ./output
chmod 777 ./output

# we need priliged for the loopbacks and losetup to work
# likewise /dev needs to be mounted in also for the loopbacks
# but does not present to be a problem till after the squashfs runtime
time docker run \
	--privileged=true \
	-it --rm \
	-v /dev:/dev \
	-v ./tmp:/live/tmp \
	-v ./output:/output \
	vojtux:latest

du -sh $(pwd)/output
du -sh $TMP
sudo find $(pwd)/output -name vojtux_38.iso
