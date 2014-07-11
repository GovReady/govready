#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Base install
# Resync the package index files
apt-get -y update
apt-get -y dist-upgrade

# Tweak sshd to prevent DNS resolution (speed up logins)
if ! grep -q '^UseDNS no' /etc/ssh/sshd_config; then
    echo 'UseDNS no' >> /etc/ssh/sshd_config
fi

# Enable firewall
ufw --force enable
ufw allow 22/tcp
