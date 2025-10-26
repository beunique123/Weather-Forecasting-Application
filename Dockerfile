# Start with a base image that has Java 11 installed (as your app requires it)
FROM openjdk:11-jdk-slim

# Set the working directory for the application
WORKDIR /app

# Copy the packaged JAR file from the Maven target directory into the container
# NOTE: This assumes you ran 'mvn clean package' right before committing/pushing
COPY target/weather-app-0.0.1-SNAPSHOT.jar app.jar

# Define the entrypoint command to run the JAR file
# This is the same command you used to start it in the terminal
ENTRYPOINT ["java", "-jar", "app.jar"]

# The default port for Spring Boot
EXPOSE 8080