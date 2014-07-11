#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Zero out the free space to save space in the final image:
dd if=/dev/zero of=/EMPTY bs=1M || true
rm -f /EMPTY
