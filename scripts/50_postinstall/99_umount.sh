#!/bin/sh
set -eu

echo \> Unmounting pseudo filesystems
umount /mnt/dev/pts
umount /mnt/dev
umount /mnt/sys
umount /mnt/proc
umount /mnt/run
umount /mnt/tmp
