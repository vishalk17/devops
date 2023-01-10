sudo curl -L https://github.com/docker/compose/releases/download/v2.15.1/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version
