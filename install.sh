#!/bin/bash
#
# Copyright (c) 2014, Greg Elin/GovReady
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
set -e -E -u -o pipefail; shopt -s failglob; set -o posix; set +o histexpand

RED="\e[1;31m"
NORMAL="\e[0m"
log_error(){
    printf "${RED}[ERROR] ${*}${NORMAL}\n" >&2
}
log_info(){
    printf "[INFO] ${*}\n"
}

# default install location for bins and man
: ${MANDIR:=/usr/local/man/man1}
: ${PREFIX:=/usr/local/govready}

# get info about env. for default settings
BASH_DEFAULT=$(command -v bash || (log_error "bash command not available." && exit 1))

# prepare shebang - from env. or default
: ${BASH_SHEBANG:=${BASH_DEFAULT}}

# install command
INSTALL="install"

# prepare build directory
BUILD_DIR=$(mktemp -d -t 'govready_build.XXXXXXXXXX')

# what scripts install/uninstall
BASH_TARGET="epel.sh"

install_bins(){
    TEMP_SRC="https://raw.githubusercontent.com/GovReady/govready/master/scripts/epel.sh"
    # https://raw.githubusercontent.com/GovReady/govready/master/scripts/epel.sh
    curl -Lksf "${TEMP_SRC}" -o "${BUILD_DIR}/${BASH_TARGET}" ||\
        (log_error "download govready bin failed." && return 1)
    #${INSTALL} -m 0755 -d "${PREFIX}"
    #${INSTALL} -m 0755 -p "${BUILD_DIR}/${BASH_TARGET}.tmp" "${PREFIX}/${BASH_TARGET}"
    #rm -rf "${BUILD_DIR}"
}


# No error handling yet. Just testing.

echo "Installing into ${BUILD_DIR}/${BASH_TARGET}...\n"
install_bins
log_info "Install succeeded."

echo "Done\n"

