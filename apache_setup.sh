#!/usr/bin/bash
yum install httpd -y
echo "Terraform server" >> /var/www/html/index.html
systemctl enable httpd
systemctl start httpd
