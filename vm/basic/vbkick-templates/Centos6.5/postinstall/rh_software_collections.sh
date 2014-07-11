#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Install software collections
yum -y install scl-utils scl-utils-build centos-release-SCL

# Quick test:
#yum -y install python33
#scl enable python33 'python --version'
