#Docker image + Docker Compose file for Spring Boot applications

[![](https://badge.imagelayers.io/flopes/spring-boot-docker:latest.svg)](https://imagelayers.io/?images=flopes/spring-boot-docker:latest 'Get your own badge on imagelayers.io')

Features:
- Debug mode
- Spring profiles

https://hub.docker.com/r/flopes/spring-boot-docker/

## How to use ?

### Copy your Spring Boot executable jar
Put your application jar into the `assets` folder and rename it as follows: `spring-boot-application.jar`.

By default, this image will pick an executable jar named `spring-boot-app.jar` under the `assets` directory.

### Start container
`docker compose up -d`

You should now have your application running on port `8080` (default port configuration).

You can consult application logs by running this command:
`docker-compose logs`

#### Stop your application and remove container:
`docker-compose stop && docker-compose rm -f`


## Custom application name

To have the image use your application jar name, update `Dockerfile` as follows:
`ENV APP_JAR ${your_app_name.jar}`

Stop and remove container if it's started:
`docker-compose stop && docker-compose rm -f`

Rebuild the image and launch it:
`docker-compose build && docker-compose up -d`

## Custom ports
To change host ports, update the lines after `ports:` in `docker-compose.yml` file:
``` yaml 
ports:
   - "8080:8080"
   - "8000:8000"
   ```
   
For example, if you want to expose Spring Boot port (8080 by default) on the 80 (host):
``` yaml 
ports:
   - "80:8080"
   - "8000:8000"
   ```

If your Spring Boot application is configured to run on port 8081, update the configuration as follows:
``` yaml 
ports:
   - "80:8081"
   - "8000:8000"
   ```

## Debug mode
To run the application in debug mode, simply set the `DEBUG` environment variable to true in the `docker-compose.yml` file.

Launch the application:
`docker-compose up -d`

By default, the debug port used is the `8000`.

## Spring profile(s)
By default, the application will run with `dev` Spring profile

To run the application with a specific Spring profile, set the desired one in the `docker-compose.yml` file:
``` yaml
environment:
   - "SPRING_PROFILES_ACTIVE=dev"
   ```
