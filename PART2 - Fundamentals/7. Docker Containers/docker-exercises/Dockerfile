FROM eclipse-temurin:17

RUN mkdir -p /home/myapp

WORKDIR /home/myapp

COPY ./build/libs/docker-exercises-project-1.0-SNAPSHOT.jar js-app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "js-app.jar"]
