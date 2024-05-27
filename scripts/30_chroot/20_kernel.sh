#!/bin/sh
set -eu

echo \> Installing kernel
apt-get -y install --no-install-recommends \
    initramfs-tools \
    kmod \
    linux-virtual \
    zstd
