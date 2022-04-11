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

###  XXL通信地址
XXL_ADDRESSES="http://192.168.80.64:8055/xxl-job-admin"


### ------------------------------  1 - 可配置参数 - end  ---------------------------------





### ------------------------------  2 - 业务开始 - start  ---------------------------------
SERVER_PORT="-Dserver.port=${SERVER_PORT}"
APP_NAME="-Dxxl.job.executor.appname=${APP_NAME}"
EXECUTOR_IP="-Dxxl.job.executor.ip=${EXECUTOR_IP}"
XXL_PORT="-Dxxl.job.executor.port=${XXL_PORT}"
XXL_ADDRESSES="-Dxxl.job.admin.addresses=${XXL_ADDRESSES}"

PARAMS="${SERVER_PORT} ${APP_NAME} ${EXECUTOR_IP} ${XXL_PORT} ${XXL_ADDRESSES}"

### java ${PARAMS} -jar target/spider-executor-1.0-SNAPSHOT.jar



### 重启
restart() {
  stop
  start
}

### 停止
stop() {
  if [[ `ps -ef | grep -e "$APP_NAME" | grep -v grep | wc -l` -gt 0 ]]
  then
      kill -9 $(ps -ef | grep -e "$APP_NAME" | grep -v grep | awk '{print $2}')
  fi
}

### 启动
start() {
  nohup java ${PARAMS} -jar target/spider-executor-1.0-SNAPSHOT.jar > ./console.log 2>&1 &
#  java ${PARAMS} -jar target/spider-executor-1.0-SNAPSHOT.jar
}

### 状态
status() {
  if [[ `ps -ef | grep -e "$APP_NAME" | grep -v grep | wc -l` -gt 0 ]]
  then
      echo -e "\033[32m ***  services is running *** \033[0m"
      exit 0
  fi

  echo -e "\033[33m ***  services not found *** \033[0m"
}

usage(){
    cat <<EOF
Usage:
    ./spider-executor.sh [start/stop/restart/status]
    start                   (Start services)
    stop                    (stop services)
    restart                 (restart services)
    status                  (status services)
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
  "status") status
  ;;
  *) usage
    ;;
esac

### ------------------------------  2 - 业务开始 - end  ---------------------------------

