#!/bin/bash
USER=$1
echo "Uninstalling"
sudo rm -rf /opt/xmind/
sudo rm -rf /home/$USER/workspace
sudo rm -rf /home/$USER/.configuration
sudo rm -rf /usr/share/applications/xmind8.desktops
