#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

if [[ ! -f "/etc/yum.repos.d/cfengine-community.repo" ]]; then
    rpm --import http://cfengine.com/pub/gpg.key
    # to check: rpm -qi gpg-pubkey | grep -i cfengine
    printf "[cfengine-repository]\nname=CFEngine\nbaseurl=http://cfengine.com/pub/yum/\nenabled=1\ngpgcheck=1\n" > /etc/yum.repos.d/cfengine-community.repo
fi
yum -y --enablerepo=cfengine-repository install cfengine-community
