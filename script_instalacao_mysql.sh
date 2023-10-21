#!/bin/bash
wget -O banco "https://raw.githubusercontent.com/Kyvo-io/scripts/main/monitro_script.sql" && sudo apt install mysql-server && cat banco | sudo mysql
