ssh -i /mnt/hgfs/Downloads/documents/demo/jiuxianqiao/demo.pem centos@115.182.246.53
scp -i /mnt/hgfs/Downloads/documents/demo/jiuxianqiao/demo.pem /mnt/hgfs/Downloads/gitws/github.com/xwangqingyuan/kube-templates/nginx/nginx1.json centos@115.182.246.53:/home/centos/worktemp/
## process template
ktmpl /home/centos/worktemp/sample.json -p APP_NAME nginx6 -p SERVICE_NAME nginx6
## remarshal format
remarshal/remarshal -i /home/centos/worktemp/tnginx1.yaml -if yaml -o /home/centos/worktemp/tnginx1.json -of json
## create a deployment
ktmpl /home/centos/worktemp/tnginx1.json -p APP_NAME nginx3 -p SERVICE_NAME nginx3 | kubectl create -f -
## create redis-master
kubectl create -f /home/centos/worktemp/redis/redis-master.yaml
##
kubectl create -f /home/centos/worktemp/redis/redis-sentinel-service.yaml
##
kubectl create -f /home/centos/worktemp/redis/redis-controller.yaml
##
kubectl create -f /home/centos/worktemp/redis/redis-sentinel-controller.yaml
##
kubectl create -f /home/centos/worktemp/redis-amb-read.yaml
##
kubectl scale rc redis --replicas=3
##
kubectl scale rc redis-sentinel --replicas=3
##
kubectl create -f /home/centos/worktemp/redis/redis-proxy.yaml
##
curl -X PUT 10.120.63.7:6379/test1 -d "key1=value1"
##
curl -X PUT 10.120.44.5:6379/test1 -d "key1=value1"
##
echo -e "SET test1 8\r\nQUIT\r\n" | curl telnet://10.120.44.5:6379
echo -e "GET test1\r\nQUIT\r\n" | curl telnet://10.120.63.4:6379
echo -e "GET test1\r\nQUIT\r\n" | curl telnet://10.120.8.7:6379
echo -e "SET test1 9\r\nQUIT\r\n" | curl telnet://10.123.248.129:6379
echo -e "GET test1\r\nQUIT\r\n" | curl telnet://10.123.248.129:6379
##
http://yaychris.com/blog/2009/11/redis-part-1.html
##
kubectl expose rc redis --port=6379 --target-port=6379
## run a port-forward https://hub.docker.com/r/subitolabs/port-forward/~/dockerfile/
kubectl run redis-amb-read --image=subitolabs/port-forward --env="INPUT_PORT=6379" --env="TARGET_IP=10.123.248.129" --env="TARGET_PORT=6379"
## run haproxy
docker run -d --name redis-haproxy -p 10080:10080 -v /mnt/hgfs/Downloads/gitws/github.com/xwangqingyuan/kube-templates/haproxy/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro haproxy:1.5
docker kill -s HUP redis-haproxy
cat /mnt/hgfs/Downloads/gitws/github.com/xwangqingyuan/kube-templates/haproxy/tmpl-haproxy.cfg | sed -e "s/INPUT_PORT/$1/" -e "s/TARGET_IP/$2/" -e "s/TARGET_PORT/$3/" > haproxy.cfg
cat /mnt/hgfs/Downloads/gitws/github.com/xwangqingyuan/kube-templates/haproxy/template.cfg | sed -e "s/INPUT_PORT/$1/" -e "s/TARGET_IP/$2/" -e "s/TARGET_PORT/$3/" | docker run -d --name redis-haproxy -p 10081:10081 -v -:/usr/local/etc/haproxy/haproxy.cfg:ro haproxy:1.5
##

docker run -d --name redis-haproxy1 -p 10080:10080 -v /mnt/hgfs/Downloads/gitws/github.com/xwangqingyuan/kube-templates/haproxy/tmpl-haproxy.cfg:/tmpl-haproxy.cfg -v /mnt/hgfs/Downloads/gitws/github.com/xwangqingyuan/kube-templates/haproxy/starthaproxy.sh:/starthaproxy.sh haproxy:1.5 /starthaproxy.sh

##
docker run -d --name nginx -p 180:80 nginx:1.9.8
curl localhost:180
docker run -d --name haproxy1 -p 10080:10080 -e INPUT_PORT=10080 -e TARGET_IP=192.168.1.128 -e TARGET_PORT=180 -v /mnt/hgfs/Downloads/gitws/github.com/xwangqingyuan/kube-templates/haproxy/tmpl-haproxy.cfg:/tmpl-haproxy.cfg -v /mnt/hgfs/Downloads/gitws/github.com/xwangqingyuan/kube-templates/haproxy/starthaproxy.sh:/starthaproxy.sh haproxy:1.5 /starthaproxy.sh
##
docker build -t xwangqingyuan/port-forward-haproxy:0.2 .
docker run -d --name haproxy1 -p 10080:10080 -e INPUT_PORT=10080 -e TARGET_IP=192.168.1.128 -e TARGET_PORT=180 xwangqingyuan/port-forward-haproxy:0.3 /starthaproxy.sh
docker run -d --name haproxy3 -p 10081:10081 -e INPUT_PORT=10081 -e TARGET_IP=192.168.1.128 -e TARGET_PORT=180 xwangqingyuan/port-forward-haproxy:0.3 /starthaproxy.sh
docker run -it --rm -p 10080:10080 -e INPUT_PORT=10080 -e TARGET_IP=192.168.1.128 -e TARGET_PORT=180 xwangqingyuan/port-forward-haproxy:0.5 /bin/bash
