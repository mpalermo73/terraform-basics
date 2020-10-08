#!/usr/bin/env bash

sudo hostnamectl set-hostname service01.$(curl -sL http://169.254.169.254/latest/meta-data/hostname)

rpm -qa | sort | sudo tee /tmp/rpmlist.txt

while [ -f /run/yum.pid ] ; do sleep 1 ; done

HTTP_INDEX="/var/www/html/index.html"

sudo yum -y install httpd
echo "<pre>" | sudo tee /var/www/html/index.html >/dev/null
echo "$(hostname -s): $(curl -sL http://169.254.169.254/latest/meta-data/local-ipv4)" | sudo tee -a /var/www/html/index.html >/dev/null
echo "---------------------------" | sudo tee -a /var/www/html/index.html >/dev/null
hostnamectl | sudo tee -a /var/www/html/index.html >/dev/null
echo "---------------------------" | sudo tee -a /var/www/html/index.html >/dev/null
id | sudo tee -a /var/www/html/index.html >/dev/null
echo "---------------------------" | sudo tee -a /var/www/html/index.html >/dev/null
env | grep -v LS_COLORS | sort | sudo tee -a /var/www/html/index.html >/dev/null
echo "---------------------------" | sudo tee -a /var/www/html/index.html >/dev/null
cat /tmp/rpmlist.txt | sudo tee -a /var/www/html/index.html >/dev/null
echo "---------------------------" | sudo tee -a /var/www/html/index.html >/dev/null
echo "</pre>" | sudo tee -a /var/www/html/index.html >/dev/null
sudo systemctl restart httpd
