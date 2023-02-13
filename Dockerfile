FROM gradle:7.4 as builder
WORKDIR /app
COPY . /app
RUN gradle bootWar

FROM tomcat:latest

COPY --from=builder /app/core-api/build/libs/core-api-1.0.0.war /usr/local/tomcat/webapps/core-api.war
COPY --from=builder /app/users-api/build/libs/users-api-1.0.0.war /usr/local/tomcat/webapps/users-api.war

CMD ["catalina.sh", "run"]

