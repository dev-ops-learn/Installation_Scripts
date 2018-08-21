#!/bin/sh

###############################################################
#FileName     :  Install-Jenkins-on-RHEL.sh
#Purpose      :  Jenkins Install on RedHat Linux
#Version      :  0.1
#Author       :  Anand Reddy
#Created      :  02/11/17
###############################################################

#sudo su -

echo "################################################################"
echo "############# Jenkins Installation Started  ####################"
echo "################################################################"

sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins.io/redhat-stable/jenkins.repo

sudo rpm --import http://pkg.jenkins.io/redhat-stable/jenkins.io.key

sudo yum install jenkins  –y -y

sudo service jenkins start
