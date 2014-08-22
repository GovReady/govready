govready
========

An accreditation-helper toolkit to make FISMA easier.

# Vision 
The GovReady vision is to make FISMA easier for innovators by

- making compliance part of Agile/DevOps
- sharing compliance progress data among Dev, Ops, Sec, and Mgt
- making baseline development collaborative
- providing trusted SCAP content with open source friendly licenses
- embracing compliance as a practice distinct from security


# Product
Our first product is "govready", a toolkit for running FISMA scans and managing results with a git-like feel. 

Govready uses (and is a contributor to) the NIST Certified SCAP 1.2 toolkit [OpenSCAP](https://github.com/OpenSCAP/openscap) and [Scap-Security-Guide](https://github.com/OpenSCAP/scap-security-guide). 

Our design goal is to make scanning easier and more collaborative regardless of your knowledge of FISMA.

# License
Copyright 2013, 2014 Greg Elin and GovReady. All Rights Reserved.

License: GPL 3.0

# Project Status
Govready is under heavy development and is pre-release. The current version is 0.4.x.

We recommend only using govready currently on non-production virtual machines. 

Feedback via GitHub issues is appreciated!

The govready toolkit is funded by a generous grant from the [John S and James L Knight Foundation](http://www.knightfoundation.org/grants/201345714/)

# Get Started

Below are several quickstarts. Use the quickstart for your preferred OS.

( Need a vm to test GovReady? Try: https://github.com/GovReady/testmachines )

### RedHat 6, 7 quickstart (64 bit)

```
# Install govready using curl. govready will install OpenSCAP and SCAP-Security-Content
curl -Lk io.govready.org/install | sudo bash

# Switch to root so scanner can run all tests properly
# It's OK. You are using a non-production vm, right?
su - 

# Create a directory and cd into it
mkdir myfisma
cd myfisma

# Initialize the directory
govready init

# Run a scan
govready scan

# List results
ls -l scans

# View a report - from the command line, old school style using lynx browser
lynx scans/test-results-0820-0220.html

# See available profiles (e.g., baselines)
govready profiles

# Run a scan for a different profile (e.g., baseline)
govready scan usgcb-rhel6-server
```

### Centos 6 quickstart (64 bit)

```
# Install govready using curl. govready will install OpenSCAP and SCAP-Security-Content
curl -Lk io.govready.org/install | sudo bash

# Switch to root so scanner can run all tests properly
su - 

# Create a directory and cd into it
mkdir myfisma
cd myfisma

# Initialize the directory
govready init

# Import CentOS cpe-dictionary.xml and cpe-oval.xml SCAP data
# Be certain to place the SCAP files into scap/content directory
govready import https://raw.githubusercontent.com/GovReady/govready/xplatform/templates/ssg-centos6-cpe-dictionary.xml
govready import https://raw.githubusercontent.com/GovReady/govready/xplatform/templates/ssg-centos6-cpe-oval.xml

# Update GovReadyfile using sed command (or update the CPE line manually using a text editor)
sed -i 's:^CPE.*:CPE = scap/content/ssg-centos6-cpe-dictionary.xml:' GovReadyfile

# Run a scan
govready scan

# List results
ls -l scans

# View a report - from the command line, old school style using lynx browser
lynx scans/test-results-0820-0220.html

# See available profiles (e.g., baselines)
govready profiles

# Run a scan for a different profile (e.g., baseline)
govready scan usgcb-rhel6-server

```

### Ubuntu 12 and 14 quick start (64 bit)

```
# Install govready using curl. govready will install OpenSCAP and SCAP-Security-Content
curl -Lk io.govready.org/install | sudo bash

# Sorry - this is all you can do on Ubuntu at the moment. :-(
# Fork the code and help us include Ubuntu and Debian!!
```


# Uninstall govready

Using curl
```
# Uninstall
curl -Lk https://raw.githubusercontent.com/GovReady/govready/master/install.sh | sudo UNINSTALL=1 bash
```

# Install development branches
```
# Install branch other than master
curl -Lk https://raw.githubusercontent.com/GovReady/govready/master/install.sh | sudo BRANCH=branch_name bash

# Use an installer from a different branch
curl -Lk https://raw.githubusercontent.com/GovReady/govready/branch_name/install.sh | sudo BRANCH=branch_name bash
```


# Testmachines 
Use https://github.com/GovReady/testmachines for virtual machines to test GovReady.
