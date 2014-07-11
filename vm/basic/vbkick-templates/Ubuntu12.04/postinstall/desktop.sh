#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

apt-add-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
apt-get -y update
apt-get -y install flashplugin-installer
