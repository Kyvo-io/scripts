#!/bin/bash
echo "*--------------------------------------------*"
echo "|   Preparando o ambiente para a aplicação   |"
echo "|     Removendo containers existentes...     |"
echo "*--------------------------------------------*"

sudo docker container rm $(sudo docker container ls -aq) --force
sleep 5

echo "*-------------------------------------------*"
echo "| Construindo a imagem do banco de dados... |"
echo "*-------------------------------------------*"

sudo docker build -t monitro/monitro-banco:1.0 .
sleep 5
echo "*---------------------------*"
echo "| Iniciando os serviços...  |"
echo "*---------------------------*"

sudo docker-compose up --detach
# ou, se preferir
# sudo docker-compose up -d
sleep 5
echo "*---------------------------*"
echo "| Executando a aplicação... |"
echo "*---------------------------*"

java -jar login-monitro.jar

echo "*-----------------------------------*"
echo "| Ambiente configurado com sucesso! |"
echo "*-----------------------------------*"

