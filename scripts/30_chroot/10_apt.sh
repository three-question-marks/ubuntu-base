#!/bin/sh
set -eu

echo \> Configuring APT sources
. /etc/lsb-release

sed -E 's/^( {1,4}|\t)//' <<EOF > /etc/apt/sources.list
    deb ${PKR_APT_MIRROR} ${DISTRIB_CODENAME} main universe restricted multiverse
    # deb-src ${PKR_APT_MIRROR} ${DISTRIB_CODENAME} main universe restricted multiverse

    deb ${PKR_APT_MIRROR} ${DISTRIB_CODENAME}-updates main universe restricted multiverse
    # deb-src ${PKR_APT_MIRROR} ${DISTRIB_CODENAME}-updates main universe restricted multiverse
    
    deb ${PKR_APT_MIRROR} ${DISTRIB_CODENAME}-security main universe restricted multiverse
    # deb-src ${PKR_APT_MIRROR} ${DISTRIB_CODENAME}-security main universe restricted multiverse
    
    deb ${PKR_APT_MIRROR} ${DISTRIB_CODENAME}-backports main universe restricted multiverse
    # deb-src ${PKR_APT_MIRROR} ${DISTRIB_CODENAME}-backports main universe restricted multiverse
EOF

echo \> Updating packages
apt-get update
apt-get -y install --no-install-recommends \
    apt-utils \
    dialog
apt-get -y upgrade --no-install-recommends
