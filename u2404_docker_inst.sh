#/bin/bash


echo "#######################  Install docker    ######################"

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



echo "#######################  config docker repo   ######################"
systemctl stop docker
systemctl stop docker.socket
systemctl stop containerd

echo "{ " >> /etc/docker/daemon.json
echo " \"data-root": "/home1/jon/docker\" " >>  /etc/docker/daemon.json
echo "} " >> /etc/docker/daemon.json

systemctl start docker
