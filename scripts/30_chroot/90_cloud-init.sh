#!/bin/sh
set -eu

if [ "${PKR_INSTALL_CLOUD_INIT}" = 'true' ]; then
    echo \> Installing cloud-init
    apt-get -y install --no-install-recommends cloud-init locales
fi
