#!/bin/bash
USER=$1
echo "Uninstalling"
echo "Removing files..."
sudo rm -rfv /opt/xmind/
echo "Removing user data..."
sudo rm -rfv /home/$USER/workspace
echo "Removing configs..."
sudo rm -rfv /home/$USER/.configuration
echo "Removing launcher..."
sudo rm -rfv /usr/share/applications/xmind8.desktop
echo "Uninstallation finished"
