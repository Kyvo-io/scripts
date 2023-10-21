#!/bin/bash
sudo adduser usuario
sudo apt update
sudo apt upgrade
setupJava(){
java -version #verifica versao atual do java
if [ $? = 0 ]; #se retorno for igual a 0
then #entao,
echo “java instalado” #print no terminal
else #se nao,
echo “java não instalado” #print no terminal
echo “gostaria de instalar o java? [s/n]” #print no terminal
read get #variável que guarda resposta do usuário
if [ \“$get\” == \“s\” ]; #se retorno for igual a 0
then #entao
sudo apt install openjdk-17-jre -y #executa instalacao do java
fi #fecha o 2º if
fi #fecha o 1º if
}
setupJava
setupJar(){
    sudo apt install maven
    rm -r -f monitro-java
    git clone https://github.com/Kyvo-io/monitro-java.git
    cd monitro-java
    cd login-monitro
    mvn install
    mvn compile
    mvn package
    java -cp target/login-monitro-1.0-jar-with-dependencies.jar App
}
setupJar