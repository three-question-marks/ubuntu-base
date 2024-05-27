#!/bin/sh
set -eu

dd if=/dev/zero of=/zero.fill || true
rm -f /zero.fill
