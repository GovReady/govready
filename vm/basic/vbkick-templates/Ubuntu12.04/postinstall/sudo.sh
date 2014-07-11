#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Allow sudo commands without a tty
sed -i "s/\(^Defaults[ ]\+requiretty\)/#\1/" /etc/sudoers
