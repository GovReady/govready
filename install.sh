#!/bin/bash
#
# Copyright (c) 2014, Greg Elin/GovReady
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# usage: 
#  install:    curl -Lk https://raw.githubusercontent.com/GovReady/govready/master/install.sh | sudo bash
#  uninstall:  curl -Lk https://raw.githubusercontent.com/GovReady/govready/master/install.sh | sudo UNINSTALL=1 bash

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

# Do you want install or uninstall software, by default install.
: ${UNINSTALL:=0}

# what scripts install/uninstall
BASH_TARGET="setup-rhel6.5.sh"

install_bins(){
    TEMP_SRC="https://raw.githubusercontent.com/GovReady/govready/master/scripts/setup-rhel6.5.sh"
    curl -Lksf "${TEMP_SRC}" -o "${BUILD_DIR}/${BASH_TARGET}.tmp" ||\
        (log_error "download govready bin failed." && return 1)
    ${INSTALL} -m 0755 -d "${PREFIX}"
    ${INSTALL} -m 0755 -p "${BUILD_DIR}/${BASH_TARGET}.tmp" "${PREFIX}/${BASH_TARGET}"
    rm -rf "${BUILD_DIR}"
}

uninstall_bins(){
    if [[ ! -f "${PREFIX}/${BASH_TARGET}" ]]; then
        cd "${PREFIX}" && rm -f "${BASH_TARGET}"
        cd .. && rmdir "${PREFIX}"
    else
        echo "${PREFIX}/${BASH_TARGET} not found"
        if [[ ! -f "${PREFIX}" ]]; then
            rmdir "${PREFIX}"
        else
            echo "${PREFIX} not found"
        fi
    fi

}

fail_guard(){
    log_error "Install/Uninstall failed."
    # clean BUILD_DIR if exist
    if [[ -d ${BUILD_DIR} ]]; then
        rm -rf ${BUILD_DIR}
    fi
    exit 1
}

trap fail_guard SIGHUP SIGINT SIGTERM ERR
if [[ ${UNINSTALL} -eq 1 ]]; then
    uninstall_bins
    log_info "Uninstall succeeded."
else
    install_bins
    log_info "Install succeeded. ${BUILD_DIR}/${BASH_TARGET}"
fi
