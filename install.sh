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
#  install branch:  curl -Lk https://raw.githubusercontent.com/GovReady/govready/master/install.sh | sudo BRANCH=branch bash


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
: ${PREFIX:=/usr/local/bin}

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

# What branch to install, master by default
: ${BRANCH:="master"}

# what scripts install/uninstall
BASH_TARGET="govready"
BASHCP_TARGET="govreadycp"

# utilities

_ping_govready(){
    # Ping GovReady to track a download
    GOVREADY_PING_URL="http://io.govready.org/io/"
    curl -Lkfso /dev/null  "${GOVREADY_PING_URL}"
}

# install directories
install_dirs(){
    ${INSTALL} -m 0755 -d "/var/www/govready/scans"
}

uninstall_dirs(){
    local DIR_TARGET="/var/www/govready/scans"
    if [[ ! -d "${DIR_TARGET}" ]]
    then
        rm -f "${DIR_TARGET}"
    else
        echo "${DIR_TARGET} not found"
    fi
}

install_bins(){
    TEMP_SRC="https://raw.githubusercontent.com/GovReady/govready/${BRANCH}/govready"
    TEMPCP_SRC="https://raw.githubusercontent.com/GovReady/govready/master/govreadycp"
    # Make sure permament Linux Hierarchy File System (HFS) dir exists with correct permissions
    log_info "Make sure directory ${PREFIX} exists"
    ${INSTALL} -m 0755 -d "${PREFIX}"
    # Download govready to temporary build dir
    log_info "Downloading and installing ${TEMP_SRC}"
    curl -Lksf "${TEMP_SRC}" -o "${BUILD_DIR}/${BASH_TARGET}.tmp" ||\
        (log_error "download govready bin failed." && return 1)
    # Install (move) files into permament Linux HFS dir
    ${INSTALL} -m 0755 -p "${BUILD_DIR}/${BASH_TARGET}.tmp" "${PREFIX}/${BASH_TARGET}"
    # Download govreadycp to temporary build dir
    log_info "Downloading and installing ${TEMPCP_SRC}"
    curl -Lksf "${TEMPCP_SRC}" -o "${BUILD_DIR}/${BASHCP_TARGET}.tmp" ||\
        (log_error "download govreadycp bin failed." && return 1)
    # Install (move) files into permament Linux HFS dir
    ${INSTALL} -m 0755 -p "${BUILD_DIR}/${BASHCP_TARGET}.tmp" "${PREFIX}/${BASHCP_TARGET}"
    #Remove temp files from download
    rm -rf "${BUILD_DIR}"
}

uninstall_bins(){
    # To Do: Make removal of files more module and less brittle
    if [[ -f "${PREFIX}/${BASH_TARGET}" ]] || [[ -f "${PREFIX}/${BASHCP_TARGET}" ]]
    then
        cd "${PREFIX}" 
        rm -f "${BASH_TARGET}"
        rm -f "${BASHCP_TARGET}"
        cd .. && rmdir "${PREFIX}"
    else
        echo "Neither ${PREFIX}/${BASH_TARGET} or ${PREFIX}/${BASHCP_TARGET} found"
        if [[ -d "${PREFIX}" ]]; then
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
    log_info "GovReady uninstall succeeded."
else
    log_info "Pinging GovReady"
    _ping_govready
    install_bins
    install_dirs
    log_info "GovReady install succeeded."
    echo "govready version"
    source ${PREFIX}/govready version
fi
