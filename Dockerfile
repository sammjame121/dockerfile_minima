FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
#ARG   构建时指定的一些参数
#DEBIAN_FRONTEND这个环境变量，告知操作系统应该从哪儿获得用户输入。如果设置为"noninteractive"，你就可以直接运行命令，而无需向用户请求输入（所有操作都是非交互式的）。
WORKDIR /minima
#指定工作目录。用 WORKDIR 指定的工作目录，会在构建镜像的每一层中都存在。（WORKDIR 指定的工作目录，必须是提前创建好的）。
#docker build 构建镜像过程中的，每一个 RUN 命令都是新建的一层。只有通过 WORKDIR 创建的目录才会一直存在。
RUN apt-get -y update   
#apt-get 升级，过程中选择-y同意
RUN apt-get -y install pkg-config curl git build-essential libssl-dev  
#通过apt-get 安装pkg-config curl git build-essential libssl-dev这几个工具，过程中选择-y同意
RUN apt-get -y install openjdk-11-jre-headless wget
#通过apt-get 安装openjdk-11-jre-headless wget这几个工具，过程中选择-y同意


RUN wget -q -O minima.jar https://github.com/minima-global/Minima/raw/master/jar/minima.jar
#下载文件并保存指定命名
COPY start.sh /minima/start.sh
#复制指令，从上下文目录中复制文件或者目录到容器里指定路径。
#复制start.sh文件容器的/minima/并执行？
VOLUME ["/minima/data"]
#挂载数据卷，避免重要的数据丢失
ENTRYPOINT ["/minima/start.sh"]
#执行/minima/start.sh文件

#dockerfile里面的这些指令是build的时候创建镜像用的（即创建的时候执行以上命令）
#别人pull下来只会执行entrypoint