#!/bin/sh
set -eu

echo \> Configuring systemd-resolved
systemctl enable systemd-resolved.service
ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
