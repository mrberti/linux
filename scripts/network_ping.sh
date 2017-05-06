#!/bin/bash
#works in cygwin
#using windows ping command

#currently only this subnet will be scanned:
pre_ip="192.168.1."

counter=1

ping_options="-n 1 -w 100"

while [ $counter -lt 254 ]; do
	ip=$pre_ip
	ip+=$counter
#echo "Try to ping $ip..."
	ping $ping_options $ip | grep Antwort | grep -v "nicht erreichbar"
	let counter=counter+1
done
