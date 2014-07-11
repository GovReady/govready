#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Feature: sudoers has disabled requiretty
# Given /etc/sudoers file
# When I grep /etc/sudoers file
if sudo cat /etc/sudoers | grep -E "Defaults[ ]+requiretty" | grep -vq "^#"; then
    printf "\e[1;31msudo requiretty: FAIL\n\e[0m"
    exit
fi
printf "\e[1;32msudo requiretty: OK\n\e[0m"
