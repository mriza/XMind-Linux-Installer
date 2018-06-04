# XMind-Linux-Installer
A simple BASH script to install XMind in Linux

How to install XMind 8 on Linux

1. Make sure the dependencies are satisfied for your distribution
 - Debian, Ubuntu, Mint or other Linux distribution with .deb package. `sudo apt-get install unzip default-jre libgtk2.0-0 libwebkitgtk-1.0-0 lame libc6 libglib2.0-0`
 - Fedora, CentOS, RHEL, or other Linux distribution with .rpm packages. `sudo yum install unzip java webkitgtk gtk2 glibc lame` or `sudo dnf install unzip java webkitgtk gtk2 glibc lame`
2. Get the scripts `git clone https://github.com/mriza/XMind-Linux-Installer.git`
3. Download XMind from [http://www.xmind.net/download/linux/] (http://www.xmind.net/download/linux/)

4. Add execute permission to the installer script and run it,
   `chmod +x xmind-installer.sh`; `sudo ./xmind-installer.sh username`

username is the user that will be use/run the software. Because XMind will need a data directory in the user home named 'workspace'

This script is an automation of [this process](http://www.xmind.net/m/PuDC)

![process](https://xmindshare.s3.amazonaws.com/preview/PuDC-FwEzHqO-77495.png)

Icon : http://www.iconarchive.com/show/papirus-apps-icons-by-papirus-team/xmind-icon.html
