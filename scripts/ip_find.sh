#!/bin/bash

# depending on the type of ping, use these options and grep string
if [ -n "$(type ping | grep WINDOWS)" ]; then
	options="-n 1 -w 1000"
	grep_str="Antwort"
else
	options="-c 1"
	grep_str="bytes from"
fi

# create range for ips
is=`seq 1 254`

# ping range of ips
for i in $is;
do
	ip="192.168.1.$i"
	ping $options $ip | grep "$grep_str"
	echo -ne $i '\r'
done
