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


# Get Started

Use the quickstart appropriate to your OS.

( Need a vm to test GovReady? Try: https://github.com/GovReady/testmachines )

### RedHat 6, 7 quickstart (64 bit)

```
# Install govready using curl. govready will install OpenSCAP and SCAP-Security-Content
curl -Lk https://raw.githubusercontent.com/GovReady/govready/master/install.sh | sudo bash

# switch to root so scanner can run all tests properly
su - 

# Create a directory and cd into it
mkdir myfisma
cd myfisma

# Initialize the directory
govready init

# Run a scan
govready scan

# list results
ls -l scans

# view a report - from the command line, old school style using lynx browser
lynx scans/test-results-0820-0220.html

# See available profiles (e.g., baselines)
govready scan profiles

# Run a scan with a different baseline
govready scan usgcb-rhel6-server
```

### Centos 6 quickstart (64 bit)

```
# Install govready using curl. govready will install OpenSCAP and SCAP-Security-Content
curl -Lk https://raw.githubusercontent.com/GovReady/govready/master/install.sh | sudo bash

# switch to root so scanner can run all tests properly
su - 

# Create a directory and cd into it
mkdir myfisma
cd myfisma

# Initialize the directory
govready init

# Download and add CentOS cpe-dictionary.xml and cpe-oval.xml SCAP data
# Be certain to place the SCAP files into scap/content directory
wget https://raw.githubusercontent.com/GovReady/govready/xplatform/templates/ssg-centos6-cpe-dictionary.xml --output-document scap/content/ssg-centos6-cpe-dictionary.xml

wget https://raw.githubusercontent.com/GovReady/govready/xplatform/templates/ssg-centos6-cpe-oval.xml --output-document scap/content/ssg-centos6-cpe-oval.xml

# Update GovReadyfile using sed command (or update the CPE line manually using a text editor)
sed -i 's:^CPE.*:CPE = scap/content/ssg-centos6-cpe-dictionary.xml:' GovReadyfile

# Run a scan
govready scan

# list results
ls -l scans

# view a report - from the command line, old school style using lynx browser
lynx scans/test-results-0820-0220.html

# See available profiles (e.g., baselines)
govready scan profiles

# Run a scan with a different baseline
govready scan usgcb-rhel6-server

```

### Ubuntu 12 and 14 quick start (64 bit)

```
# Install govready using curl. govready will install OpenSCAP and SCAP-Security-Content
curl -Lk https://raw.githubusercontent.com/GovReady/govready/master/install.sh | sudo bash

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
