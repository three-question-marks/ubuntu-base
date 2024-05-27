#!/bin/sh
set -eu

echo \> Changing root password
echo "root:root" | chpasswd
