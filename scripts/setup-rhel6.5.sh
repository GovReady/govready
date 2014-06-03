#!/bin/sh

#
# Bash shell script to set up RHEL6.5 with GovReady Toolkig
# Copyright 2014, Greg Elin
# License: GPL 3.0
# Version 0.0.1
#
# Usage: sudo sh setup-rhel6.5.sh
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

#install epel repos
install_epel(){
	if [ ! -f /etc/yum.repos.d/epel.repo ]
	then
		echo "installing epel repos "
		wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
		sudo rpm -Uvh epel-release-6*.rpm
	else 
		echo "epel already installed"
	fi
}

install_remi(){
	wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
	sudo rpm -Uvh remi-release-6*.rpm
}


# install openscap
install_openscap(){
	if [ ! -f /etc/yum.repos.d/epel-6-openscap.repo ]
	then
		echo "openSCAP repo not installed, installing"
		# Install openSCAP as per http://www.open-scap.org/page/Download
		yum install openscap openscap-utils openscap-content
	else
		echo "openSCAP already installed"
	fi
}

# install scap security guide
install_ssg(){
	rpm -q scap-security-guide > /dev/null
	if [ $? -ne 0 ]
	then
		echo "scap-security-guide not installed, installing"
		yum -y install scap-security-guide
	else
		echo "scap-security-guide already installed"
	fi
}


fail_guard(){
    log_error "Install/Uninstall failed."   
    exit 1
}

trap fail_guard SIGHUP SIGINT SIGTERM ERR
install_epel
install_remi
install_openscap
install_ssg

log_info "Install succeeded."
