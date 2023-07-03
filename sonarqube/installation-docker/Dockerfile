# Use Ubuntu 20 as the base image
FROM ubuntu:20.04

# Update the package repository and install necessary dependencies
RUN apt-get update && apt-get install -y wget openjdk-11-jdk unzip curl nano

# Create a dedicated user for Elasticsearch
RUN useradd -m vishalk17

# Download and install SonarQube
RUN wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.0.43852.zip \
    && unzip sonarqube-8.9.0.43852.zip \
    && mv sonarqube-8.9.0.43852 /opt/sonarqube \
    && rm sonarqube-8.9.0.43852.zip

# Set ownership and permissions for SonarQube directories
RUN chown -R vishalk17:vishalk17 /opt/sonarqube

# Expose the SonarQube port
EXPOSE 9000

# Set the environment variables for SonarQube
ENV SONAR_HOME=/opt/sonarqube
ENV PATH=$PATH:/opt/sonarqube/bin/linux-x86-64

# Switch to the vishalk17 user
USER vishalk17

# Start SonarQube
CMD ["./sonar.sh", "console"]
