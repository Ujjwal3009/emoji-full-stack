#!/bin/bash

echo "Waiting for Kafka Connect to start..."
while ! curl -s kafka-connect:8083/connectors > /dev/null; do
    sleep 1
done

echo "Creating MongoDB Sink Connector..."
curl -X POST \
  -H "Content-Type: application/json" \
  --data @/etc/kafka-connect/conf.d/mongodb-sink.json \
  http://kafka-connect:8083/connectors

echo "Done!" 