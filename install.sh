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

. scripts/lib/env
. scripts/lib/common

# default install location for bins and man
: ${MANDIR:=/usr/local/man/man1}
: ${PREFIX:=/usr/local/bin}
: ${PREFIXMAN:=/usr/share/man/man1}

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
MAN_TARGET="govready.1"

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

    # Install govready
    TEMP_SRC="https://raw.githubusercontent.com/GovReady/govready/${BRANCH}/govready"
    # Make sure permament Linux Hierarchy File System (HFS) dir exists with correct permissions
    log_info "Make sure directory ${PREFIX} exists"
    ${INSTALL} -m 0755 -d "${PREFIX}"
    # Download govready to temporary build dir
    log_info "Downloading and installing ${TEMP_SRC}"
    curl -Lksf "${TEMP_SRC}" -o "${BUILD_DIR}/${BASH_TARGET}.tmp" ||\
        (log_error "download govready bin failed." && return 1)
    # Install (move) files into permament Linux HFS dir
    ${INSTALL} -m 0755 -p "${BUILD_DIR}/${BASH_TARGET}.tmp" "${PREFIX}/${BASH_TARGET}"

    # Install govreadycp
    TEMPCP_SRC="https://raw.githubusercontent.com/GovReady/govready/master/govreadycp"
    # Download govreadycp to temporary build dir
    log_info "Downloading and installing ${TEMPCP_SRC}"
    curl -Lksf "${TEMPCP_SRC}" -o "${BUILD_DIR}/${BASHCP_TARGET}.tmp" ||\
        (log_error "download govreadycp bin failed." && return 1)
    # Install (move) files into permament Linux HFS dir
    ${INSTALL} -m 0755 -p "${BUILD_DIR}/${BASHCP_TARGET}.tmp" "${PREFIX}/${BASHCP_TARGET}"

    # Install man pages
    TEMP_SRC="https://raw.githubusercontent.com/GovReady/govready/${BRANCH}/docs/man/govready.1"
    log_info "Downloading and installing ${TEMP_SRC}"
    # Download govready.1 to temporary build dir
    curl -Lksf "${TEMP_SRC}" -o "${BUILD_DIR}/${MAN_TARGET}.tmp" ||\
        (log_error "download govready man page failed." && return 1)
    # Install (move) files into permament Linux HFS dir
    ${INSTALL} -g 0 -o 0 -m 0644 "${BUILD_DIR}/${MAN_TARGET}.tmp" "${PREFIXMAN}/${MAN_TARGET}"
    gzip -f "${PREFIXMAN}/${MAN_TARGET}"

    # Remove temp files from download
    rm -rf "${BUILD_DIR}"
}

uninstall_bins(){
    # To Do: Make removal of files more module and less brittle
    if [[ -f "${PREFIX}/${BASH_TARGET}" ]] || [[ -f "${PREFIX}/${BASHCP_TARGET}" ]]
    then
        cd "${PREFIX}" 
        rm -f "${BASH_TARGET}"
        rm -f "${BASHCP_TARGET}"

        # Uninstall man page
        cd "${PREFIXMAN}"
        rm -f "${MAN_TARGET}"
        rm -f "${MAN_TARGET}.gz"

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
    log_error $1
    # clean BUILD_DIR if exist
    if [[ -d ${BUILD_DIR} ]]; then
        rm -rf ${BUILD_DIR}
    fi
    exit 1
}

trap 'fail_guard "$msg"' SIGHUP SIGINT SIGTERM ERR
if [[ ${UNINSTALL} -eq 1 ]]; then
    msg="GovReady uninstall falled."
    uninstall_bins
    log_info_success "GovReady uninstall succeeded."
    printf "${NORMAL}"
else
    msg="GovReady install falled."
    log_info "Pinging GovReady"
    _ping_govready
    install_bins
    install_dirs
    log_info_success "GovReady install succeeded."
    log_info_success "govready version"
    ${PREFIX}/govready version
    msg="GovReady install succeeded. OpenSCAP install falled."
    log_info "GovReady requires OpenSCAP. Installing. CTL-c to halt."
    ${PREFIX}/govready install_openscap
    msg="GovReady install succeeded. OpenSCAP install succeeded. SSG install falled."
    log_info "GovReady needs SCAP content. Installing SCAP-Security-Guide. CTL-c to halt."
    ${PREFIX}/govready install_ssg
fi
