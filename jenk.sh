#!/bin/bash
yum -y install net-tools
yum -y install java-1.8.0-openjdk
echo '[NGINX]
name=NGINX repo
baseurl=http://NGINX.org/packages/centos/7//$basearch/
gpgcheck=0
enabled=1'>/etc/yum.repos.d/NGINX.repo
yum -y install nginx

systemctl enable nginx
wget -O /etc/yum.repos.d/jenkins.repo http://jenkins-ci.org/redhat/jenkins.repo
rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
yum -y install jenkins
systemctl enable jenkins
sed -ie  '/include /a\\tserver {\n\t\tlisten 80;\n\t\tserver_name jenkins;\n\t\treturn 301 http://jenkins:8080$request_uri;\n\t\t}' /etc/nginx/nginx.conf 
systemctl start nginx
service jenkins start
