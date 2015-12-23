##NOTICE:
**After deploying Redis, you should guarantee that only one MASTER service and at least two SLAVE services are in operation.**

The details of hosts are:

| NAME | ADDRESS | HOSTNAME | TYPE |
|:---:|:---:|:---:|:---:|
| infra0 | 10.0.1.10 | CNPVGVB1OD000.pvgl.sap.corp | MASTER |
| infra1 | 10.0.1.11 | CNPVGVB1OD001.pvgl.sap.corp | SLAVE |
| infra2 | 10.0.1.12 | CNPVGVB1OD002.pvgl.sap.corp | SLAVE |
| ... | ... | ... | SLAVE |

##Install Steps:
* Download Redis-3.0.5 to each hosts:
```sh
$ wget http://download.redis.io/releases/redis-3.0.5.tar.gz
```
* Extract the package, compile and install:
```sh
$ tar -xzvf redis-3.0.5.tar.gz
$ cd redis-3.0.5
$ make
$ make install
```
* Delete the source code (optional):
```sh
$ cd ..
$ rm -fr redis-3.0.5 redis-3.0.5.tar.gz
```
##Deploy Redis service and Sentinel service:
* Download deploy folder to each hosts. [Releases](https://github.wdf.sap.corp/i319433/redis_deploy/releases)

* Enter the folder on each hosts:
```sh
$ cd deploy
$ chmod +x *.sh
```
* Go to infra0, deploy and start MASTER service first on a host (only one MASTER service):
```sh
$ env TYPE=MASTER MASTERIP=[MASTER_IP] PASSWORD=[PASSWORD] ./deploy_redis.sh
```
* Go to infra1 / infra2 / ... , deploy and start SLAVE services on other hosts (at least two SLAVE services):
```sh
$ env TYPE=SLAVE MASTERIP=[MASTER_IP] PASSWORD=[PASSWORD] ./deploy_redis.sh
```
**Ip address in all commands are MASTER host ip, and password in all commands have to be same.**
* Go to each hosts, check service running status:
```sh
$ ps -ef | grep redis
root     27041     1  0 11:33 ?        00:04:40 redis-server *:6379
root     29208     1  0 11:33 ?        00:00:13 redis-server *:26379 [sentinel]
```
**The [deploy_redis.sh](https://github.wdf.sap.corp/i319433/redis_deploy/blob/master/deploy/deploy_redis.sh) script starts a redis server and a redis sentinel after deployed.**

##Startup Script:
* If redis server is down, start it using [start_server.sh](https://github.wdf.sap.corp/i319433/redis_deploy/blob/master/deploy/start_server.sh)
* If redis sentinel is down, start it using [start_sentinel.sh](https://github.wdf.sap.corp/i319433/redis_deploy/blob/master/deploy/start_sentinel.sh)
