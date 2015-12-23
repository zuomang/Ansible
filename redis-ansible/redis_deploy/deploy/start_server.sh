#!/bin/bash
REDIS_FILE='/var/redis/conf/redis.conf'

function exits() {
  echo $1
  exit 1
}

count=`ps -ef |grep "redis-server" |grep -v "sentinel" |grep -v "grep" |wc -l`
if [ $count -eq 0 ];then
    # run server
    redis-server ${REDIS_FILE}
    if [ $? -eq 0 ];then
        echo "Start redis server succsessul!" && sleep 1
    else
        exits "Start redis server failed!"
    fi
else
    echo "Redis server has been started! You cannot start a new one on this host!"
fi
