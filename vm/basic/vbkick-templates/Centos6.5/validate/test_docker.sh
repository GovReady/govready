#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Feature: docker.io
# Given docker command
if ! command -v docker >/dev/null 2>&1; then
    printf "\e[1;31mdocker: FAIL\n\e[0m"
    exit
fi
# When I run "docker version" command
if ! sudo docker version >/dev/null 2>&1; then
    printf "\e[1;31mdocker version: FAIL\n\e[0m"
    exit
fi
# Then I expect success
printf "\e[1;32mdocker: OK\n\e[0m"
