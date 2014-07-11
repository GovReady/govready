#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# system clean-up
yum -y clean all

# Make sure Udev doesn't block our network - http://6.ptmc.org/?p=164
echo "Cleaning up udev rules"
rm -rf /etc/udev/rules.d/70-persistent-net.rules
mkdir /etc/udev/rules.d/70-persistent-net.rules
rm -rf /dev/.udev/
rm -rf /lib/udev/rules.d/75-persistent-net-generator.rules
