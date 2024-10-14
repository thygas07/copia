FROM ubuntu:latest AS build

ARG DATABASE_USERNAME
ARG DATABASE_PASSWORD
ARG DATABASE_URL

RUN apt-get update
RUN apt-get install openjdk-17-jdk -y
COPY . .

RUN apt-get install maven -y
RUN mvn clean install

FROM openjdk:17-jdk-slim

EXPOSE 8080

COPY --from=build target/codeplac-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT [ "java", "-jar", "app.jar" ]