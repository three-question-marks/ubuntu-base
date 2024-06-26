#!/bin/sh
set -eu

if [ "${PKR_INSTALL_QEMU_AGENT}" = 'true' ]; then
    echo \> Enabling QEMU Guest Agent
    systemctl enable qemu-guest-agent
fi
