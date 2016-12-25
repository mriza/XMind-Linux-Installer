#!/bin/bash
USER=$1
status_flag=0
echo "Uninstalling\n"
echo "Removing files..."
rm -rfv /opt/xmind/
if [ $? != 0 ]
then
  status_flag=1
  echo "Failed"
fi
echo "Removing user data..."
rm -rfv /home/$USER/workspace
if [ $? != 0 ]
then
  status_flag=1
  echo "Failed"
fi
echo "Removing configs..."
rm -rfv /home/$USER/.configuration
if [ $? != 0 ]
then
  status_flag=1
  echo "Failed"
fi
echo "Removing launcher..."
rm -rfv /usr/share/applications/xmind8.desktop
if [ $? != 0 ]
then
  status_flag=1
  echo "Failed"
fi
if [ $status_flag != 0 ]
then
  echo "Some errors found..."
  exit 1
else
  echo "Uninstallation finished succesfully"
  exit 0
fi
