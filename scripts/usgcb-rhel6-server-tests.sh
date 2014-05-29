#!/bin/sh

#
# Bash shell script to run openSCAP test of RHEL-6
# Copyright 2014, Greg Elin
# License: Apache 2.0
#
# Usage: sudo sh openscap-ssg-rhel6.sh
# Dependencies: 
#   - openscap, see install-openscap.sh
#   - ssg, see install-ssg.sh
#

echo "oscap xccdf eval --profile usgcb-rhel6-server"
scandir="/var/www/govready-html/scans"
scapcontentdir="/usr/share/xml/scap/ssg/content"
suffix=$(date +%Y%m%d-%H-%M)


oscap xccdf eval --profile usgcb-rhel6-server \
	--results $scandir/usgcb-rhel6-server-$suffix.xml \
	--report $scandir/usgcb-rhel6-server-$suffix.html \
	--cpe $scapcontentdir/ssg-rhel6-cpe-dictionary.xml \
	$scapcontentdir/ssg-rhel6-xccdf.xml ; true

# Make result file readable
chmod o+r $scandir/usgcb-rhel6-server-$suffix.*

#
# Gotchas
#
# Adding the `; true` allows Vagrant to continue and not trap for exit status code `0` from scap run. 
# From oscap man page: 
#    Probe the system and evaluate all definitions from OVAL Definition file. Print result of  each  definition
#    to standard output. The return code is 0 after a  successful evaluation. On error, value 1 is returned.
#
