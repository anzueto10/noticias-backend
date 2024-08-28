# Usa una imagen base de OpenJDK para construir la aplicación
FROM openjdk:17-jdk-alpine AS build

# Instala Maven
RUN apk add --no-cache maven

# Configura el directorio de trabajo
WORKDIR /app

# Copia el archivo pom.xml y descarga las dependencias
COPY pom.xml ./
RUN mvn dependency:go-offline

# Copia el código fuente
COPY src ./src

# Ejecuta Maven para construir el proyecto
RUN mvn package

# Usa una imagen base de OpenJDK para ejecutar la aplicación
FROM openjdk:17-jdk-alpine

# Copia el JAR construido desde el contenedor de construcción
COPY --from=build /app/target/ncargo-0.0.1-SNAPSHOT.jar /app/ncargo-0.0.1-SNAPSHOT.jar

# Configura el directorio de trabajo
WORKDIR /app

# Comando para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "ncargo-0.0.1-SNAPSHOT.jar"]
