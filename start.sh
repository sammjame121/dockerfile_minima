#!/bin/bash
#这里是无限轮询，一小时重启一下minima和ping一下
while true; do
  pkill java
  #杀死java进程
  /usr/bin/java -Xmx1G -jar /minima/minima.jar -rpcenable -rpc ${RPC} -port ${PORT} -data /minima/data &
  #/usr/bin/java -Xmx1G -jar /minima/minima.jar   /usr/bin/java是jkd默认安装路径；进入 JAR 文件夹并按如下方式运行（同时为 Minima 分配最大 1GB RAM）：
  #-rpcenable -rpc ${RPC} -port ${PORT} -data /minima/data &   从系统的ENV VARIABLE拿参数，docker run的时候不是传了一些参数进去
  #sudo docker run -it --cpus=0.1 --name minima_8001 -p 8001:8001 -p 8002:8002 -e "PORT=8001" -e "RPC=8002" -e "UID=$3" -v ~/minima/data_8001:/minima/data -d qsobad/minima:nighty
  #-e username="ritchie": 设置环境变量；  --volume , -v: 绑定一个卷   -v ~/minima/data_8001:/minima/data   前面是宿主卷地址，映射到，后面是镜像卷地址 
  sleep 60
  /bin/curl 127.0.0.1:${RPC}/incentivecash+uid:${UID}
  #开票，ping一下
  sleep $[60 * 60]
done
