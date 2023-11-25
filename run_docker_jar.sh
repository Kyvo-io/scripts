docker container rm $(docker container ls -aq) --force
sleep 5
sudo docker build -t monitro/monitro-banco:1.0 .
sleep 5
sudo docker compose up --detach
sudo docker compose up -d
sleep 5
java -jar login-monitro.jar
