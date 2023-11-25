docker container rm $(docker container ls -aq) --force
docker rmi $(docker image ls -aq) --force
sudo docker build -t monitro/monitro-banco:1.0 .
sleep 5
sudo docker compose up --detach
sudo docker compose up -d
sleep 5
java -jar login-monitro.jar
