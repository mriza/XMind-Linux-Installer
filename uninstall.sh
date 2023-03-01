#!/bin/bash
usage(){
	echo "USAGE:
	sudo uninstall.sh username"
	exit 1
}
# Must be run as root
if [ "$EUID" -ne 0 ]; then usage; fi
# Must specify username
if [ -z "$1" ]; then usage; fi
USER=$1
status_flag=0
echo "Uninstalling XMind"
echo "Removing files..."
rm -rf /opt/xmind/
if [ $? != 0 ]
then
  status_flag=1
  echo "Failed"
else
  echo "OK"
fi
echo "Removing user data..."
rm -rf /home/$USER/.workspace
if [ $? != 0 ]
then
  status_flag=1
  echo "Failed"
else
  echo "OK"
fi
echo "Removing configs..."
rm -rf /home/$USER/{.configuration,p2}
if [ $? != 0 ]
then
  status_flag=1
  echo "Failed"
else
  echo "OK"
fi
echo "Removing launcher..."
rm -rf /usr/share/applications/xmind8.desktop
if [ $? != 0 ]
then
  status_flag=1
  echo "Failed"
else
  echo "OK"
fi
echo "...Updating MIME database"
rm /usr/share/mime/packages/xmind.xml
update-mime-database /usr/share/mime
if [ $? != 0 ]
then
  status_flag=1
  echo "Failed"
else
  echo "OK"
fi
if [ $status_flag != 0 ]
then
  echo "Some errors found..."
  exit 1
else
  echo "Uninstallation finished succesfully"
  exit 0
fi
