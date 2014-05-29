#!/bin/bash
# OpenSCAP fix generator output for benchmark: Guide to the Secure Configuration of Red Hat Enterprise Linux 6


# Generating fixes for all failed rules in test result 'xccdf_org.open-scap_testresult_usgcb-rhel6-server'.

# XCCDF rule: kernel_module_cramfs_disabled
# CCE-26340-0
echo "install cramfs /bin/false" > /etc/modprobe.d/cramfs.conf


# XCCDF rule: kernel_module_freevxfs_disabled
# CCE-26544-7
echo "install freevxfs /bin/false" > /etc/modprobe.d/freevxfs.conf


# XCCDF rule: kernel_module_jffs2_disabled
# CCE-26670-0
echo "install jffs2 /bin/false" > /etc/modprobe.d/jffs2.conf


# XCCDF rule: kernel_module_hfs_disabled
# CCE-26800-3
echo "install hfs /bin/false" > /etc/modprobe.d/hfs.conf


# XCCDF rule: kernel_module_hfsplus_disabled
# CCE-26361-6
echo "install hfsplus /bin/false" > /etc/modprobe.d/hfsplus.conf


# XCCDF rule: kernel_module_squashfs_disabled
# CCE-26404-4
echo "install squashfs /bin/false" > /etc/modprobe.d/squashfs.conf


# XCCDF rule: kernel_module_udf_disabled
# CCE-26677-5
echo "install udf /bin/false" > /etc/modprobe.d/udf.conf


# XCCDF rule: umask_for_daemons
# CCE-27031-4
var_umask_for_daemons="027"
grep -q ^umask /etc/init.d/functions && \
  sed -i "s/umask.*/umask $var_umask_for_daemons/g" /etc/init.d/functions
if ! [ $? -eq 0 ]; then
    echo "umask $var_umask_for_daemons" >> /etc/init.d/functions
fi


# XCCDF rule: disable_users_coredumps
# CCE-27033-0
echo "*     hard   core    0" >> /etc/security/limits.conf


# XCCDF rule: sysctl_kernel_randomize_va_space
# CCE-26999-3
#
# Set runtime for kernel.randomize_va_space
#
sysctl -q -n -w kernel.randomize_va_space=2

#
# If kernel.randomize_va_space present in /etc/sysctl.conf, change value to "2"
#	else, add "kernel.randomize_va_space = 2" to /etc/sysctl.conf
#
if grep --silent ^kernel.randomize_va_space /etc/sysctl.conf ; then
	sed -i 's/^kernel.randomize_va_space.*/kernel.randomize_va_space = 2/g' /etc/sysctl.conf
else
	echo "" >> /etc/sysctl.conf
	echo "# Set kernel.randomize_va_space to 2 per security requirements" >> /etc/sysctl.conf
	echo "kernel.randomize_va_space = 2" >> /etc/sysctl.conf
fi


# XCCDF rule: accounts_password_warn_age_login_defs
# CCE-26988-6
var_accounts_password_warn_age_login_defs="14"
grep -q ^PASS_WARN_AGE /etc/login.defs && \
  sed -i "s/PASS_WARN_AGE.*/PASS_WARN_AGE     $var_accounts_password_warn_age_login_defs/g" /etc/login.defs
if ! [ $? -eq 0 ]; then
    echo "PASS_WARN_AGE      $var_accounts_password_warn_age_login_defs" >> /etc/login.defs
fi


# XCCDF rule: account_disable_post_pw_expiration
# CCE-27283-1
var_account_disable_post_pw_expiration="30"
grep -q ^INACTIVE /etc/default/useradd && \
  sed -i "s/INACTIVE.*/INACTIVE=$var_account_disable_post_pw_expiration/g" /etc/default/useradd
if ! [ $? -eq 0 ]; then
    echo "INACTIVE=$var_account_disable_post_pw_expiration" >> /etc/default/useradd
fi


# XCCDF rule: disable_interactive_boot
# CCE-27043-9
grep -q ^PROMPT /etc/sysconfig/init && \
  sed -i "s/PROMPT.*/PROMPT=no/g" /etc/sysconfig/init
if ! [ $? -eq 0 ]; then
    echo "PROMPT=no" >> /etc/sysconfig/init
fi


# XCCDF rule: set_system_login_banner
# CCE-26974-6
login_banner_text="
-- WARNING --[\s\n]*This system is for the use of authorized users only. Individuals[\s\n]*using this computer system without authority or in excess of their[\s\n]*authority are subject to having all their activities on this system[\s\n]*monitored and recorded by system personnel. Anyone using this[\s\n]*system expressly consents to such monitoring and is advised that[\s\n]*if such monitoring reveals possible evidence of criminal activity[\s\n]*system personal may provide the evidence of such monitoring to law[\s\n]*enforcement officials."
cat <<EOF >/etc/issue
$login_banner_text
EOF


# XCCDF rule: network_disable_zeroconf
# CCE-27151-0
echo "NOZEROCONF=yes" >> /etc/sysconfig/network


# XCCDF rule: sysctl_net_ipv4_conf_default_send_redirects
# CCE-27001-7
#
# Set runtime for net.ipv4.conf.default.send_redirects
#
sysctl -q -n -w net.ipv4.conf.default.send_redirects=0

#
# If net.ipv4.conf.default.send_redirects present in /etc/sysctl.conf, change value to "0"
#	else, add "net.ipv4.conf.default.send_redirects = 0" to /etc/sysctl.conf
#
if grep --silent ^net.ipv4.conf.default.send_redirects /etc/sysctl.conf ; then
	sed -i 's/^net.ipv4.conf.default.send_redirects.*/net.ipv4.conf.default.send_redirects = 0/g' /etc/sysctl.conf
else
	echo "" >> /etc/sysctl.conf
	echo "# Set net.ipv4.conf.default.send_redirects to 0 per security requirements" >> /etc/sysctl.conf
	echo "net.ipv4.conf.default.send_redirects = 0" >> /etc/sysctl.conf
fi


# XCCDF rule: kernel_module_rds_disabled
# CCE-26239-4
echo "install rds /bin/false" > /etc/modprobe.d/rds.conf


# XCCDF rule: service_kdump_disabled
# CCE-26850-8
#
# Disable kdump for all run levels
#
chkconfig --level 0123456 kdump off

#
# Stop kdump if currently running
#
service kdump stop


# XCCDF rule: service_atd_disabled
# CCE-27249-2
#
# Disable atd for all run levels
#
chkconfig --level 0123456 atd off

#
# Stop atd if currently running
#
service atd stop


# XCCDF rule: service_netfs_disabled
# CCE-27137-9
#
# Disable netfs for all run levels
#
chkconfig --level 0123456 netfs off

#
# Stop netfs if currently running
#
service netfs stop


# generated: 2014-05-27T03:29:18Z
# END OF SCRIPT
