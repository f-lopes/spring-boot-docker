FROM openjdk:8-jre-alpine

MAINTAINER Florian Lopes <florian.lopes@outlook.com>

ENV SERVER_PORT=8080
ENV DEBUG_PORT=8000
ENV APP_HOME /app
ENV SPRING_BOOT_USER spring-boot
ENV SPRING_BOOT_GROUP spring-boot
ENV ARTIFACT_NAME spring-boot.jar

COPY assets/entrypoint.sh $APP_HOME/entrypoint.sh

VOLUME /tmp

RUN addgroup -S $SPRING_BOOT_USER && adduser -S -g $SPRING_BOOT_GROUP $SPRING_BOOT_USER && \
 chmod 555 $APP_HOME/entrypoint.sh && sh -c 'touch $APP_HOME/$ARTIFACT_NAME'

EXPOSE $SERVER_PORT
EXPOSE $DEBUG_PORT

WORKDIR $APP_HOME
USER $SPRING_BOOT_USER

ONBUILD COPY assets/spring-boot.jar $APP_HOME/$ARTIFACT_NAME

ENTRYPOINT ["./entrypoint.sh"]