#!/bin/bash

## XMind 8 Installer 
##
## Author: Mohammad Riza Nurtam
## Email: muhammadriza@gmail.com
##
## Licensed under GPL V3
## Please refer to https://www.gnu.org/licenses/gpl-3.0.en.html
## 
## How to use this script
## 1. run the script using privileged user or using sudo command
## 2. don't forget to pass the user of the program in the command argument
## 
## example
## sudo bash xmind8-installer.sh mriza

USER=$1
unzip xmind-8-linux.zip -d xmind
mv xmind /opt/
cd /opt/xmind
mkdir -p /usr/share/fonts/truetype/xmind
cp -R fonts/* /usr/share/fonts/truetype/xmind/
fc-cache -f
chmod a+w /opt/xmind/XMind_amd64/configuration

cat <<EOF | tee /usr/share/applications/xmind8.desktop
[Desktop Entry]
Comment=Create and share mind maps.
Exec=/opt/xmind/XMind_amd64/XMind %F
Name=XMind
Terminal=false
Type=Application
Categories=Office;
Icon=xmind
EOF

sed -i "s/\.\.\/workspace/\/home\/${USER}\/workspace/" /opt/xmind/XMind_amd64/XMind.ini
sed -i "s/^\.\./\/opt\/xmind/" /opt/xmind/XMind_amd64/XMind.ini
sed -i "s/^\./\/opt\/xmind\/XMind_amd64/" /opt/xmind/XMind_amd64/XMind.ini
