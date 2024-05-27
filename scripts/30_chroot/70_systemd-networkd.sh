#!/bin/sh
set -eu

echo \> Configuring systemd-networkd
systemctl enable systemd-networkd
sed -E 's/^( {1,4}|\t)//' <<EOF > /etc/systemd/network/90_default.network
    [Match]
    Name=en*
    
    [Network]
    DHCP=yes
EOF
