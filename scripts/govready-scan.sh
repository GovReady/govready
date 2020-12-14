#!/usr/bin/env bash

if [ $# -eq 0 ]; then
  echo "Usage: $0 instance-names..."
  echo "       This script runs 'govready scan' on instances accessible via SSH and"
  echo "       collects the results in a dated sub-directory along with a summary."
  echo "       Generally run from myfisma/ directory after 'govready init'."
  echo "       Override OSCAP variables with 'GOVREADY_' prefix, e.g.:"
  echo "       GOVREADY_OSCAP_USER=your_name govready-scan.sh my-instance"
  echo "Requires:"
  echo "       https://github.com/GovReady/govready (with 'govready' script in PATH)"
  echo "       https://github.com/OpenSCAP/openscap (install normally)"
  echo "       https://github.com/ComplianceAsCode/content/ (SCAP Security Guide)"
  exit 0
fi

DB_DATE=$(date "+%Y%m%d-%H%M")
GOV_OUT=${DB_DATE}/govready_out
SUMMARY=${DB_DATE}/summary.txt

OSCAP_VERSION=$(oscap -V|head -1)

mkdir -p ${DB_DATE}/govready_out

export GOVREADY_OSCAP_USER="${GOVREADY_OSCAP_USER:-monitor}"
export GOVREADY_OSCAP_SUDO="${GOVREADY_OSCAP_SUDO:-sudo}"
export GOVREADY_OSCAP_PORT="${GOVREADY_OSCAP_PORT:-22}"
export GOVREADY_PROFILE="${GOVREADY_PROFILE:-xccdf_org.ssgproject.content_profile_stig-rhel7-disa}"
export GOVREADY_XCCDF="${GOVREADY_XCCDF:-ssg-rhel7-ds.xml}"

# The `govready scan` script expects XCCDF files to be in a "scap" sub-directory.
if [ ! -d "scap" ]; then
  echo "No 'scap' subdirectory found."
  if [ -d "/usr/local/share/xml/scap/ssg/content" ]; then
    echo "Consider 'ln -s /usr/local/share/xml/scap/ssg/content scap'"
  else
    echo "Create a link called 'scap' to your SCAP Security Guide content"
  fi
  exit 1
fi
if [ -f "scap/${GOVREADY_XCCDF}" ]; then
  SSG_VERSION="$(sed -n '/<version.*>/{s/.*<version.*>\(.*\)<\/version>.*/\1/;p}' scap/${GOVREADY_XCCDF})"
fi
[ -z ${SSG_VERSION} ] && SSG_VERSION="(unknown)"

echo "Results from scanning instances on ${DB_DATE}" | tee "${SUMMARY}"
echo "Using ${OSCAP_VERSION}" | tee -a "${SUMMARY}"
echo "Using profile ${GOVREADY_PROFILE}" | tee -a "${SUMMARY}"
echo "From XCCDF data stream file ${GOVREADY_XCCDF} version ${SSG_VERSION}" | tee -a "${SUMMARY}"

govready_scan() {
  INSTANCE="${1}"
  echo "*${DB_DATE}/${INSTANCE}*" | tee -a "${SUMMARY}"
  GOVREADY_OSCAP_HOST=${INSTANCE} govready scan | tee "${GOV_OUT}/${INSTANCE}.txt"
  cp "scans/${GOVREADY_PROFILE}/${INSTANCE}/results.html" "${DB_DATE}/results-${INSTANCE}.html"
  grep 'This profile identifies' "${GOV_OUT}/${INSTANCE}.txt" | tee -a "${SUMMARY}"
}

# scan instances
for name in "$@"; do
  govready_scan "${name}"
done

# clean up summary
replace 'This profile identifies '  '- ' -- "${SUMMARY}"
replace 'medium severity' 'med severity' -- "${SUMMARY}"
replace 'low severity'  ' low severity' -- "${SUMMARY}"
replace 'selected controls'    'controls' -- "${SUMMARY}"
sed -i 's/ \([0-9]\) /  \1 /g' ${SUMMARY}

echo ""
ls -l ${DB_DATE}
