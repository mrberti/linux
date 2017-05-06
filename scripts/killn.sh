#!/bin/bash
procname=$1
echo "Trying to kill process $procname"
processes=`ps -e | grep $procname | awk '{print $1}'`
echo "Killing process IDs:"
echo $processes
kill $processes
