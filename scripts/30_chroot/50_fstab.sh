#!/bin/sh
set -eu

echo \> Configuring /etc/fstab
sed -E 's/^( {1,4}|\t)//' <<EOF > /etc/fstab
    # <device>                                    <dir> <type> <options> <dump> <fsck>
    UUID=$(blkid -o value -s UUID /dev/sda1)     /     ext4   defaults  0      1
EOF
