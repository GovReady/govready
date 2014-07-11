#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Install lxc-docker using ubuntu repo from docker.io

# Extra packages needed
apt-get -y install curl apt-transport-https

# Add the Docker repository
if [[ ! -f "/etc/apt/sources.list.d/docker.list" ]]; then
    #curl -k https://get.docker.io/gpg | apt-key add -
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
    echo 'deb https://get.docker.io/ubuntu docker main' > /etc/apt/sources.list.d/docker.list
    apt-get -y update
fi

# Install lxc-docker
apt-get -y install lxc-docker --force-yes

# Update grub to enable memory and swap accounting (reboot required): http://docs.docker.io/en/latest/installation/kernel/
sed -i 's:^#GRUB_CMDLINE_LINUX=:GRUB_CMDLINE_LINUX=:' /etc/default/grub
sed -i 's:^GRUB_CMDLINE_LINUX=.*:GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1":' /etc/default/grub
update-grub

# Update firewall to all forwarding traffic
sed -i 's:^DEFAULT_FORWARD_POLICY="DROP":DEFAULT_FORWARD_POLICY="ACCEPT":' /etc/default/ufw
ufw reload
ufw allow 4243/tcp

# Quick test
# sudo lxc-checkconfig
# sudo service docker status
# sudo docker info
# sudo docker run -i -t ubuntu /bin/bash
# sudo docker run -dns 8.8.8.8 centos ping google.com
