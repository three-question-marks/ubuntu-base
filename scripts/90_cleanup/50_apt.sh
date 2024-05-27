#!/bin/sh
set -eu

echo \> Purging APT cache
apt-get -y autoremove --purge
apt-get -y clean
rm -rf /var/cache/apt/archives /var/lib/apt/lists/*
