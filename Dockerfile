FROM openjdk:8-jre-slim
USER root

MAINTAINER shudl

ENV PARAMS=""

ENV TZ=PRC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY /usr/local/apache-maven-3.6.3/conf/settings.xml /usr/share/maven/settings.xml

#COPY xxl-job-admin/target/xxl-job-admin-*.jar /app.jar
#ENTRYPOINT ["sh","-c","java -jar $JAVA_OPTS /app.jar $PARAMS"]
