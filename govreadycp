#!/bin/bash
# Maintainer Rodney Cobb <rocobb@gitmachines.com>
 
# Define variables
LSB=/usr/bin/lsb_release
 
# Display pause prompt
# $1-> Message (optional)
function pause(){
	local message="$@"
	[ -z $message ] && message="Press [Enter] key to continue..."
	read -p "$message" readEnterKey
}
 
# Display a menu on screen
function show_menu(){
    date
    echo "---------------------------"
    echo "GovReady System Info Panel"
    echo "---------------------------"
	echo "1. Operating system info"
	echo "2. Hostname and dns info"
	echo "3. Network info"
	echo "4. Who is online"
	echo "5. Last logged in users"
	echo "6. Free and used memory info"
	echo "7. GovReady Scan"
	echo "8. Exit"
}
 
# Display header message
# $1 - message
function write_header(){
	local h="$@"
	echo "---------------------------------------------------------------"
	echo "     ${h}"
	echo "---------------------------------------------------------------"
}
 
# Get info about your operating system
function os_info(){
	write_header " System information "
	echo "Operating system : $(uname)"
	[ -x $LSB ] && $LSB -a || echo "$LSB command is not installed (set \$LSB variable)"
	#pause "Press [Enter] key to continue..."
	pause
}
 
# Get info about host such as dns, IP, and hostname
function host_info(){
	local dnsips=$(sed -e '/^$/d' /etc/resolv.conf | awk '{if (tolower($1)=="nameserver") print $2}')
	write_header " Hostname and DNS information "
	echo "Hostname : $(hostname -s)"
	echo "DNS domain : $(hostname -d)"
	echo "Fully qualified domain name : $(hostname -f)"
	echo "Network address (IP) :  $(hostname -i)"
	echo "DNS name servers (DNS IP) : ${dnsips}"
	pause
}
 
# Network inferface and routing info
function net_info(){
	devices=$(netstat -i | cut -d" " -f1 | egrep -v "^Kernel|Iface|lo")
	write_header " Network information "
	echo "Total network interfaces found : $(wc -w <<<${devices})"
 
	echo "*** IP Addresses Information ***"
	ip -4 address show
 
	echo "***********************"
	echo "*** Network routing ***"
	echo "***********************"
	netstat -nr
 
	echo "**************************************"
	echo "*** Interface traffic information ***"
	echo "**************************************"
	netstat -i
 
	pause 
}
 
# Display a list of users currently logged on 
# Display a list of recently loggged in users   
function user_info(){
	local cmd="$1"
	case "$cmd" in 
		who) write_header " Who is online "; who -H; pause ;;
		last) write_header " List of last logged in users "; last ; pause ;;
	esac 
}
 
# Display used and free memory info
function mem_info(){
	write_header " Free and used memory "
	free -m
 
    echo "*********************************"
	echo "*** Virtual memory statistics ***"
    echo "*********************************"
	vmstat
    echo "***********************************"
	echo "*** Top 5 memory eating process ***"
    echo "***********************************"		
	ps auxf | sort -nr -k 4 | head -5	
	pause
}

# Start OpenScap Utilties download and run scan
function oscap_install(){
	write_header " OPENSCAP installing "
 	yum install -y openscap-utils

    echo "*********************************"
	echo "*** Getting Guidelines ***"
    echo "*********************************"
	wget http://www.redhat.com/security/data/metrics/com.redhat.rhsa-all.xccdf.xml
	wget http://www.redhat.com/security/data/oval/com.redhat.rhsa-all.xml
    echo "*********************************"
	echo "*** Performing Scan ***"
    echo "*********************************"
	oscap xccdf eval --results results.xml --report report.html com.redhat.rhsa-all.xccdf.xml
	pause
}

# Get input via the keyboard and make a decision using case..esac 
function read_input(){
	local c
	read -p "Enter your choice [ 1 - 8 ] " c
	case $c in
		1)	os_info ;;
		2)	host_info ;;
		3)	net_info ;;
		4)	user_info "who" ;;
		5)	user_info "last" ;;
		6)	mem_info ;;
		7)	oscap_install ;;
		8)	echo "May DevOps be with you!"; exit 0 ;;
		*)	
			echo "Please select between 1 to 8. Select one choice only."
			pause
	esac
}
 
# ignore CTRL+C, CTRL+Z and quit singles using the trap
trap '' SIGINT SIGQUIT SIGTSTP
 
# main logic
while true
do
	clear
 	show_menu	# display memu
 	read_input  # wait for user input
done
