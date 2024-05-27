#!/bin/sh
set -eu

echo \> Installing OpenSSH
apt-get -y install --no-install-recommends \
    openssh-server \
    libpam-systemd # https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=751636
