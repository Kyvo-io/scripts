#!bin/bash
wget -O banco "https://raw.githubusercontent.com/Kyvo-io/scripts/main/monitro_script.sql"
cat banco | sudo mysql