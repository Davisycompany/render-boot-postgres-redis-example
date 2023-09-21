
# FROM maven:3.9.2-eclipse-temurin-11-alpine as builder

# COPY ./src src/
# COPY ./pom.xml pom.xml

# RUN mvn clean package -DskipTests

# FROM eclipse-temurin:11-jre-alpine
# COPY ./target/spring-boot-docker.war spring-boot-docker.war
# EXPOSE 8080

# ARG REDIS_HOST
# ARG REDIS_PORT
# CMD ["java","-jar","/spring-boot-docker.war"]

# FROM openjdk:8
# EXPOSE 8080
# ADD target/spring-boot-docker.jar spring-boot-docker.jar 
# # ARG REDIS_HOST
# # ARG REDIS_PORT
# ENTRYPOINT ["java","-jar","/spring-boot-docker.jar"]

FROM maven:3.9.2-eclipse-temurin-11-alpine as builder

# COPY ./src src/
# COPY ./pom.xml pom.xml
COPY . .

RUN mvn clean package -DskipTests

FROM eclipse-temurin:11-jre-alpine
COPY --from=builder target/demo-0.0.1-SNAPSHOT.jar demo-0.0.1-SNAPSHOT.jar
EXPOSE 8080
ARG REDIS_HOST
ARG REDIS_PORT
CMD ["java","-jar","./demo-0.0.1-SNAPSHOT.jar"]

