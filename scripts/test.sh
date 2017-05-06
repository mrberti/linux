#!/bin/bash

ps_a=`ps -eo comm | sort`
sleep 1&
sleep 1&
sleep 1&
ps_b=`ps -eo comm | sort`

new_procs=`diff <(echo "$ps_a") <(echo "$ps_b") | grep ">" | awk '{print $2 "asd"}'`
echo -e $new_procs
