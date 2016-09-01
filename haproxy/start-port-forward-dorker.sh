echo "Example usage: start-port-forward-docker.sh 8080 192.168.1.1 80"
echo "Executing: start-port-forward-docker.sh $1 $2 $3"
docker run -d -p $1:$1 -e INPUT_PORT=$1 -e TARGET_IP=$2 -e TARGET_PORT=$3 xwangqingyuan/port-forward-haproxy:0.6
