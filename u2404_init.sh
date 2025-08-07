#!/bin/bash
#24.04 LTS

echo "Adding new user"

mkdir /home/jon
useradd jon -d /home/jon -G sudo -s /bin/bash
chown jon /home/jon

echo "Enable sshd"

apt -y install openssh-server
systemctl restart ssh

echo "Install vncserver"

apt -y install tigervnc-standalone-server


echo "Add a alias to start vncserver"
echo "alias vncs='tigervncserver -xstartup /usr/bin/gnome-session -SecurityTypes VncAuth,TLSVnc -geometry 1980x1020 -localhost no :58'" | sudo tee -a /etc/bash.bashrc
