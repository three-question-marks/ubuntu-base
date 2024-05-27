#!/bin/sh
set -eu

echo \> Installing bootloader
apt-get install -y --no-install-recommends \
    grub-pc \
    lsb-release
grub-install /dev/sda
update-grub
