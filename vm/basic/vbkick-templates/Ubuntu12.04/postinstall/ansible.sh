#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Install ansible
add-apt-repository -y ppa:rquillo/ansible
apt-get -y update
apt-get -y install ansible
