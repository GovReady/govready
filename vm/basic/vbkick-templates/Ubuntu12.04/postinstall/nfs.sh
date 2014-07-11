#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Install NFS for Vagrant
apt-get -y install nfs-common
