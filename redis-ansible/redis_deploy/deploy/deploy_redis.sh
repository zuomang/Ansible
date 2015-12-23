#!/bin/bash
function exits() {
  echo $1
  exit 1
}

count=`ps -ef |grep "redis-server" |grep -v "grep" |wc -l`
if [ $count -ne 0 ];then
    # shutdown redis sentinel shutdown
    redis-cli -p 26379 shutdown
    redis-cli -p 6379 -a ${PASSWORD} shutdown
fi

rm -fr /var/redis

mkdir -p /var/redis/conf/
mkdir -p /var/redis/log/

REDIS_FILE='/var/redis/conf/redis.conf'
SENTINEL_FILE='/var/redis/conf/sentinel.conf'

MASTERIP=${MASTERIP}
PASSWORD=${PASSWORD}
TYPE=${TYPE}

# argument validation
[ -z ${MASTERIP} ] && exits "Missing mandatory argument MASTERIP="
[ -z ${PASSWORD} ] && exits "Missing mandatory argument PASSWORD="

cp ./conf/redis.conf     ${REDIS_FILE}
cp ./conf/sentinel.conf  ${SENTINEL_FILE}

sed -i "s/^# requirepass.*/requirepass ${PASSWORD}/" ${REDIS_FILE}
sed -i "s/^# masterauth.*/masterauth ${PASSWORD}/" ${REDIS_FILE}

sed -i "s/^# sentinel auth-pass mymaster.*/sentinel auth-pass mymaster ${PASSWORD}/" ${SENTINEL_FILE}
sed -i "s/^# sentinel monitor mymaster.*/sentinel monitor mymaster ${MASTERIP} 6379 2/" ${SENTINEL_FILE}

if [ ${TYPE} = 'SLAVE' ]
then
    sed -i "s/^# slaveof.*/slaveof ${MASTERIP} 6379/" ${REDIS_FILE}
fi

# run server
redis-server ${REDIS_FILE}
if [ $? -eq 0 ];then
    echo "Start redis server succsessul!" && sleep 1
else
    exits "Start redis server failed!"
fi

# run sentinel
redis-server ${SENTINEL_FILE} --sentinel
if [ $? -eq 0 ];then
    echo "Start redis sentinel succsessul!" && sleep 1
else
    exits "Start redis sentinel failed!"
fi
