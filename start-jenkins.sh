#!/bin/bash
cd `dirname $0`

img_mvn="maven:3.3.3-jdk-8"                 # docker image of maven
m2_cache=~/.m2                 # the local maven cache dir
proj_home=$PWD                              # the project root dir
img_output="commons/xxl-job"         # output image tag

# 删除容器
docker rm -f xxl-job &> /dev/null

docker build -t $img_output .

mkdir -p $PWD/logs
chmod 777 $PWD/logs

version=`date "+%Y%m%d%H"`
#  --net=host \ -p 30120:30120
# 启动镜像
docker run -d --restart=on-failure:5 --privileged=true \
    --net=host \
    -w /usr/local/work \
    -v $PWD/doc/logs:/usr/local/work/doc/logs \
    --name xxl-job commons/xxl-job \
    java \
        -Duser.timezone=Asia/Shanghai \
        -XX:+PrintGCDateStamps \
        -XX:+PrintGCTimeStamps \
        -XX:+PrintGCDetails \
        -XX:+HeapDumpOnOutOfMemoryError \
        -Xloggc:logs/gc_$version.log \
        -jar /usr/local/work/app.jar --spring.profiles.active=jenkins \
docker logs xxl-job -f