#!/bin/bash
cd `dirname $0`

img_mvn="maven:3.3.3-jdk-8"                 # docker image of maven
m2_cache=/user/local/apache-maven-3.6.3/repository                 # the local maven cache dir
proj_home=$PWD                              # the project root dir
img_output="commons/xxl-job"         # output image tag

git pull  # should use git clone https://name:pwd@xxx.git

echo "use docker maven"
docker run --rm \
   -v $m2_cache:/user/local/apache-maven-3.6.3/repository \
   -v $proj_home:/usr/local/maven \
   -w /usr/local/maven $img_mvn mvn clean package -U -Dmaven.test.skip=true


   docker run --rm \
   -v /user/local/apache-maven-3.6.3/repository:/user/local/apache-maven-3.6.3/repository \
   -v /root/commons/xxl_job/xxl-job-admin:/usr/local/maven \
   -w /usr/local/maven maven:3.3.3-jdk-8 mvn clean package -U -Dmaven.test.skip=true

sudo mv $proj_home/target/xxl-job-admin-*.jar $proj_home/app.jar # 兼容所有sh脚本
docker build -t $img_output .

mkdir -p $PWD/logs
chmod 777 $PWD/logs

# 删除容器
docker rm -f xxl-job &> /dev/null

version=`date "+%Y%m%d%H"`
41414124
# 启动镜像
docker run -d --restart=on-failure:5 --privileged=true \
    --net=host \
    -w /home \
    -v $PWD/logs:/home/logs \
    --name xxl-job commons/xxl-job \
341414143
docker logs -f xxl-job
