echo Testing $1 ...
echo Building image ...
docker build -t $1 servers/$1

echo Starting server ...
docker run -d --name=server --network=testnet $1

if [[ "$1" == trellis ]]
  then
    docker logs server
    echo Waiting for ten seconds ...
    sleep 10
    docker logs server
fi

# echo Running ldp-basic tester ...
# docker run --network=testnet ldp-basic > reports/$1-ldp-basic.txt
# 
# echo Running websockets-pubsub tester ...
# docker run --network=testnet websockets-pubsub 2> reports/$1-websockets-pubsub.txt

echo Running perl-based tester ...
docker run --network=testnet perl-based > reports/$1-perl-based.txt

echo Stopping server ...
docker stop server

echo Removing server ...
docker rm server
