#!/bin/bash
set -e -E -u -o pipefail; shopt -s failglob;

# List 3rd party repositories: http://wiki.centos.org/AdditionalResources/Repositories
arch=$(uname -m)

# Add EL repository
if ! yum list installed elrepo-release >/dev/null 2>&1; then
    rpm --import http://elrepo.org/RPM-GPG-KEY-elrepo.org
    rpm -ivh http://elrepo.org/elrepo-release-6-5.el6.elrepo.noarch.rpm
fi

# Add EPEL repository
if ! yum list installed epel-release >/dev/null 2>&1; then
    rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6
    if [[ "${arch}" == 'x86_64' ]]; then
        rpm -ivh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
    elif [[ "${arch}" == 'i386' ]] || [[ "${arch}" = 'i686' ]]; then
        rpm -ivh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
    fi
fi

# Add Atrpms repository
#if ! yum list installed atrpms-repo >/dev/null 2>&1; then
#    rpm --import http://packages.atrpms.net/RPM-GPG-KEY.atrpms
#    if [[ "${arch}" == 'x86_64' ]]; then
#        rpm -ivh http://dl.atrpms.net/all/atrpms-repo-6-6.el6.x86_64.rpm
#    elif [[ "${arch}" == 'i386' ]] || [[ "${arch}" == 'i686' ]]; then
#        rpm -ivh http://dl.atrpms.net/all/atrpms-repo-6-6.el6.i686.rpm
#    fi
#fi

# Add Remi repository
#if ! yum list installed remi-release >/dev/null 2>&1; then
#    rpm --import http://rpms.famillecollet.com/RPM-GPG-KEY-remi
#    rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
#fi
