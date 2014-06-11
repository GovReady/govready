#!/bin/bash
#
#
# name: grfix1.sh
# GovReady Fix Script
# Version: 0.0.1
# Copyright Greg Elin
# License: GPL
# usage: sudo sh -c "bash grfix1.sh"
#

# Add rules to /etc/audit/audit.rules
/bin/cat <</etc/audit/audit.rules
-a always,exit -F arch=b32 -S chmod -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S chmod -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S chown -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S chown -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S fchmod -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S fchmod -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S fchmodat -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S fchmodat -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S fchown -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S fchown -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S fchownat -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S fchownat -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S fremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S fremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S fsetxattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S fsetxattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S lchown -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S lchown -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S lremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S lremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S lsetxattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S lsetxattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S removexattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S removexattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S lremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S lremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod
EOF

/bin/cat <</etc/audit/audit.rules
# audit_account_changes
-w /etc/group -p wa -k audit_account_changes
-w /etc/passwd -p wa -k audit_account_changes
-w /etc/gshadow -p wa -k audit_account_changes
-w /etc/shadow -p wa -k audit_account_changes
-w /etc/security/opasswd -p wa -k audit_account_changes
EOF

/bin/cat <</etc/audit/audit.rules
# audit_network_modifications
-a always,exit -F arch=b64 -S sethostname -S setdomainname -k audit_network_modifications
-w /etc/issue -p wa -k audit_network_modifications
-w /etc/issue.net -p wa -k audit_network_modifications
-w /etc/hosts -p wa -k audit_network_modifications
-w /etc/sysconfig/network -p wa -k audit_network_modifications
EOF

/bin/cat <</etc/audit/audit.rules
# CCE-26657-7
-w /etc/selinux/ -p wa -k MAC-policy

# CCE-26691-6
-w /var/log/faillog -p wa -k logins 
-w /var/log/lastlog -p wa -k logins

# CCE-26610-6 
-w /var/run/utmp -p wa -k session
-w /var/log/btmp -p wa -k session
-w /var/log/wtmp -p wa -k session
EOF

/bin/cat <</etc/audit/audit.rules
# CCE-26712-0 
-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=500 -F auid!=4294967295 -k access
-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=500 -F auid!=4294967295 -k access
EOF

/bin/cat <</etc/audit/audit.rules
# CCE-26457-2 

# CCE-26573-6
-a always,exit -F arch=b64 -S mount -F auid>=500 -F auid!=4294967295 -k export

# CCE-26651-0 
-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>=500 -F auid!=4294967295 -k delete

# CCE-26662-7 
-w /etc/sudoers -p wa -k actions

# CCE-26611-4 
-w /sbin/insmod -p x -k modules
-w /sbin/rmmod -p x -k modules
-w /sbin/modprobe -p x -k modules
-a always,exit -F arch=b64 -S init_module -S delete_module -k modules
EOF

/bin/cat <</etc/audit/audit.rules
# CCE-26612-2 
# With this setting, a reboot will be required to change any audit rules.
# -e 2
EOF


chmod 0640 audit_file

chown root /var/log

# CCE-26828-4 - Run the following command to set the idle time-out value for inactivity in the GNOME desktop to 15 minutes:
sudo gconftool-2 \
  --direct \
  --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory \
  --type int \
  --set /apps/gnome-screensaver/idle_delay 15

# CCE-26600-7 Run the following command to activate the screensaver in the GNOME desktop after a period of inactivity:
sudo gconftool-2 --direct \
  --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory \
  --type bool \
  --set /apps/gnome-screensaver/idle_activation_enabled true

# CCE-26235-2 Run the following command to activate locking of the screensaver in the GNOME desktop when it is activated
sudo gconftool-2 --direct \
  --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory \
  --type bool \
  --set /apps/gnome-screensaver/lock_enabled true
  
# CE-26638-7 Run the following command to set the screensaver mode in the GNOME desktop to a blank screen:
sudo gconftool-2 --direct \
  --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory \
  --type string \
  --set /apps/gnome-screensaver/mode blank-only


# CCE-26974-6 Edit /etc/issue for login banner
FILE="/etc/issue"

if ! /bin/grep -q "authorized" $FILE; then
	/bin/cat </etc/issue
-- WARNING --
This system is for the use of authorized users only. Individuals
using this computer system without authority or in excess of their
authority are subject to having all their activities on this system
monitored and recorded by system personnel. Anyone using this
system expressly consents to such monitoring and is advised that
if such monitoring reveals possible evidence of criminal activity
system personal may provide the evidence of such monitoring to law
enforcement officials.
EOF

# CE-27195-7 To enable displaying a login warning banner in the GNOME Display Manager's login screen
sudo -u gdm gconftool-2 \
  --type bool \
  --set /apps/gdm/simple-greeter/banner_message_enable tru
fi
