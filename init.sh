#!/bin/bash
set -e

# Initialize the main repository and submodules
echo "Initializing the main repository and submodules..."
git submodule update --init --recursive

# Function to install npm dependencies in a directory
install_npm_dependencies() {
    if [ -d "$1" ]; then
        echo "Installing dependencies in $1..."
        cd "$1" && npm install
        cd - > /dev/null
    else
        echo "Directory $1 does not exist."
    fi
}


# Install dependencies for each specified submodule directory
echo "Installing dependencies for submodules..."
install_npm_dependencies "./emoji-reaction"
install_npm_dependencies "./emoji-full-stack/emoji-reaction-backend"

echo "Initialization and installation complete!"

# Function to check if a service is healthy
check_service_health() {
    local service=$1
    local max_attempts=30
    local attempt=1

    echo "Checking health of $service..."
    while [ $attempt -le $max_attempts ]; do
        if docker-compose ps $service | grep -q "Up"; then
            echo "$service is healthy"
            return 0
        fi
        echo "Waiting for $service to be healthy (attempt $attempt/$max_attempts)..."
        sleep 5
        attempt=$((attempt + 1))
    done
    echo "ERROR: $service failed to become healthy"
    return 1
}

# Cleanup
echo "Cleaning up existing containers and volumes..."
docker-compose down -v

# Build images
echo "Building containers..."
docker-compose build

# Start core services
echo "Starting Zookeeper..."
docker-compose up -d zookeeper
check_service_health zookeeper

echo "Starting Kafka..."
docker-compose up -d kafka
check_service_health kafka

echo "Starting MongoDB..."
docker-compose up -d mongodb
check_service_health mongodb

echo "Starting Kafka Connect..."
docker-compose up -d kafka-connect
check_service_health kafka-connect

echo "Starting application services..."
docker-compose up -d server client trend-consumer emoji-consumer

# Final health check
echo "Performing final health check..."
docker-compose ps

# Show consumer logs
echo "Showing trend consumer logs..."
docker-compose logs -f trend-consumer
