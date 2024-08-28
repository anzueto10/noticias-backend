FROM maven:3.8.6-openjdk-17 AS build

WORKDIR /app

COPY pom.xml ./
RUN mvn dependency:go-offline

COPY src ./src

RUN mvn package

FROM openjdk:17-jdk-alpine

COPY --from=build /app/target/ncargo-0.0.1-SNAPSHOT.jar /app/ncargo-0.0.1-SNAPSHOT.jar

WORKDIR /app

ENTRYPOINT ["java", "-jar", "ncargo-0.0.1-SNAPSHOT.jar"]
