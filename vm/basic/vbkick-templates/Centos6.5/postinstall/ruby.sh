#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Install Ruby
yum -y install ruby ruby-devel rubygems
