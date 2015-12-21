#!/bin/sh
if [ $DEBUG ]; then
  ADDITIONAL_PARAMETERS="-Xdebug -Xrunjdwp:server=y,transport=dt_socket,address=8000,suspend=n"
fi

java $ADDITIONAL_PARAMETERS \
       -Djava.security.egd=file:/dev/./urandom -jar ${APP_HOME}/${APP_JAR}
