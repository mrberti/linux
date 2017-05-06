#!/bin/bash
#Call with either enable or disable as first parameter
if [[ "$1" == 'enable' || "$1" == ''disable ]]; then
	sudo systemctl set-default multi-user.target --force
	sudo systemctl $1 lightdm.service --force
	sudo systemctl $1 graphical.target --force
	sudo systemctl $1 plymouth.service --force
else
	echo "Call with either 'enable' or 'disable' as first parameter"
fi
