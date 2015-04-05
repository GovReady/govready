## 0.6.0 - 04/05/2015
- Automatically unzip zip files during govready import
- Specify import directory in GovReadyfile
- Add `govready status` to easily check certain parameters
- Add `govready profile <profile>` to adjust scan profile

## 0.5.0 - 11/25/2014
- Added CHANGELOG to repo and [semantic versioning](http://semver.org)

## 0.4.7 - 09/20/2014
- `govready compare` defaults to comparing two most recent scans along rules passing in most recent scan

## 0.4.6 - 09/14/2014
- Installs and runs on Amazon Linux 2014.3 HVM 64 bit
- govready man page added
- Add documentation to GovReadyfile
- `govready compare scans/results_file_new.xml scans/results_file_old.xml` compares two different scan results

## 0.4.4 - 09/7/2014
- add command `govready rule <rule_id_string>` to show results of a specific rule on command line.

## 0.4.3 - 08/27/2014
- Add command line quick report of tests results that uses an xsltproc and xsl template
- Add soft links to most recently run scan results and fix script and share as part of command line quick report

## 0.4.2 - 08/22/2014
- Add `govready import` command to import SCAP content file into `scap/content/` directory. (Future versions of import will support bundled files #40)
- Fixed: scans are failing and quitting on a particular test on CENTOS #33

## 0.4.1 - 08/18/2014
- Add 'govready init` command to initialize a directory for tracking scans better.
- Add `GovReadyfile` to hold default parsing CPE and PROFILE key value pairs for `govready scan` command.
- Add better quick starts to read me
- Shorter install url of `io.govready.org/install`
- Automatically install dependencies upon initial install

## 0.3.x
- Adjust methods to work across RHEL, CentOS, and 
- Automate `curl` install, uninstall and branch install of govready
- Create http://github.com/GovReady/testmachines
- Added very simple install (e.g., download) tracking at io.govready.org

## earlier versions
- Create govready wrapper around `oscap` commands to simplify execution
- Automatically name and date stamp scan runs