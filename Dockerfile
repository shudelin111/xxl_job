FROM fabric8/java-jboss-openjdk8-jdk
USER root

MAINTAINER shudl

ENV PARAMS=""

ENV TZ=PRC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


COPY xxl-job-admin/target/xxl-job-admin-*.jar /usr/local/work/app.jar
#ENTRYPOINT ["sh","-c","java -jar $JAVA_OPTS /app.jar $PARAMS"]
