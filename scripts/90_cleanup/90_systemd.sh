#!/bin/sh
set -eu

echo \> Resetting systemd random seed
rm -f /var/lib/systemd/random-seed
