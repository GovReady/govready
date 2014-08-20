govready
========

An accreditation-helper and toolkit for making FISMA easier.

# Vision 
The GovReady vision is to make FISMA easier for innovators by:

- making compliance scanning part of Agile, DevOps and software supply chains
- sharing awareness of FISMA Risk Management progress among Dev, Ops, Sec, _and Mission_
- making risk management and baseline development collaborative and data-driven
- providing baselines and SCAP content that is open source friendly
- embracing compliance as an information-sharing practice distinct from security

# Product
Our first product is "govready", a git-like utility for running FISMA scans and managing results. 

In essence, govready is a wrapper around OpenSCAP (a NIST-certified SCAP Scanner) making it easier to 

We've built a frien

Think of govready as an accrediation-helper, making it easier to use a variety of tools to scan your system and lock it down according to official NIST guidance. 

Our 

# License
Copyright 2013, 2014 Greg Elin and GovReady. All Rights Reserved.

GPL 3.0

## Install
Install is currently only for Linux RedHat, CentOS, Fedora. Does not currently work on Ubuntu, OS X, or Windows. 

Using curl
```
# Install
curl -Lk https://raw.githubusercontent.com/GovReady/govready/master/install.sh | sudo bash

# Uninstall
curl -Lk https://raw.githubusercontent.com/GovReady/govready/master/install.sh | sudo UNINSTALL=1 bash
```

For development, you can force install a different branch. 
```
# Install branch other than master
curl -Lk https://raw.githubusercontent.com/GovReady/govready/master/install.sh | sudo BRANCH=branch_name bash
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
