#!/bin/sh
set -eu

sed -E 's/^( {1,4}|\t)//' <<EOF > /etc/default/grub.d/00_defaults.cfg
    GRUB_TIMEOUT_STYLE=menu
    GRUB_TIMEOUT=10
EOF
update-grub
