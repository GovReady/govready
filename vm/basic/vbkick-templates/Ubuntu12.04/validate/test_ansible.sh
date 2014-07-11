#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Feature: ansible provisioner
# Given ansible command
if ! command -v ansible >/dev/null 2>&1; then
    printf "\e[1;31mansible: FAIL\n\e[0m"
    exit
fi
# When I run "ansible --version" command
if ! ansible --version >/dev/null 2>&1; then
    printf "\e[1;31mansible --version: FAIL\n\e[0m"
    exit
fi
# Then I expect success
printf "\e[1;32mansible: OK\n\e[0m"
