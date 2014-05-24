#!/bin/bash

#Grabs the currently logged in user from the getCurrentUser.sh script
CU=$(</Library/Management/Triggers/currentuser.txt)

#Define the AD groups that will get Administrator Rights
AG="dynAllStaff dynO-09 dynO-10 dynO-11 dynO-12"

#Deletes the trigger file that was created by the getCurrentUser.sh script
deltxt="rm -f /Library/.Management/Triggers/currentuser.txt"

echo "authorized admin groups: $AG"
echo "user: $CU"
echo "user $CU is a member of the following groups…"
id -Gn $CU

#Checks to see if user is in one of the defined AD groups, and if it finds a match it makes the user a local Administrator.
for authorizedgroup in $AG
	do
	if (id -Gn $CU | grep -q $authorizedgroup)
		then
		echo "$CU is a member of authorized group $authorizedgroup"
		echo "Adding $CU to the local admin group…"
		dscl . -append /Groups/admin GroupMembership $CU
		echo "exiting…"
		$deltxt
		exit 0
	fi
done

echo "$CU is not a member of any authorized groups. exiting…"
$deltxt
exit 0
