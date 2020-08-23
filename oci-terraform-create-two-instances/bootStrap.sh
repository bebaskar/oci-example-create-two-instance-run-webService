#!/bin/bash
echo '################### webserver userdata begins #####################'
touch userdata.`date +%s`.start
echo '########## apt update all ###############'
sudo apt-get update -y
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update -y 
sudo apt-get install docker-ce docker-ce-cli containerd.io -y 
echo '########## basic webserver ##############'
docker run -d -p 80:80 tutum/hello-world
touch userdata.`date +%s`.finish
echo '################### webserver userdata ends #######################'