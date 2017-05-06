#!/bin/bash

#moves all files from linux to home

from_dir="$HOME/linux"
to_dir="$HOME"

echo "Moving all files from $from_dir to $to_dir"

cp -R $from_dir $to_dir
