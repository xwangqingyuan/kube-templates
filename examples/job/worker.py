#!/usr/bin/env python

import time
import rediswq

#host="redis"
import os
host = os.getenv("REDIS_SERVICE_HOST")
job = os.getenv("REDIS_JOB_NAME")

print("host=" + str(host))

def processQueue(host):
    print("Process started")
    q = rediswq.RedisWQ(name=job, host=host)
    print("Worker with sessionID: " +  q.sessionID())
    print("Initial queue state: empty=" + str(q.empty()))
    while not q.empty():
      item = q.lease(lease_secs=10, block=True, timeout=2)
      if item is not None:
        itemstr = item.decode("utf=8")
        print("Working on " + itemstr)
        time.sleep(10) # Put your actual work here instead of sleep.
        q.complete(item)
      else:
        print("Waiting for work")
    print("Process finished")
processQueue(host)
print("Queue empty, exiting")
