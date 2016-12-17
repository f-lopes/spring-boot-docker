#Docker image + Docker Compose file for Spring Boot applications

[![](https://images.microbadger.com/badges/image/flopes/spring-boot-docker.svg)](https://microbadger.com/images/flopes/spring-boot-docker "Get your own image badge on microbadger.com")

[![](http://dockeri.co/image/flopes/spring-boot-docker)](http://dockeri.co/image/flopes/spring-boot-docker 'Docker build status')

Features:
- Debug mode
- Spring profiles
- Custom JAVA_OPTS
- Health check (Docker tag `1.0-healthcheck` https://github.com/f-lopes/spring-boot-docker/tree/healthcheck)

## Available environment variables

Name                    | Default   | Description
------------------------|-----------|------------------------------------
DEBUG                   | false | Enable or disable debug mode
DEBUG_PORT              | 8000  | Debug port
SPRING_PROFILES_ACTIVE  | dev   | Active Spring profiles
JAVA_OPTS               |       | JAVA_OPTS

## How to use ?

1. Simply extend your image from `flopes/spring-boot-docker` and set your application name as an environment variable:
    ``` Docker
    FROM flopes/spring-boot-docker
    
    ENV ARTIFACT_NAME my-spring-boot-application.jar
    ```

2. Copy your Spring Boot executable jar into an `assets` folder and build you image:
```docker build -t my-spring-boot-application . ```

3. Start your application:
    - Using Docker CLI
```docker run -d -p 8080:8080 my-spring-boot-application```
    - Using the provided ```docker-compose.yml``` in this repository:
```docker-compose up -d```


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
