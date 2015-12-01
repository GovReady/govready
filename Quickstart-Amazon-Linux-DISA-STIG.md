### Amazon Linux (2014.03 HVM ami-76817c1e) quickstart (64 bit)
Note: **This Quickstart is fragile and may fail**

```
# Download OpenSCAP RPMs for Amazon Linux. (Thanks to Owen for building the RPMs)
# Note: This is experimental, no signing yet of RPMs

wget http://c8a44eea0cdc23b7463e-ee42454716106089a169830ef1c408ef.r15.cf5.rackcdn.com/openscap-1.0.3-2.amzn1.x86_64.rpm
wget http://c8a44eea0cdc23b7463e-ee42454716106089a169830ef1c408ef.r15.cf5.rackcdn.com/openscap-devel-1.0.3-2.amzn1.x86_64.rpm
wget http://c8a44eea0cdc23b7463e-ee42454716106089a169830ef1c408ef.r15.cf5.rackcdn.com/openscap-engine-sce-1.0.3-2.amzn1.x86_64.rpm
wget http://c8a44eea0cdc23b7463e-ee42454716106089a169830ef1c408ef.r15.cf5.rackcdn.com/openscap-engine-sce-devel-1.0.3-2.amzn1.x86_64.rpm
wget http://c8a44eea0cdc23b7463e-ee42454716106089a169830ef1c408ef.r15.cf5.rackcdn.com/openscap-extra-probes-1.0.3-2.amzn1.x86_64.rpm
wget http://c8a44eea0cdc23b7463e-ee42454716106089a169830ef1c408ef.r15.cf5.rackcdn.com/openscap-python-1.0.3-2.amzn1.x86_64.rpm
wget http://c8a44eea0cdc23b7463e-ee42454716106089a169830ef1c408ef.r15.cf5.rackcdn.com/openscap-utils-1.0.3-2.amzn1.x86_64.rpm

# Retrieve CentOS SCAP-Security-Guide RPM

#(expired) wget http://mirror.centos.org/centos/6/os/x86_64/Packages/scap-security-guide-0.1.18-3.el6.noarch.rpm
wget http://mirror.centos.org/centos/6/os/x86_64/Packages/scap-security-guide-0.1.21-3.el6.noarch.rpm

# Install the OpenSCAP RPMs using localinstall method
sudo yum --nogpgcheck localinstall -y *.rpm

# Install SCAP-Security-Guide
sudo yum install --enablerepo=epel scap-security-guide -y

# Install Lynx
sudo yum install lynx -y

# Install govready using curl. govready will install OpenSCAP and SCAP-Security-Content
curl -Lk io.govready.org/install | sudo bash

# Set a password for root
sudo passwd root

# Switch to root so scanner can run all tests properly
su -

# Create a directory and cd into it
mkdir myfisma
cd myfisma

# Initialize the directory
govready init

# Import DISA IASE STIG file for RHEL6, which seems to work on AWS Linux
# For more information see: http://iase.disa.mil/stigs/scap/Pages/index.aspx
govready import http://iase.disa.mil/stigs/Documents/U_RedHat_6_V1R6_STIG_SCAP_1-1_Benchmark.zip 

# Update GovReadyfile  to use stig XCCDF using sed (or update the CPE line manually using a text editor)
sed -i 's:^XCCDF.*:XCCDF = scap/content/U_RedHat_6_V1R6_STIG_SCAP_1-1_Benchmark-xccdf.xml:' GovReadyfile
sed -i 's:^CPE.*:CPE = scap/content/U_RedHat_6_V1R6_STIG_SCAP_1-1_Benchmark-cpe-dictionary.xml:' GovReadyfile

# See newly available profiles
govready profiles

# Set profile to MAC-3_Public
govready profile MAC-3_Public
govready status

# Run a scan
govready scan

# List results
ls -l scans

# View a report - from the command line, old school style using lynx browser
# Example - your file name may differ
lynx scans/results.html

```
