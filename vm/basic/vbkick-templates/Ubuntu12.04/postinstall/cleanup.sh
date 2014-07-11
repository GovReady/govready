#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Clean up
apt-get -y autoremove
apt-get -y clean

# Removing leftover dhcp leases
echo "cleaning up dhcp leases"
rm -rf /var/lib/dhcp/*

# Make sure Udev doesn't block our network - http://6.ptmc.org/?p=164
echo "Cleaning up udev rules"
rm -rf /etc/udev/rules.d/70-persistent-net.rules
mkdir /etc/udev/rules.d/70-persistent-net.rules
rm -rf /dev/.udev/
rm -rf /lib/udev/rules.d/75-persistent-net-generator.rules

# Adding a 2 sec delay to the interface up, to make the dhclient happy
if ! grep -q '^pre-up sleep 2' /etc/network/interfaces; then
    echo "pre-up sleep 2" >> /etc/network/interfaces
fi
