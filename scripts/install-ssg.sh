#!/bin/sh

#
# Bash shell script to install Scap Security Guide CentOS 6.x.
# Copyright 2014, Greg Elin
# License: Apache 2.0
#
# Usage: sudo sh install-ssg.sh
# Dependencies: 
#   - openscap, see install-openscap.sh
#
# rpm: scap-security-guide-0.1-16.el6.noarch


# If scap-security-guide not installed, install it
rpm -q scap-security-guide > /dev/null
if [ $? -ne 0 ]
then
	echo "scap-security-guide not installed, installing"
	yum -y install scap-security-guide
else
	echo "scap-security-guide already installed"
fi
