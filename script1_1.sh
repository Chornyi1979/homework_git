#!/bin/bash

about() {
echo "Enter key for the script.sh:
--all  -   IP adressess all hosts in the current subnet
--target - list of open TCP ports"
}

ip() {
nmap -sP -n 192.168.0.0/24
nmap -sP -n 192.168.0.0/24|grep "^Nmap"|cut -f 5 -d ' '
}

tcp() {
echo "port TCP"
netstat -tlpn
}

if [[ -z $1 ]] ; then
	about
else
        for i in $1; do
	    	if [[ $1 == "--all" ]] ; then
			ip
	    	elif [[ $1 == "--target" ]] ; then
			tcp
	    	elif [[ -n $1 ]] ; then
			echo "Such a key does not exist !!!
Please, choose key --all or --target"
		fi
	done
fi
