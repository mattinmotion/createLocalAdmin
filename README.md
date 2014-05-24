createLocalAdmin
================

A big thanks goes out to Rich Trouton, Greg Neagle, Ben Toms, Tim Sutton, and the people at the MacEnterprise mailing list. Through the help of all these people I was able to piece together this project.

The goal here is to check the user that is logging in against AD and a defined list of groups that should get administrator rights. If the user is a member of one of the defined AD groups then the user will become a local administrator. This will allow a user that is off your network to retain administrator rights.

com.company.getCurrentUser.plist is a LaunchAgent that runs at login and calls the getCurrentUser.sh script.

getCurrentUser.sh first checks to see if the user is already a local administrator. If the user is an administrator, the script exits, and nothing else happens. If the user is not a local administrator the script writes a text file to /Library/.Management/Triggers/currentuser.txt with the name of the currently logged in user.

com.company.makeCurrentUserAdmin.plist is a LaunchDaemon that looks for /Library/.Management/Triggers/currentuser.txt, and when it is found will execute the makeCurrentUserAdmin.sh script.

makeCurrentUserAdmin.sh defines the AD groups that should be local administrators. It then checks the current user in AD to see if it belongs to any of those groups. If the user doesn't match any of the groups the script deletes the /Library/.Management/Triggers/currentuser.txt file and exits. If the user matches one of the groups the user is given local administrator rights and the /Library/.Management/Triggers/currentuser.txt file is deleted.

createManagementFolders.sh checks to see if the /Library/.Management/ directory exists. If it does, the script exits. If the directory isn't there the directories referenced in the other scripts are created.

The expected directory structure from the scripts are as follows:

/Library/.Management/
/Library/.Management/Triggers/
/Library/.Management/Logs/
/Library/LaunchAgents/com.company.CurrentUser.plist
/Library/LaunchDaemons/com.company.makeCurrentUserAdmin.plist
/Library/Scripts/.Company_Startup/
/Library/Scripts/.Company_Startup/getCurrentUser.sh
/Library/Scripts/.Company_Startup/makeCurrentUserAdmin.sh
