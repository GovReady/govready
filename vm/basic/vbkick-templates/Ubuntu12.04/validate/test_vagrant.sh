#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Feature: vagrant user
# Given vagrant user
if ! id vagrant >/dev/null 2>&1; then
    printf "\e[1;31mvagrant user: FAIL\n\e[0m"
    exit
fi
# When I login using ssh key
wget -q -O /tmp/vagrant.pub.tmp --no-check-certificate https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub
if ! diff ~vagrant/.ssh/authorized_keys /tmp/vagrant.pub.tmp >/dev/null 2>&1; then
    printf "\e[1;31mvagrant user - ssh key: FAIL\n\e[0m"
    exit
fi
rm -f /tmp/vagrant.pub.tmp
# And I run sudo command
if ! sudo -U vagrant -l | grep -w "may run" >/dev/null 2>&1; then
    printf "\e[1;31mvagrant user - sudo: FAIL\n\e[0m"
    exit
fi
# Then I expect success
printf "\e[1;32mvagrant user: OK\n\e[0m"
