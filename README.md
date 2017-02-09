#Lightweight Spring Boot Docker image based on Alpine + Docker Compose file

[![](https://images.microbadger.com/badges/image/flopes/spring-boot-docker.svg)](https://microbadger.com/images/flopes/spring-boot-docker "Get your own image badge on microbadger.com")

[![](http://dockeri.co/image/flopes/spring-boot-docker)](http://dockeri.co/image/flopes/spring-boot-docker 'Docker build status')

Features:
- Spring profiles
- Custom JAVA_OPTS
- Healthcheck
- Wrapper script that enables application to take PID 1 & receive SIGTERM signals
- Debug mode

This tag integrates an healthcheck feature to tell Docker how to check the status of the container. This feature simply executes an HTTP request to a given URL: `${SERVER_PROTOCOL}://localhost:${SERVER_PORT}/${HEALTHCHECK_CONTEXT}`

## Available environment variables

Name                    | Default   | Description
------------------------|-----------|------------------------------------
DEBUG                   | false | Enable or disable debug mode
DEBUG_PORT              | 8000  | Debug port
SPRING_PROFILES_ACTIVE  | dev   | Active Spring profiles
JAVA_OPTS               |       | JAVA_OPTS
**SERVER_PROTOCOL**     | http  | Spring Boot application server protocol, picked by the healthcheck command to check the application status
**SERVER_PORT**         | 8080  | Spring Boot application server port (server.port), picked by the healthcheck command to check the application status
**HEALTHCHECK_CONTEXT** | /     | The context URL to check the application status, picked by the healthcheck command to check the application status


## How to use ?

1. Simply extend your image from `flopes/spring-boot-docker` and set your application name as an environment variable:
    ``` Docker
    FROM flopes/spring-boot-docker:1.0
    
    ENV ARTIFACT_NAME my-spring-boot-application.jar
    ```

2. Copy your Spring Boot executable jar into an `assets` folder and build you image:
```docker build -t spring-boot-image . ```

3. Start your application:
    - Using Docker CLI

    - Using the provided ```docker-compose.yml``` in this repository:
```docker-compose up -d```

### Inject environment variables:
```docker run -d -p 8080:8080 -e JAVA_OPTS=-Xms256m -Xmx512m spring-boot-image```

## Using Docker Compose

The `docker-compose.yml` file picks its configuration from the `.env` one.

Using this file, you can set the desired properties:
```
# Docker
IMAGE_NAME=spring-boot-docker
HEALTHCHECK_CONTEXT=/

# Application
SERVER_PROTOCOL=http
SERVER_PORT=8080
DEBUG_PORT=8000
SPRING_PROFILES_ACTIVE=dev
DEBUG=false
# -Dprop=... -Dparameter=...
JAVA_OPTS=

# Host
HOST_SERVER_PORT=8080
HOST_DEBUG_PORT=8000
```

## Debug mode
To run the application in debug mode, simply set the `DEBUG` variable to true in the `.env` file.

Launch the application:
`docker-compose up -d`

By default, the debug port used is the `8000`.

## Spring profile(s)
By default, the application will run with `dev` Spring profile

To run the application with a specific Spring profile, set the desired one in the `.env` file:
```
SPRING_PROFILES_ACTIVE=dev
```
