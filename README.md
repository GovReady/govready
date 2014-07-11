govready
========

Toolkit for getting open source apps ready for secure, approved government use

## About 
This about page is under development.

# License
Copyright 2013, 2014 Greg Elin and GovReady. All Rights Reserved.

GPL 3.0

## Demo

For a demo of the GovReady vision, text "wordpress" to 860-245-2269.

## Install
Install is currently only for Linux RedHat, CentOS, Fedora. Does not currently work on Ubuntu, OS X, or Windows. 

Using curl
```
# Install
curl -Lk https://raw.githubusercontent.com/GovReady/govready/master/install.sh | sudo bash

## Uninstall
curl -Lk https://raw.githubusercontent.com/GovReady/govready/master/install.sh | sudo UNINSTALL=1 bash

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

## Included Virtual Machines
The `vm` directory includes virtual machines for learning and testing GovReady. 

`vm/basic` provides for a multiple virtual machine environment for testing GovReady. 

`vm/basic/vbkick-templates` provides vbkick virtual machine configuration files for building VirtualBox VM's from source ISO and kick start files.
