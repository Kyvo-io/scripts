sudo apt update & sudo apt upgrade -y
sudo adduser monitro-user
sudo usermod -a -G sudo monitro-user
sudo su monitro-user

 cd monitro-user

git clone https://github.com/Kyvo-io/scripts.git
cd scripts


sudo apt-get install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker

sudo curl -SL https://github.com/docker/compose/releases/download/v2.23.0/dockercompose-linux-x86_64 -o /usr/local/bin/docker-compose

sudo docker build -t monitro/monitro-banco:1.0 .

sudo docker compose up --detach

