#!/bin/sh

if [ "$DEBUG" = true ]; then
  ADDITIONAL_PARAMETERS="-Xdebug -Xrunjdwp:server=y,transport=dt_socket,address=8000,suspend=n"
fi

# Enables application to take PID 1 and receive SIGTERM sent by Docker stop command.
# See here https://docs.docker.com/engine/reference/builder/#/entrypoint
exec java $ADDITIONAL_PARAMETERS \
       -Djava.security.egd=file:/dev/./urandom -jar ${APP_HOME}/${APP_JAR}