#!/bin/bash

echo "Preparando o ambiente para a aplicação..."
echo "------------------------------"

echo "Removendo containers existentes..."
sudo docker container rm $(sudo docker container ls -aq) --force
sleep 5

echo "Construindo a imagem do banco de dados..."
sudo docker build -t monitro/monitro-banco:1.0 .
sleep 5

echo "Iniciando os serviços..."
sudo docker-compose up --detach
# ou, se preferir
# sudo docker-compose up -d
sleep 5

echo "Executando a aplicação..."
java -jar login-monitro.jar

echo "Ambiente configurado com sucesso!"
