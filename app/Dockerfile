FROM openjdk
WORKDIR /app
COPY target/. .
COPY ./application.properties ./application.properties
COPY ./entrypoint.sh ./entrypoint.sh
ENTRYPOINT [ "./entrypoint.sh" ]
#java -jar embedash-1.1-SNAPSHOT.jar --spring.config.location=./application.properties 