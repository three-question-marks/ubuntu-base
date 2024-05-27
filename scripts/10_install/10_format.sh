#!/bin/sh
set -eu

echo \> Creating and mounting root partition
echo "n\np\n1\n\n\na\nw\n" \
  | fdisk /dev/sda
mkfs.ext4 -O 64bit /dev/sda1
mount /dev/sda1 /mnt
