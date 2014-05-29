#!/bin/sh

ruledir="/vagrant/vendor/govready/prototypes/ssg/rhel6/rule"
cpe="$ruledir/ssg-rhel6-cpe-dictionary.xml"

rule="no_empty_passwords" && oscap xccdf eval --profile $rule --cpe $cpe $ruledir/$rule.xml ; true

rule="accounts_password_all_shadowed" && oscap xccdf eval --profile $rule --cpe $cpe $ruledir/$rule.xml ; true
