#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Note: 02/04/2014 - devtoolset is not available for CentOS yet,
# but you can easily use the Scientific Linux devtoolset repo (done in this script).
# If you prefer you can use as well one of these repos:
# - http://people.centos.org/tru/devtools-2/devtools-2.repo (please read: http://people.centos.org/)
# - http://linuxsoft.cern.ch/cern/devtoolset/slc6-devtoolset.repo (follow: http://linux.web.cern.ch/linux/devtoolset/)
# All SL GPG keys: https://www.scientificlinux.org/documentation/gpg/

yum -y install scl-utils scl-utils-build
# Install yum-conf-devtoolset
if ! yum list installed yum-conf-devtoolset >/dev/null 2>&1; then
    rpm --import https://www.scientificlinux.org/documentation/gpg/RPM-GPG-KEY-sl
    rpm -ivh http://ftp.scientificlinux.org/linux/scientific/6x/external_products/devtoolset/yum-conf-devtoolset-1.0-1.el6.noarch.rpm
fi

# Quick test:
#yum -y install devtoolset-2-vc
#scl enable devtoolset-2 'git --version'
