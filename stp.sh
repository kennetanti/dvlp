#!/bin/bash

echo "Checking for root..."
# request root access
if [ "$UID" -ne 0 ]
then
echo $PWD
sudo bash $PWD/$0 "$@"
fi
# we are now root, if granted

echo "Installing as root..."

echo "Updating and upgrading system..."
# be the newest you can be
apt update
apt -y upgrade

echo "Installing basic dependencies..."
# install python dependencies
apt -y install python-dev python-pip wget git

echo "Installing iRRViTools..."
# install irrvitools to $HOME
cd ~
git clone https://github.com/kennetanti/irrvitools
# ensure proper ownership (avoids SUID exploit because trust no one) (but really im poor so trust... people :'( github can be bribed AND THAT COUNTS AS A FUCKING SECURITY HOLE. FUCK YOU ETHICAL HACKING... )
chown -R $SUDO_USER:$SUDO_USER irrvitools
# and proper permissions
chmod -R +x irrvitools/bin

# vote irrvitools for $PATH in $(expr $(date +%Y) + 1)
TOADD="export PATH=~/irrvitools/bin:\$PATH"
grep -qF "$TOADD" ~/.bashrc || echo $TOADD >> ~/.bashrc

# DO NOT modify below this line. It is automatically generated to install proper python depenencies
# modification may produce ID 107 errors.

###iRRVi#PYREQ###
pip install requests psd-tools Pillow
echo "installed irrvitools :)"
