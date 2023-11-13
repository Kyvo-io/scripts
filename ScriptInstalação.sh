echo "Atualizando pacotes para instalação da aplicação"
sudo apt update & sudo apt upgrade -y

sudo service mysql stop
cd ~

echo "Instalação dos arquivos e dependências necessárias"

rm -d -rf scripts
git clone https://github.com/Kyvo-io/scripts.git
cd scripts


sudo apt-get install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker

sudo curl -L "https://github.com/docker/compose/releases/download/v2.23.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo docker build -t monitro/monitro-banco:1.0 .

sudo docker compose up --detach

java -jar login-monitro.jar

