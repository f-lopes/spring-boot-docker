# Lightweight Spring Boot Docker image based on Alpine + Docker Compose file

[![](https://images.microbadger.com/badges/image/flopes/spring-boot-docker.svg)](https://microbadger.com/images/flopes/spring-boot-docker "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/flopes/spring-boot-docker:1.0.svg)](https://microbadger.com/images/flopes/spring-boot-docker:1.0 "Get your own version badge on microbadger.com")
[![](https://img.shields.io/docker/pulls/flopes/spring-boot-docker.svg)](https://img.shields.io/docker/pulls/flopes/spring-boot-docker.svg)
[![](https://img.shields.io/docker/stars/flopes/spring-boot-docker.svg)](https://img.shields.io/docker/stars/flopes/spring-boot-docker.svg)

## Features:
- Uses lightweight openjdk:8-jre-alpine image
- Wrapper script that enables application to take PID 1 & receive SIGTERM signals ([see here](#pid-1))
- Starts Spring Boot as `spring-boot` user inside the container
- Custom JAVA_OPTS
- Health check (Docker tag `1.0-healthcheck` https://github.com/f-lopes/spring-boot-docker/tree/healthcheck)
- Debug mode

## Available environment variables

Name                    | Default   | Description
------------------------|-----------|------------------------------------
JAVA_OPTS               |       | JAVA_OPTS
DEBUG                   | false | Enable or disable debug mode
DEBUG_PORT              | 8000  | Debug port


## How to use ?

1. Simply extend your image from `flopes/spring-boot-docker` and set your application name as an environment variable:
    ``` Docker
    FROM flopes/spring-boot-docker:1.1
    ```

2. Copy your Spring Boot executable jar into an `assets` folder and build you image:
```docker build -t spring-boot-image . ```

3. Start your application:
    - Using Docker CLI ```docker run -d -p 8080:8080 spring-boot-image```

    - Using the provided ```docker-compose.yml``` in this repository:
```docker-compose up -d```

### Inject environment variables:
```docker run -d -p 8080:8080 -e JAVA_OPTS="-Xms256m -Xmx512m" spring-boot-image```

## Using Docker Compose

The `docker-compose.yml` file picks its configuration from the `.env` one.

Using this file, you can set the desired properties:
```
# Docker properties
IMAGE_NAME=spring-boot-docker

# Application properties
SERVER_PORT=8080
DEBUG_PORT=8000
SPRING_PROFILES_ACTIVE=dev
DEBUG=false
# -Dprop=... -Dparameter=...
JAVA_OPTS=

# Host properties
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

## PID 1
```bash
$ docker run -d --name spring-boot -p 8080:8080 spring-boot-extends
a5b3036136dffa34af0cdeff6153e87f9a20ba1cdc54c36fe9113b385bfb3264

lopes_f@lopes-f-laptop MINGW64 /d/WORK/git/docker-poc/docker (develop)
$ docker exec -it a5b3036136dffa34af0cdeff6153e87f9a20ba1cdc54c36fe9113b385bfb3264 sh
/app $ ps -ef
PID   USER     TIME   COMMAND
    1 spring-b   0:10 java -Djava.security.egd=file:/dev/./urandom -jar /app/spring-boot.jar
   23 spring-b   0:00 sh
   27 spring-b   0:00 ps -ef
/app $
```
