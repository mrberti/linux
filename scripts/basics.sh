#!/bin/bash

# passing arguments
echo "\$0:" $0 
echo "\$1:" $1
echo "\$2:" $2
echo "\$$:" $$
echo "\$#:" $#
echo "\$?:" $?

# getting output
out=`ls`
echo $out

# reading input
echo Please enter your name
read NAME
echo "Hi $NAME"

# arithmetic operations
echo "$[1+1] $((1 + 1))"

# basic conditional example if .. then .. else
T1="foo"
T2="foo"
if [ "$T1" != "$T2" ]; then
	echo expression evaluated as true
else
	echo expression evaluated as false
fi

# For sample
for i in $( ls ); do
	echo item: $i
done

# C-like for
for i in `seq 1 10`;
do
	echo $i
done

# while sample
counter=0
while [ $counter -lt 10 ]; do
	echo The counter is $counter
	let counter=counter+1
done

# until sample
counter=20
until [ $counter -lt 10 ]; do
	echo COUNTER $counter
	let counter-=1
done

# exit 0
