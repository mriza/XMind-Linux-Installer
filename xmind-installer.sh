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
if [ $ARCH = "x86_64" ]
then
	XMIN_DIR="/opt/xmind/XMind_amd64"
elif [ $ARCH = "i686" ]
then
	XMIND_DIR="/opt/xmind/XMind_i386"
else
	echo 'Sorry, cannot verify your kernel version'
	echo 'The installer will now exit'
	exit
fi

unzip -q xmind-8-linux.zip -d xmind
mv xmind /opt/
mkdir -p /usr/share/fonts/truetype/xmind
cp -R /opt/xmind/fonts/* /usr/share/fonts/truetype/xmind/
fc-cache -f

cat <<EOF | tee /usr/share/applications/xmind8.desktop
[Desktop Entry]
Comment=Create and share mind maps.
Exec=/opt/xmind/$DIR/XMind %F
Name=XMind
Terminal=false
Type=Application
Categories=Office;
Icon=xmind
EOF

sed -i "s/\.\.\/workspace/@user\.home\/workspace/" $XMIND_DIR/XMind.ini
sed -i "s/\.\/configuration/$XMIND_DIR/\.configuration/" $XMIND_DIR/XMind.ini
sed -i "s/^\.\./\/opt\/xmind/" $XMIND_DIR/XMind.ini

mkdir /home/$USER/workspace
chown -R $USER: /home/$USER/workspace
