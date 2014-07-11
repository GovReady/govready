#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Install docker-io
yum -y --enablerepo=epel install docker-io

if ! service docker status > /dev/null; then
    service docker restart
    service docker status || true
    # Usually: 'docker dead but subsys locked', better is just reboot the host.
    chkconfig docker on
fi

# Quick test
# sudo lxc-checkconfig
# sudo service docker status
# sudo docker info
# sudo docker run -i -t ubuntu /bin/bash
# sudo docker run -dns 8.8.8.8 centos ping google.com
