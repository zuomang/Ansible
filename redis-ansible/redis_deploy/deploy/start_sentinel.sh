#!/bin/bash
SENTINEL_FILE='/var/redis/conf/sentinel.conf'

function exits() {
  echo $1
  exit 1
}

count=`ps -ef |grep "redis-server" |grep -v "sentinel" |grep -v "grep" |wc -l`
if [ $count -eq 0 ];then
    exits "Please start redis server first!"
fi

count=`ps -ef |grep "redis-server" |grep "sentinel" |grep -v "grep" |wc -l`
if [ $count -eq 0 ];then
    # run sentinel
    redis-server ${SENTINEL_FILE} --sentinel
    if [ $? -eq 0 ];then
        echo "Start redis sentinel succsessul!" && sleep 1
    else
        exits "Start redis sentinel failed!"
    fi
else
    echo "Redis sentinel has been started! You cannot start a new one on this host!"
fi
