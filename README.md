# XMind-Linux-Installer
A simple BASH script to install XMind in Linux

How to install XMind 8 on Linux

1. Download XMind from [http://www.xmind.net/download/linux/] (http://www.xmind.net/download/linux/)
2. Place this script in the same directory
3. Run the installer
..* If you are installing on 32bit system, run `sudo xmind-i386-installer.sh username`
..* If you are installing on 64bit system, run `sudo xmind-amd64-installer.sh username`
..* Or if you are unsure about the version, the script will detect your system version automatically, run `sudo xmind-installer.sh username`

username is the user that will be use/run the software. Since XMind will need a data directory in the user home named 'workspace'
