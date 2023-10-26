#!/bin/bash

criarUsuario(){
    echo "Insira o nome do usuário"
    read get
    sudo adduser $get
    sudo usermod -a -G sudo $get 
    sudo su $get
    sudo apt update
    sudo apt upgrade
}
setupJar(){
    java -version #verifica versao atual do java
    if [ $? = 0 ]; #se retorno for igual a 0
    then #entao,
    echo “java instalado” #print no terminal
    else #se nao,
    echo “java não instalado” #print no terminal
    sudo apt install openjdk-17-jre -y #executa instalacao do java
    fi #fecha o 1º if

    mysql
    if [ $? = 0 ];
    then
    echo "mysql instalado"
    else
    echo "mysql não instalado"
    sudo apt install mysql-server
    fi

    wget -O banco "https://raw.githubusercontent.com/Kyvo-io/scripts/main/monitro_script.sql"
    cat banco | sudo mysql

    sudo apt install maven
    rm -r -f monitro-java
    git clone https://github.com/Kyvo-io/monitro-java.git
    cd monitro-java
    cd login-monitro
    mvn install -e
    mvn compile -e 
    mvn package -e
    java -cp target/login-monitro-1.0-jar-with-dependencies.jar App
}
abrirJar(){
    cd monitro-java
    if [ $? = 0 ];
    then
    cd login-monitro
    java -cp target/login-monitro-1.0-jar-with-dependencies.jar App
    if [ $? = 0 ];
    then 
    echo "abriu"
    else 
    echo "jar não instalado"
    fi
    else
    echo "jar não instalado"
    fi
}
obterProcessos(){
    cd monitro-java
    if [ $? = 0 ];
    then
    cd login-monitro
    java -cp target/login-monitro-1.0-jar-with-dependencies.jar TesteLooca
    if [ $? = 0 ];
    then 
    echo "abriu"
    else 
    echo "jar não instalado"
    fi
    else
    echo "jar não instalado"
    fi
}
menu(){
echo "Bem vindo ao script de instalação em máquinas da Monitro!"

echo "1 - Criar usuário"
echo "2 - Instalar o JAR (Instalação do Banco e Java inclusa)"
echo "3 - Abrir JAR"
echo "4 - Obter processos"
echo "Escolha o que deseja: "
read get
if [ \“$get\” == \“1\” ];
then
criarUsuario
menu
fi

if [ \“$get\” == \“2\” ];
then
setupJar
fi

if [ \“$get\” == \“3\” ];
then
abrirJar
fi
if [ \“$get\” == \“3\” ];
then
obterProcessos
fi
}
menu

