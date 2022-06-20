#!/bin/bash

#set debug mode
set +x

# logs of userdata save 
exec > >(tee /userdata_log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

sudo mkdir -p /userdata_log

echo  " update and fetch existing packages and install httpd server"
sudo yum update -y
sudo yum install httpd -y

# change httpd listen port 80 to 90
sed -i "s#Listen 80#Listen 90#g" /etc/httpd/conf/httpd.conf

#add data to index.html
echo " hi this is vishalk17" >> /var/www/html/index.html

echo "apache httpd server on and automatic on if instance restart"
sudo service httpd on
sudo chkconfig httpd on
