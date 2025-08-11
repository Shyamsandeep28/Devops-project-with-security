FROM openjdk:17-jdk-slim
WORKDIR /app
COPY target/*.jar app.jar

# Create and switch to non-root user
RUN useradd -m appuser
USER appuser

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

