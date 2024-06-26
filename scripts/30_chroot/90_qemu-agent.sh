#!/bin/sh
set -eu

if [ "${PKR_INSTALL_QEMU_AGENT}" = 'true' ]; then
    echo \> Installing QEMU Guest Agent
    apt-get install -y --no-install-recommends \
        qemu-guest-agent
fi
