#!/bin/sh

# Install epel repos
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm
