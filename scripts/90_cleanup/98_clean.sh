#!/bin/sh
set -eu

echo \> Removing all cache
find /var/cache -type f -delete
echo \> Removing all logs
find /var/log -type f -exec truncate --size=0 {} \;
echo \> Removing temporary files
rm -rf /var/tmp/*
