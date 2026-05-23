FROM eclipse-temurin:17

RUN groupadd -r javauser && useradd -r -g javauser javauser

RUN mkdir -p /home/myapp

WORKDIR /home/myapp

COPY ./build/libs/docker-exercises-project-1.0-SNAPSHOT.jar js-app.jar

RUN chown -R javauser:javauser /home/myapp

USER javauser

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "js-app.jar"]
