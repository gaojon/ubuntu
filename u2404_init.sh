#!/bin/bash
#24.04 LTS

echo "Adding new user"

mkdir /home/jon
useradd jon -d /home/jon -G sudo -p root123 
chown jon /home/jon

echo "Enable sshd"

apt -y install openssh-server
systemctl restart ssh

echo "Install vncserver"

apt -y install tigervnc-standalone-server
