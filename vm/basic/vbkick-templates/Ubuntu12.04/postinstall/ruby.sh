#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# Install Ruby
apt-get -y install ruby ruby-dev rubygems
