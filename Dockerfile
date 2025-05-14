FROM ubuntu:latest as build

RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    maven

WORKDIR /dr7

COPY pom.xml .

COPY . .

RUN mvn clean package

# Estágio de produção
FROM openjdk:17-jdk-slim

WORKDIR /Gateways

COPY --from=build /Gateways/target/Gateways-0.0.1-SNAPSHOT.jar Gateways.jar

ENV DATA_DIR=/var/lib/data
CMD ["java", "-jar", "Gateways.jar"]