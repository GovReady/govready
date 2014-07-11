#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Puppet Labs repositories
arch=$(uname -m)

# Install puppet
if ! yum list installed puppetlabs-release >/dev/null 2>&1; then
    rpm --import https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs
    if [[ "${arch}" == 'x86_64' ]]; then
        rpm -ivh http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-10.noarch.rpm
    elif [[ "${arch}" == 'i386' ]] || [[ "${arch}" == 'i686' ]]; then
        rpm -ivh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-10.noarch.rpm
    fi
fi
yum -y install hiera puppet facter
