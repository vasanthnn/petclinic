FROM maven:3.9-eclipse-temurin-17 As build

WORKDIR /app

COPY pom.xml .

COPY src ./src

RUN  mvn clean package -DskipTests

#stage 2 creatin runtime environment
FROM eclipse-temurin:17-jre-alpine

COPY --from=build  /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]



