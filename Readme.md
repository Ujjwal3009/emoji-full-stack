# Emoji Reaction Full Stack Application

A full-stack application demonstrating emoji reactions system with a modern tech stack. This project consists of a frontend application for emoji interactions and a backend service to handle the business logic.

## 🌟 Features

- Real-time emoji reactions
- Modern and responsive UI
- RESTful API backend
- Docker containerization
- Easy setup with initialization script

## 🏗️ Project Structure

The project is organized into the following key directories:

- `emoji-reaction`: Frontend application
- `emoji-reaction-backend`: Backend service

├── init.sh                  # Initialization script
├── docker-compose.yml       # Docker Compose configuration
├── emoji-reaction/         # Frontend application
├── emoji-reaction-backend/ # Backend service

## 🚀 Getting Started

### Prerequisites

- Git
- Node.js (v14 or higher)
- npm (v6 or higher)
- Docker and Docker Compose (for containerized deployment)

### Initial Setup

1. Clone the repository with submodules:


cd emoji-full-stack

chmod +x init.sh

./init.sh


2. Start the application:

docker-compose up --build


-- Done

1. **WebSocket Integration**:
   - Implemented a WebSocket server using Socket.IO to handle real-time emoji events.
   - Created a `WebSocketHandler` class to manage Kafka message production.
   - Updated the event listener to handle `sendEmoji` events, allowing clients to send emoji reactions.

2. **Kafka Producer Setup**:
   - Integrated Kafka using the `kafkajs` library to produce messages.
   - Configured the Kafka producer to batch messages and send them to the `emoji-events` topic.
   - Implemented message queuing with a flush mechanism to optimize network usage.

3. **MongoDB Archival**:
   - Set up a Kafka Connect MongoDB sink connector to archive emoji events from Kafka to MongoDB.
   - Created a configuration file for the MongoDB sink connector to specify connection details and data handling.

4. **Docker Compose Configuration**:
   - Updated the `docker-compose.yml` file to include Kafka, Zookeeper, MongoDB, and Kafka Connect services.
   - Configured the Kafka service to allow connections from both internal and external clients.
   - Ensured that the Kafka Connect service automatically installs the MongoDB connector and initializes it upon startup.

5. **Debugging and Logging**:
   - Added extensive logging throughout the WebSocket and Kafka integration to track the flow of data and identify issues.
   - Implemented health checks and status monitoring for the Kafka Connect service to ensure proper operation.

6. **Testing and Verification**:
   - Verified the flow of emoji events from the WebSocket server to Kafka and subsequently to MongoDB.
   - Used command-line tools to check the status of Kafka topics and MongoDB collections to ensure data integrity.

### Future Considerations
- Consider implementing error handling and retry mechanisms for failed Kafka message deliveries.
- Explore adding unit tests for the WebSocket and Kafka integration to ensure reliability.
- Document the API endpoints and WebSocket events for better developer experience.

# Clean up
docker-compose down -v

# Create logs directory
mkdir -p emoji-reaction-backend/logs

# Build and start services
docker-compose build
docker-compose up -d

# Monitor logs
docker-compose logs -f trend-consumer

# Check MongoDB data
docker exec -it emoji-full-stack-mongodb-1 mongosh
> use emoji-reactions
> db.emoji-events.find()




