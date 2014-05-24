#!/bin/bash

if (id -G $USER | grep -q " 80 ")
	then
	echo "$USER is already in the local admin group. exiting..."
	exit 0
fi

echo $USER >> /Library/.Management/Triggers/currentuser.txt
