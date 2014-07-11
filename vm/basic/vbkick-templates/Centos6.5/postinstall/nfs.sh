#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Install NFS for Vagrant
yum -y install nfs-utils nfs-utils-lib
