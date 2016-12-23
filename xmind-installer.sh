#!/bin/bash
##
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
ARCH=`uname -m`
if $ARCH='x86_64' then
	DIR='XMind_amd64'
elif $ARCH='i686' then
	DIR='XMind_i386'
else
	echo 'Sorry, cannot verify your kernel version'
	echo 'The installer will now exit'
	exit
fi

unzip xmind-8-linux.zip -d xmind
mv xmind /opt/
cd /opt/xmind
mkdir -p /usr/share/fonts/truetype/xmind
cp -R fonts/* /usr/share/fonts/truetype/xmind/
fc-cache -f

cat <<EOF | tee /usr/share/applications/xmind8.desktop
[Desktop Entry]
Comment=Create and share mind maps.
Exec=/opt/xmind/$(DIR)/XMind %F
Name=XMind
Terminal=false
Type=Application
Categories=Office;
Icon=xmind
EOF

sed -i "s/\.\.\/workspace/@user\.home\/workspace/" /opt/xmind/$(DIR)/XMind.ini
sed -i "s/\.\/configuration/@user\.home\/\.configuration/" /opt/xmind/$(DIR)/XMind.ini
sed -i "s/^\.\./\/opt\/xmind/" /opt/xmind/$(DIR)/XMind.ini


mkdir /home/$(USER)/workspace
cp -R /opt/xmind/$(DIR)/configuration /home/$(USER)/
chown -R $(user): /home/$(USER)/.configuration
chown -R $(user): /home/$(USER)/workspace
