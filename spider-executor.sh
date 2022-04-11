#!/bin/bash


### ------------------------------  1 - 可配置参数 - start  ---------------------------------

###  SPRING运行端口
SERVER_PORT=48500

###  执行器名称(名称规则为：项目名-节点-宿主IP最后一位)
APP_NAME="spider-executor-node-64"

###  修改为宿主机IP
EXECUTOR_IP="192.168.91.100"

###  XXL通信端口
XXL_PORT=48501

### ------------------------------  1 - 可配置参数 - end  ---------------------------------





### ------------------------------  2 - 业务开始 - start  ---------------------------------
SERVER_PORT="-Dserver.port=${SERVER_PORT}"
SERVER_PORT="-Dspring.application.name=${APP_NAME}"
APP_NAME="-Dxxl.job.executor.appname=${APP_NAME}"
EXECUTOR_IP="-Dxxl.job.executor.ip=${EXECUTOR_IP}"
XXL_PORT="-Dxxl.job.executor.port=${XXL_PORT}"

PARAMS="${SERVER_PORT} ${APP_NAME} ${EXECUTOR_IP} ${XXL_PORT}"

### java ${PARAMS} -jar target/spider-executor-1.0-SNAPSHOT.jar



### 重启
restart() {
  exit 0
}

### 停止
stop() {
  ps -ef | grep -e "$APP_NAME" | grep -v grep | awk '{print $2}' | xargs kill -9
}
### 启动
start() {
  nohup java ${PARAMS} -jar target/spider-executor-1.0-SNAPSHOT.jar > ./console.log 2>&1 &
#  java ${PARAMS} -jar target/spider-executor-1.0-SNAPSHOT.jar

}


usage(){
    cat <<EOF
Usage:
    ./spider-executor.sh [start/stop/restart]
    start                   (Start services)
    stop                    (stop services)
    restart                 (restart services)
EOF
    exit 1
}

### 参数个数 - 不为1则不合法
ARG_COUNT=$#
if [[ $ARG_COUNT -ne 1 ]]
then
  usage
  exit 1
fi


COMMAND=$1
case "$COMMAND" in
  "start")  start
  ;;
  "stop") stop
  ;;
  "restart") restart
  ;;
  *) usage
    ;;
esac

### ------------------------------  2 - 业务开始 - end  ---------------------------------

