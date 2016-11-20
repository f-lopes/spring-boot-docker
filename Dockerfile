FROM openjdk:8-jre-alpine

MAINTAINER Florian Lopes <florian.lopes@outlook.com>

ARG SERVER_PORT=8080
ARG DEBUG_PORT=8000

ENV SERVER_PROTOCOL http
ENV HEALTHCHECK_CONTEXT /
ENV APP_HOME /app
ENV ARTIFACT_NAME ${ARTIFACT_NAME}

VOLUME /tmp

COPY assets/entrypoint.sh ${APP_HOME}/entrypoint.sh

RUN chmod 755 ${APP_HOME}/entrypoint.sh && sh -c 'touch ${APP_HOME}/${ARTIFACT_NAME}'

EXPOSE ${SERVER_PORT}
EXPOSE ${DEBUG_PORT}

WORKDIR ${APP_HOME}

# Install curl to provide healthcheck
RUN apk --no-cache add curl

ONBUILD ADD assets/${ARTIFACT_NAME} ${APP_HOME}/${ARTIFACT_NAME}

HEALTHCHECK --timeout=10s CMD curl --fail ${SERVER_PROTOCOL}://localhost:${SERVER_PORT}/${HEALTHCHECK_CONTEXT} || exit 1

ENTRYPOINT ["./entrypoint.sh"]