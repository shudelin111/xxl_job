FROM openjdk:8-jre-slim
USER root

MAINTAINER shudl

ENV PARAMS=""

ENV TZ=PRC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY settings.xml /usr/share/maven/settings.xml

COPY xxl-job-admin/target/app.jar /usr/local/work/
#ENTRYPOINT ["sh","-c","java -jar $JAVA_OPTS /app.jar $PARAMS"]
