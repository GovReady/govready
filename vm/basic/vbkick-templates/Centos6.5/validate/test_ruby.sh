#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Feature: ruby interpreter
# Given ruby command
if ! command -v ruby >/dev/null 2>&1; then
    printf "\e[1;31mruby: FAIL\n\e[0m"
    exit
fi
# When I run "ruby --version" command
if ! ruby --version >/dev/null 2>&1; then
    printf "\e[1;31mruby --version: FAIL\n\e[0m"
    exit
fi
# Then I expect success
printf "\e[1;32mruby: OK\n\e[0m"
