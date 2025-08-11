FROM openjdk:17-jdk-slim
copy target/devops.war webapps/

# Create and switch to non-root user
RUN useradd -m appuser
USER appuser

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar","devops.war"]

