# script for redhat based os

echo "add jenkins repo"
sleep 2
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key

echo "upgrade all packages and existing package list"

sudo yum upgrade -y

echo "Installing jenkins"

sudo yum install jenkins -y

echo " jenkins installed"
sleep 2

echo "installing java jdk 11"

sudo amazon-linux-extras install java-openjdk11 -y

echo ""
echo "installed java jdk 11"


