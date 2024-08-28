FROM openjdk:17-jdk-alpine

COPY target/ncargo-0.0.1-SNAPSHOT.jar /app/ncargo-0.0.1-SNAPSHOT.jar

WORKDIR /app

EXPOSE 8080

CMD ["java", "-jar", "ncargo-0.0.1-SNAPSHOT.jar"]
