#!/bin/sh
set -eu

echo \> Temporarely copying DNS settings
cp -f /etc/resolv.conf /mnt/etc/resolv.conf
