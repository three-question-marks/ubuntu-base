#!/bin/sh
set -eu

echo \> Mounting pseudo filesystems to chroot environment
mount -t proc proc /mnt/proc
mount -t sysfs sys /mnt/sys
mount -o bind /dev /mnt/dev
mount -t devpts none /mnt/dev/pts
mount -t tmpfs run /mnt/run
mount -t tmpfs tmpfs /mnt/tmp
