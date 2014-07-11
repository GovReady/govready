#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Base install
yum -y update

## Consider:
# Basic: firewall.sh
# Basic: sysctl.sh
# Basic: service_mgm.sh (chkconfig)
# Basic: box_hardening.sh (e.g. http://people.redhat.com/sgrubb/files/usgcb/rhel5/workstation-ks.cfg)
