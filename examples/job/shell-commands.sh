docker build -t xwangqingyuan/rediswq .
docker run xwangqingyuan/rediswq
docker run xwangqingyuan/rediswq
docker run -v /mnt/hgfs/Downloads/gitws/github.com/xwangqingyuan/kube-templates/examples/job/worker.py:/worker.py xwangqingyuan/rediswq
docker run -e REDIS_SERVICE_HOST=10.1.1.1 -v /mnt/hgfs/Downloads/gitws/github.com/xwangqingyuan/kube-templates/examples/job/worker.py:/worker.py xwangqingyuan/rediswq

###
kubectl create -f ~/Downloads/gitws/github.com/xwangqingyuan/kube-templates/examples/job/redis.yaml
kubectl create -f ~/Downloads/gitws/github.com/xwangqingyuan/kube-templates/examples/job/redis-service.yaml
kubectl create -f ~/Downloads/gitws/github.com/xwangqingyuan/kube-templates/examples/job/job.yaml
