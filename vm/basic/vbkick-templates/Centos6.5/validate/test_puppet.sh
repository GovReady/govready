#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Feature: puppet provisioner
# Given puppet command
if ! command -v puppet >/dev/null 2>&1; then
    printf "\e[1;31mpuppet: FAIL\n\e[0m"
    exit
fi
# When I run "puppet --version" command
if ! puppet --version >/dev/null 2>&1; then
    printf "\e[1;31mpuppet --version: FAIL\n\e[0m"
    exit
fi
# Then I expect success
printf "\e[1;32mpuppet: OK\n\e[0m"
