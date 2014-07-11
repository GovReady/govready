#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

VBOX_VERSION=${VBOX_VERSION:-"0.0.0"}
# Do we have any virtualbox guest additions installed ?
if VBoxControl --version >/dev/null 2>&1; then
    version=$(VBoxControl --version | cut -f 1 -d"r") # 4.2.12r84980 -> 4.2.12
    # Expected version is installed, exit
    if [[ $version == "${VBOX_VERSION}" ]]; then
        exit 0
    fi
fi

# Installing the virtualbox guest additions
# VBoxGuestAdditions iso is attached (by vbkick) to SATA Controller port 1 device 0
mnt_point=/mnt
if [[ -b /dev/sr1 ]]; then
    if grep -q /dev/sr1 /proc/mounts; then
        mnt_point=$(printf $(grep /dev/sr1 /proc/mounts | cut -f2 -d' '))
    else
        mount /dev/sr1 "${mnt_point}"
    fi
elif [[ -b /dev/sr0 ]]; then
    if grep -q /dev/sr0 /proc/mounts; then
        mnt_point=$(printf $(grep /dev/sr0 /proc/mounts | cut -f2 -d' '))
    else
        mount /dev/sr0 "${mnt_point}"
    fi
else
    exit 1
fi
# true because whene there is noX on the server additions_script return 1: "Installing the Window System drivers [FAILED]"
pushd "${mnt_point}"
    sh VBoxLinuxAdditions.run || true
popd
umount "${mnt_point}"
