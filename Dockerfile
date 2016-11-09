FROM openjdk:8-jre-alpine

MAINTAINER Florian Lopes <florian.lopes@outlook.com>

ARG SERVER_PORT=8080
ARG DEBUG_PORT=8000

VOLUME /tmp

ENV APP_HOME /app
ENV ARTIFACT_NAME ${ARTIFACT_NAME}

COPY assets/entrypoint.sh ${APP_HOME}/entrypoint.sh

RUN chmod 755 ${APP_HOME}/entrypoint.sh && sh -c 'touch ${APP_HOME}/${ARTIFACT_NAME}'

EXPOSE ${SERVER_PORT}
EXPOSE ${DEBUG_PORT}

WORKDIR ${APP_HOME}

ONBUILD ADD assets/${ARTIFACT_NAME} ${APP_HOME}/${ARTIFACT_NAME}

ENTRYPOINT ["./entrypoint.sh"]