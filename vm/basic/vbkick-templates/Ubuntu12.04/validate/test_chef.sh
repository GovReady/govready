#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Feature: chef provisioners
# Given chef-client command
if ! command -v chef-client >/dev/null 2>&1; then
    printf "\e[1;31mchef-client: FAIL\n\e[0m"
    exit
fi
# And chef-solo command
if ! command -v chef-solo >/dev/null 2>&1; then
    printf "\e[1;31mchef-solo: FAIL\n\e[0m"
    exit
fi
# When I run "chef-client --version" command
if ! chef-client --version >/dev/null 2>&1; then
    printf "\e[1;31mchef-client --version: FAIL\n\e[0m"
    exit
fi
# And I run "chef-solo --version" command
if ! chef-solo --version >/dev/null 2>&1; then
    printf "\e[1;31mchef-solo --version: FAIL\n\e[0m"
    exit
fi
# Then I expect success
printf "\e[1;32mchef: OK\n\e[0m"
