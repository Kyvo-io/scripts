2#!/bin/bash

while true; do
    echo "Bem-vindo à instalação da aplicação!"
    echo "------------------------------"
    echo "1. Instalar atualizações, arquivos e dependências"
    echo "2. Instalar Docker e Docker Compose"
    echo "3. Executar aplicação"
    echo "4. Sair"
    echo "------------------------------"

    read -p "Por favor, selecione uma opção (1-4): " choice

    case $choice in
        1)
            echo "Atualizando pacotes..."
            sudo apt update && sudo apt upgrade -y
            echo "Baixando arquivos e dependências..."
            cd ~
            rm -d -rf scripts
            sleep 5
            git clone https://github.com/Kyvo-io/scripts.git
            cd scripts
            ;;
        2)
            echo "Instalando Docker e Docker Compose..."
            sudo apt-get install docker.io -y
            sudo systemctl start docker
            sudo systemctl enable docker
            sleep 5
            sudo curl -L "https://github.com/docker/compose/releases/download/v2.23.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
            sudo chmod +x /usr/local/bin/docker-compose
            ;;
        3)
            echo "Executando a aplicação..."
            mkdir logs
            sudo chmod 777 run_docker_jar.sh
            sudo chmod 777 login-monitro-jar
            bash run_docker_jar.sh
            ;;
        4)
            echo "Saindo..."
            exit 0
            ;;
        *)
            echo "Opção inválida. Por favor, escolha uma opção válida."
            ;;
    esac
done
