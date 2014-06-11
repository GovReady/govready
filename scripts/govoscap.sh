#!/bin/bash

# name: govoscap.sh
# GovReady scan script
# Version: 0.0.1
# Copyright Greg Elin
# License: GPL
# usage: sudo sh -c "bash govoscap.sh"


suffix="$(date +%m%d-%H%M)"
profile="stig-rhel6-server-upstream"
resultsdir="/var/www/govready/scans"
oscap xccdf eval --profile $profile \
--results $resultsdir/$profile-results-$suffix.xml \
--report $resultsdir/$profile-results-$suffix.html \
--cpe /usr/share/xml/scap/ssg/content/ssg-rhel6-cpe-dictionary.xml \
/usr/share/xml/scap/ssg/content/ssg-rhel6-xccdf.xml

chmod go+r $resultsdir/$profile-results-$suffix.html
chmod go+r $resultsdir/$profile-results-$suffix.xml

# generate fix file
oscap xccdf generate fix --result-id xccdf_org.open-scap_testresult_$profile $resultsdir/$profile-results-$suffix.xml > $profile-fix-$suffix.sh

