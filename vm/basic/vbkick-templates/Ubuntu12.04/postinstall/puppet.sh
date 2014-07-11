#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

if [[ ! -f "/etc/apt/sources.list.d/puppetlabs.list" ]]; then
    wget -O /tmp/puppetlabs-release-precise.deb http://apt.puppetlabs.com/puppetlabs-release-precise.deb
    dpkg -i /tmp/puppetlabs-release-precise.deb
    rm -f /tmp/puppetlabs-release-precise.deb
    apt-get -y update
fi
apt-get install -y hiera puppet facter
