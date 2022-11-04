FROM openjdk:20
COPY ./target/watsonmm-1.10.1-SNAPSHOT.jar /usr/local/lib/my-app.jar
EXPOSE 9347
ENTRYPOINT ["java","-jar","/usr/local/lib/my-app.jar"]