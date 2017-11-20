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

status_flag=0
if [ -z "$1" ]
then
	echo "USAGE:
	sudo xmind-installer.sh username"
	exit 1
fi

ARCH=`uname -m`
XMIND_DIR="/opt/xmind"
if [ $ARCH == "x86_64" ]
then
	VERSION="XMind_amd64"
	BIN_DIR=$XMIND_DIR/$VERSION
elif [ $ARCH == "i686" ]
then
	VERSION="XMind_i386"
	BIN_DIR=$XMIND_DIR/$VERSION
else
	echo 'Sorry, cannot verify your OS architecture'
	echo 'The installer will now exit'
	exit 1
fi

echo "Extracting files..."
unzip -q xmind-8-update5-linux.zip -d xmind
if [ $? != 0 ]
then
  status_flag=1
  echo "Failed"
else
  echo "OK"
fi

echo "Installing..."
mv xmind /opt/
if [ $? != 0 ]
then
  status_flag=1
  echo "Failed"
else
  echo "OK"
fi

echo "Installing additional fonts..."
mkdir -p /usr/share/fonts/xmind
cp -R $XMIND_DIR/fonts/* /usr/share/fonts/xmind/
fc-cache -f
if [ $? != 0 ]
then
  status_flag=1
  echo "Failed"
else
  echo "OK"
fi

echo "Creating laucher..."
echo "" > /usr/share/applications/xmind8.desktop
echo "[Desktop Entry]" >> /usr/share/applications/xmind8.desktop
echo "Comment=Create and share mind maps." >> /usr/share/applications/xmind8.desktop
echo "Exec=$BIN_DIR/XMind %F" >> /usr/share/applications/xmind8.desktop
echo "Name=XMind" >> /usr/share/applications/xmind8.desktop
echo "Terminal=false" >> /usr/share/applications/xmind8.desktop
echo "Type=Application" >> /usr/share/applications/xmind8.desktop
echo "Categories=Office;" >> /usr/share/applications/xmind8.desktop
echo "Icon=xmind" >> /usr/share/applications/xmind8.desktop
if [ $? != 0 ]
then
  status_flag=1
  echo "Failed"
else
  echo "OK"
fi

echo "Creating workspaces..."
mkdir /home/$1/{workspace,.configuration}
cp -R $BIN_DIR/configuration/* /home/$1/.configuration
chown -R $1: /home/$1/workspace /home/$1/.configuration
if [ $? != 0 ]
then
  status_flag=1
  echo "Failed"
else
  echo "OK"
fi

echo "Post installatin configurations..."
sed -i "s/\.\.\/workspace/@user\.home\/workspace/g" "$BIN_DIR/XMind.ini"
sed -i "s/\.\/configuration/@user\.home\/\.configuration/g" "$BIN_DIR/XMind.ini"
sed -i "s/^\.\./\/opt\/xmind/g" "$BIN_DIR/XMind.ini"
if [ $? != 0 ]
then
  status_flag=1
  echo "Failed"
else
  echo "OK"
fi

echo "Installation finished. Happy mind mapping!"
