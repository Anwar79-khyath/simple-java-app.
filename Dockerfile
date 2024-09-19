# Use a Maven image to build the app
FROM maven:3.8.4-jdk-8 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# Use a JRE image to run the app
FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/simple-java-app-1.0-SNAPSHOT.jar ./app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]