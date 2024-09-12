# creating jar from maven
FROM maven:3.8.3-openjdk-17-slim AS stage1
WORKDIR /home/app
COPY . /home/app
RUN mvn -f /home/app/pom.xml clean package -DskipTests

#Create docker image using jar

FROM openjdk:17-jdk-slim
# Create a non-root user 
RUN useradd -ms /bin/bash appuser
EXPOSE 8181
COPY --from=stage1 /home/app/target/studentcrud-0.0.1-SNAPSHOT.jar app.jar
# Change ownership of the JAR file to the non-root user
RUN chown -R appuser:appuser app.jar
# Switch to non-root user
USER appuser
# Start the application
ENTRYPOINT ["sh", "-c", "java -jar /app.jar"]
