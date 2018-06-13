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

if [ -z "$1" ]
then
	echo "USAGE:
	sudo xmind-installer.sh username"
  exit 1
fi

xtrct(){
	echo "Extracting files..."
	mkdir -p /opt/xmind
	unzip -q xmind-8-update7-linux.zip -d /opt/xmind
}

fnt(){
	echo "Installing additional fonts..."
	mkdir -p /usr/share/fonts/xmind
	cp -R $XMIND_DIR/fonts/* /usr/share/fonts/xmind/
	fc-cache -f
}

lnchr(){
	echo "Creating laucher..."
	cat << EOF >> /usr/share/applications/xmind8.desktop
	[Desktop Entry]
	Comment=Create and share mind maps.
	Exec=$BIN_DIR/XMind %F
	Name=XMind
	Terminal=false
	Type=Application
	Categories=Office;
	Icon=xmind
EOF
}

cnfg(){
	echo "Creating workspace and configuration..."
	mkdir /home/$1/{workspace,.configuration}
	cp -R $BIN_DIR/configuration/* /home/$1/.configuration
	chown -R $1: /home/$1/{workspace,.configuration}
	sed -i "s/\.\.\/workspace/@user\.home\/workspace/g" "$BIN_DIR/XMind.ini"
	sed -i "s/\.\/configuration/@user\.home\/\.configuration/g" "$BIN_DIR/XMind.ini"
	sed -i "s/^\.\./\/opt\/xmind/g" "$BIN_DIR/XMind.ini"
}

ubuntu_bb(){
cat << EOF >> $BIN_DIR/XMind.ini
--add-modules=java.se.ee
-Dosgi.requiredJavaVersion=1.8
-Xms256m
-Xmx1024m
EOF
}

mimeicns(){
	echo "Updating MIME database and icons"
	cp xmind.xml /usr/share/mime/packages/
	update-mime-database /usr/share/mime
	cp -r xmind.svg /usr/share/icons/hicolor/scalable/{apps,mimetypes}
	gtk-update-icon-cache --quiet /usr/share/icons/hicolor/ -f
}

xtrct
if [ $? = 0 ]
then
	fnt
	lnchr
	cnfg $1
	mimeicns
	while true; do
    read -p "Do you installing in Ubuntu 18.04 or its derivative (y/n)?" yn
    case $yn in
        [Yy]* ) ubuntu_bb; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
	done
	echo "Installation finished. Happy mind mapping!"
else
	echo "Instalation failed"
	exit 1
fi
