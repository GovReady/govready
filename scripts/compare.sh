#!/bin/bash

# usage:   bash ./compare.sh newresults.xml oldresults.xml pass[fail]
# examples
#   compare most recent pass result to an old scan:
#      bash ./compare.sh scans/results.xml scans/server-results-0910-1927.xml pass
#
#   compare new scan of failing to see what might have previously passed:
#      bash ./compare.sh scans/server-results-0910-1927.xml scans/results.xml fail

# For nice printing
_GREEN="\e[1;32m"
_RED="\e[1;31m"
_YELLOW="\e[1;33m"
_NORMAL="\e[0m"

newresults=$1
oldresults=$2
if [ -z $3 ]; then
  result="notdefined"
else
  result=$3
fi

# Set location of xsl files
FILTERRESULTSFILE=".govready/xml/filterresults.xsl"
RULEIDRESULTFILE=".govready/xml/ruleidresult.xsl"

cmd="xsltproc --stringparam result $result $FILTERRESULTSFILE $newresults"
echo "command: $cmd"
rules=$(eval $cmd)

printf "\nComparing $result results...\nA: $newresults  vs  B: $oldresults\n\n"

for ruleid in $rules; do
	# get result for a ruleid from new results
	cmd_newresults='xsltproc --stringparam ruleid "${ruleid}" $RULEIDRESULTFILE $newresults'
	newtestresult=$(eval $cmd_newresults)
	
	# get result for a ruleid from old results
	cmd_oldresults='xsltproc --stringparam ruleid "${ruleid}" $RULEIDRESULTFILE $oldresults'
	oldtestresult=$(eval $cmd_oldresults)
	
	# print out comparison
	if [ $newtestresult = "pass" ]; then
		printf "A: ${_GREEN}$newtestresult${_NORMAL}  "
	else
		printf "A: ${_RED}$newtestresult${_NORMAL}  "
	fi
	
	if [ $oldtestresult = "pass" ]; then
		printf "B: ${_GREEN}$oldtestresult${_NORMAL}  "
	else
		printf "B: ${_RED}$oldtestresult${_NORMAL}  "
	fi
	
	printf "rule = $ruleid\n"


	#if [ $oldtestresult != $newtestresult ]; then
	#	printf "A: ${newtestresult} where B: ${oldtestresult} for rule: $ruleid"
	#fi
done