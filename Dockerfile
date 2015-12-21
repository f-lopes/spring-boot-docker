FROM java:8

MAINTAINER Florian Lopes <florian.lopes@outlook.com>

VOLUME /tmp

ENV APP_HOME /app
ENV APP_JAR spring-boot-application.jar

ADD assets/${APP_JAR} ${APP_HOME}/${APP_JAR}

ADD assets/entrypoint.sh ${APP_HOME}/entrypoint.sh
RUN chmod 755 ${APP_HOME}/entrypoint.sh

RUN bash -c 'touch ${APP_HOME}/${APP_JAR}'

ENTRYPOINT ["/app/entrypoint.sh"]
