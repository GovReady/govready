#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Feature: Virtualbox Guest Additions
# Given VBoxControl command
if ! command -v VBoxControl >/dev/null 2>&1; then
    printf "\e[1;31mVBoxControl: FAIL\n\e[0m"
    exit
fi
# When I run "VBoxControl --version" command
if ! VBoxControl --version >/dev/null 2>&1; then
    printf "\e[1;31mVBoxControl Version: FAIL\n\e[0m"
    exit
fi
# Then I expect version is up-to-date
version=$(VBoxControl --version | cut -f 1 -d"r") # 4.2.12r84980 -> 4.2.12
VBOX_VERSION=${VBOX_VERSION:-"0.0.0"}
if [[ $version == "${VBOX_VERSION}" ]]; then
    printf "\e[1;32mVirtualbox Guest Additions: OK\n\e[0m"
else
    printf "\e[1;31mVirtualbox Guest Additions: FAIL\n\e[0m"
fi
