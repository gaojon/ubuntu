#!/bin/bash
#24.04 LTS

echo "#######################  Mount /home1/     ########################"
mkdir -p /home1/jon
mount /dev/disk/by-uuid/5af4352a-692e-4df3-8343-aa762f9f40f7 /home1/jon

echo "/dev/disk/by-uuid/5af4352a-692e-4df3-8343-aa762f9f40f7  /home1/jon  ext4 defaults 0 1" | tee -a /etc/fstab

echo "#######################  Adding new user   ########################"

useradd jon -d /home1/jon -G sudo,render,video -s /bin/bash

chown jon -R /home1/jon
chgrp jon -R /home1/jon

echo "#######################    Enable sshd    #########################"

apt -y install openssh-server -qq
systemctl restart ssh

echo "#######################  Install docker   ######################"

apt-get update
apt-get install ca-certificates curl -y -qq
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -qq

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y -qq

echo "#######################  Install vncserver   ######################"

apt -y install tigervnc-standalone-server -qq
apt -y install xfce4 xfce4-goodies -qq

echo "################ Add a alias to start vncserver  ##################"

echo "alias vncs='tigervncserver -xstartup /usr/bin/startxfce4  -SecurityTypes VncAuth,TLSVnc -geometry 1980x1020 -localhost no :58'" | sudo tee -a /etc/bash.bashrc

echo "Need to reboot before launch vncserver"
echo "Only works when start vncserver from SSH terminal"
echo "It's safe to ignore the error in vnc log file:"
echo "    libEGL warning: failed to open /dev/dri/card1: Permission denied"

echo "################ Add a alias to start vncserver  ##################"
passwd jon

