Look up simple profile example
Can I break up the large file into small files and run tests separately?

create branch of centos-openscap
git checkout -b unbundled
study profile to see how 



echo "oscap xccdf eval --profile usgcb-rhel6-server"

oscap xccdf eval --profile usgcb-rhel6-server \
	--results /var/www/govready-html/usgcb-rhel6-server.xml \
	--report /var/www/govready-html/usgcb-rhel6-server.html \
	--cpe /usr/share/xml/scap/ssg/content/ssg-rhel6-cpe-dictionary.xml \
	/usr/share/xml/scap/ssg/content/ssg-rhel6-xccdf.xml ; true
	


profile="usgcb-rhel6-server"
oscap xccdf eval --profile $profile \
	--results /var/www/govready-html/$profile.xml \
	--report /var/www/govready-html/$profile.html \
	--cpe /usr/share/xml/scap/ssg/content/ssg-rhel6-cpe-dictionary.xml \
	/usr/share/xml/scap/ssg/content/ssg-rhel6-xccdf.xml ; true


profile="usgcb-rhel6-server"
oscap xccdf eval --profile $profile \
	--results /var/www/govready-html/$profile2-fixed.xml \
	--report /var/www/govready-html/$profile-fixed.html \
	--cpe /usr/share/xml/scap/ssg/content/ssg-rhel6-cpe-dictionary.xml \
	/usr/share/xml/scap/ssg/content/ssg-rhel6-xccdf.xml ; true

	

profile="test"
sudo oscap xccdf eval --profile test \
	--results /var/www/govready-html/test.xml \
	--report /var/www/govready-html/test.html \
	--cpe /usr/share/xml/scap/ssg/content/ssg-rhel6-cpe-dictionary.xml \
	/vagrant/vendor/govready/prototypes/ssg-test2-xccdf.xml ; true


profile="usgcb-rhel6-server"
oscap xccdf eval --profile $profile \
	--results /var/www/govready-html/$profile.xml \
	--report /var/www/govready-html/$profile.html \
	--cpe /usr/share/xml/scap/ssg/content/ssg-rhel6-cpe-dictionary.xml \
	/usr/share/xml/scap/ssg/content/ssg-rhel6-xccdf.xml ; true
	
oscap xccdf eval --profile usgcb-rhel6-server2 \
	--cpe /vagrant/vendor/govready/prototypes/ssg-rhel6-cpe-dictionary.xml \
	/vagrant/vendor/govready/prototypes/ssg-rhel6-xccdf.xml ; true
	

rule="no_empty_passwords"
ruledir="/vagrant/vendor/govready/prototypes/ssg/rhel6/rule"
cpe="$ruledir/ssg-rhel6-cpe-dictionary.xml"
oscap xccdf eval --profile $rule --cpe $cpe $ruledir/$rule.xml ; true

rule="accounts_password_all_shadowed"
ruledir="/vagrant/vendor/govready/prototypes/ssg/rhel6/rule"
cpe="$ruledir/ssg-rhel6-cpe-dictionary.xml"
oscap xccdf eval --profile $rule --cpe $cpe $ruledir/$rule.xml ; true


ruledir="/vagrant/vendor/govready/prototypes/ssg/rhel6/rule"
resultsdir="/vagrant/vendor/govready/prototypes/status"
cpe="$ruledir/ssg-rhel6-cpe-dictionary.xml"
rule="no_empty_passwords" && oscap xccdf eval --profile $rule --cpe $cpe $ruledir/$rule.xml ; true
rule="accounts_password_all_shadowed" && oscap xccdf eval --profile $rule --cpe $cpe $ruledir/$rule.xml ; true

rule="no_empty_passwords"
ruledir="/vagrant/vendor/govready/prototypes/ssg/rhel6/rule"
cpe="$ruledir/ssg-rhel6-cpe-dictionary.xml"
oscap xccdf eval --profile $rule --results /vagrant/vendor/govready/prototypes/status/$rule.xml --cpe $cpe $ruledir/$rule.xml  ; true

rule="no_empty_passwords"
ruledir="/vagrant/vendor/govready/prototypes/ssg/rhel6/rule"
cpe="$ruledir/ssg-rhel6-cpe-dictionary.xml"
oscap xccdf eval --profile $rule --cpe $cpe $ruledir/$rule.xml  ; true


rule="no_empty_passwords"
resultsdir="/vagrant/vendor/govready/prototypes/status"
cpe="$ruledir/ssg-rhel6-cpe-dictionary.xml"
oscap xccdf eval --profile $rule \
	--results $resultsdir/$rule.xml \
	--cpe $cpe \
	/vagrant/vendor/govready/prototypes/ssg-rhel6-xccdf-unbundled.xml ; true

# Unbundling just profiles does not work bc results generation spits out all rules from input xml.

# Profiles for severity
profile="severity_high"
sudo oscap xccdf eval --profile $profile \
	--results /var/www/govready-html/$profile.xml \
	--report /var/www/govready-html/$profile.html \
	--cpe /usr/share/xml/scap/ssg/content/ssg-rhel6-cpe-dictionary.xml \
	/vagrant/vendor/govready/prototypes/ssg-rhel6-xccdf-unbundled.xml ; true
sudo chown apache:apache /var/www/govready-html/$profile*

# generate custom reports
oscap [options] xccdf generate [options] <subcommand> [sub-options] benchmark-file.xml
Usage: oscap [options] xccdf generate [options] custom --stylesheet <file> [--output <file>] xccdf-file.xml

oscap xccdf generate custom --stylesheet /vagrant/vendor/govready/prototypes/openscap/xsl/xccdf-report.xsl --output /var/www/govready-html/gr-xccdf.html /var/www/govready-html/severity_high.xml
oscap xccdf generate custom --stylesheet /vagrant/vendor/govready/prototypes/openscap/xsl/xccdf-report.xsl --output /var/www/govready-html/gr-xccdf.html /var/www/govready-html/usgcb-rhel6-server.xml

oscap xccdf generate custom --stylesheet /vagrant/vendor/govready/prototypes/openscap/xsl/xccdf-report.xsl \
  --output /var/www/govready-html/usgcb-rhel6-server-fixed.html /var/www/govready-html/usgcb-rhel6-server.xml


# Generate fixes from SSG
# The result-id field can be found on the top line of the report that was previously generated.  It is possible to manually determine the result id, which is part of the specification for SCAP, by prepending “xccdf_org.open-scap_testresult_” to the name of the profile that was used to scan the server.
oscap xccdf generate fix --result-id xccdf_org.open-scap_testreosult_usgcb-rhel6-server /var/www/govready-html/usgcb-rhel6-server.xml > usgcb-rhel6-server.sh


# Loop through various aqueduct scripts

for f in `ls audit*.sh`;do echo $f;sh $f;done


# 
Often times a single XCCDF Rule corresponds with a single OVAL definition. In such cases there is an easy way to evaluate single oval definition:

    oscap oval eval --id my:def:id --results debug-results.xml oval.xml
    
In other cases, i.e. when you still need the XCCDF part to debug, I am afraid there is no easy answer (XCCDF standard wise). What values would be bound to the variables? How would the TestResult on output look like?
