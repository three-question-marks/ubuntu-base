#!/bin/sh
set -eu

echo \> Downloading and unpacking rootfs tarball
curl -sSL "${PKR_ROOTFS_URL}" | tar -zxC /mnt
