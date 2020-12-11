#!/bin/bash
cd `dirname $0`

img_mvn="maven:3.3.3-jdk-8"                 # docker image of maven
m2_cache=~/.m2                 # the local maven cache dir
proj_home=$PWD                              # the project root dir
img_output="commons/xxl-job"         # output image tag

git pull  # should use git clone https://name:pwd@xxx.git

echo "use docker maven"
docker run --rm \
   -v $m2_cache:/root/.m2 \
   -v $proj_home:/usr/local/work \
   -w /usr/local/work $img_mvn mvn clean package -U -Dmaven.test.skip=true

sudo mv $proj_home/xxl-job-admin/target/xxl-job-admin-*.jar $proj_home/xxl-job-admin/target/app.jar # 兼容所有sh脚本
docker build -t $img_output .

mkdir -p $PWD/logs
chmod 777 $PWD/logs

# 删除容器
docker rm -f xxl-job &> /dev/null

version=`date "+%Y%m%d%H"`

# 启动镜像
docker run -d --restart=on-failure:5 --privileged=true \
    --net=host \
    -w /usr/local/work \
    -v $PWD/doc/logs:/usr/local/work/doc/logs \
    --name xxl-job -p 30120:30120 commons/xxl-job \
    java \
        -Duser.timezone=Asia/Shanghai \
        -XX:+PrintGCDateStamps \
        -XX:+PrintGCTimeStamps \
        -XX:+PrintGCDetails \
        -XX:+HeapDumpOnOutOfMemoryError \
        -Xloggc:logs/gc_$version.log \
        -jar /usr/local/work/app.jar \

docker logs -f xxl-job
