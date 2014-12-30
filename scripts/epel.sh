#!/bin/sh

# Install epel repos
. urls
curl -O "${EPEL_RPM_URL}"
curl -O "${REMI_RPM_URL}"
rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm
