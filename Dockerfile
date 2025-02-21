# Use Eclipse Temurin Java 21 on Alpine as the base image
FROM eclipse-temurin:21-jre-alpine

# Set working directory
WORKDIR /app

# Download Metabase v0.53.3.3 (latest as per your compose file)
ADD https://downloads.metabase.com/v0.53.3.3/metabase.jar /app/metabase.jar

# Set permissions
RUN chmod +x /app/metabase.jar

# Expose Metabase port
EXPOSE 3000

# Define Metabase environment variables
ENV MB_DB_TYPE=postgres \
    MB_DB_DBNAME=metabaseappdb \
    MB_DB_PORT=5432 \
    MB_DB_USER=metabase \
    MB_DB_PASS=mysecretpassword \
    MB_DB_HOST=postgres

# Healthcheck script
HEALTHCHECK --interval=15s --timeout=5s --retries=5 CMD curl --fail -I http://localhost:3000/api/health || exit 1

# Run Metabase
CMD ["java", "-jar", "/app/metabase.jar"]
