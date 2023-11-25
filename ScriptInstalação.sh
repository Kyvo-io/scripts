echo "Atualizando pacotes para instalação da aplicação"
sudo apt update & sudo apt upgrade -y

sudo service mysql stop
cd ~
rm -d -rf scripts
sleep 5
echo "Instalação dos arquivos e dependências necessárias"
git clone https://github.com/Kyvo-io/scripts.git
cd scripts
sudo apt-get install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sleep 5
sudo curl -L "https://github.com/docker/compose/releases/download/v2.23.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sleep 5
bash run_docker_jar.sh

