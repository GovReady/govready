govready
========

An accreditation-helper and toolkit for making FISMA easier.

# Vision 
The GovReady vision is to make FISMA easier for innovators by

- making compliance part of Agile/DevOps
- sharing compliance status with Dev, Ops, Sec, and Mgt
- making baseline development collaborative
- providing trusted SCAP content that is open source friendly
- embracing compliance as a practice distinct from security


# Product
Our first product is "govready", a git-like utility for running FISMA scans and managing results. 

Install govready and have a much nicer time running security scans and managing reports. 

# License
Copyright 2013, 2014 Greg Elin and GovReady. All Rights Reserved.

GPL 3.0



# Install
Install is currently only for Linux RedHat, CentOS, Fedora 64 bit. (GovReady installs on Ubuntu 12 and 14, but Ubuntu SCAP content is scarce.)

Using curl
```
# Install
curl -Lk https://raw.githubusercontent.com/GovReady/govready/master/install.sh | sudo bash

# Uninstall
curl -Lk https://raw.githubusercontent.com/GovReady/govready/master/install.sh | sudo UNINSTALL=1 bash
```

For development, you can force install from a different branch. 
```
# Install branch other than master
curl -Lk https://raw.githubusercontent.com/GovReady/govready/master/install.sh | sudo BRANCH=branch_name bash

# Use an installer from a different branch
curl -Lk https://raw.githubusercontent.com/GovReady/govready/branch_name/install.sh | sudo BRANCH=branch_name bash
```

## Getting Started
First, use GovReady to install OpenSCAP and scap-security-guide content onto your system for doing scans.

```
# switch to root (Yes, this is undesirable, but govready is still pre-release)
su -
# install required packages
govready install_ssg
# exit root
exit
```

Next, run the default scan. Results written to `/var/www/govready/scans/`

```
govready scan

# If govready has problems accessing or writing files, adjust directory permissions or switching to root.
```

View results. Lynx browser will let you browse html report from command line.
```
lynx {profile}-results-{timestamp}.html

# Reports use profile name and timestamp added automatically. 
# Example:
lynx usgcb-rhel6-server-results-0611-1025.html

```

## Scan profiles/baselines
```
# List profiles
govready profiles

# Use specific profile. Default profile is usgcb-rhel6-server.
govready scan stig-rhel6-server-upstream


```

## Testmachines 
Use https://github.com/GovReady/testmachines for virtual machines to test GovReady.
