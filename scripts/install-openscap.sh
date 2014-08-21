#!/bin/sh

#
# Bash shell script to install openSCAP CentOS 6.x.
# Copyright 2014, Greg Elin
# License: Apache 2.0
#
# Usage: sudo sh ./install-openscap.sh
# Dependencies:
#   - none


# Install epel repos
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm

if [ ! -f /etc/yum.repos.d/epel-6-openscap.repo ]
then
	echo "openSCAP repo not installed, installing"
	# Install openSCAP as per http://www.open-scap.org/page/Download
	yum install openscap openscap-utils openscap-content
else
	echo "openSCAP already installed"
fi

rpm -q scap-security-guide > /dev/null
if [ $? -ne 0 ]
then
	echo "scap-security-guide not installed, installing"
	yum -y install scap-security-guide
else
	echo "scap-security-guide already installed"
fi


