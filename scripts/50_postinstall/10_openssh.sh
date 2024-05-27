#!/bin/sh
set -eu

echo \> Inserting SSH key
mkdir -pm 700 /mnt/root/.ssh
cloud-init query -f '{{ ds.meta_data.public_ssh_keys[0] }}' > /mnt/root/.ssh/authorized_keys
chmod 644 /mnt/root/.ssh/authorized_keys
