#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Feature: cfengine provisioner
# Given cfengine command
if [[ ! -f "/var/cfengine/bin/cf-agent" ]]; then
    printf "\e[1;31mcfengine: FAIL\n\e[0m"
    exit
fi
# When I run "/var/cfengine/bin/cf-promises --version" command
if ! /var/cfengine/bin/cf-promises --version >/dev/null 2>&1; then
    printf "\e[1;31m/var/cfengine/bin/cf-promises --version: FAIL\n\e[0m"
    exit
fi
# Then I expect success
printf "\e[1;32mcfengine: OK\n\e[0m"
