#!/bin/bash
echo Starting Container
docker compose up -d

# Get container ID
CONTAINER_ID=""

# Wait until the container ID is available
while [ -z "$CONTAINER_ID" ]; do
    echo Waiting
    CONTAINER_ID=$(docker compose ps -q ardupilot)
    sleep 1
done

# Wait until the container is running
while [ "$(docker inspect -f '{{.State.Running}}' "$CONTAINER_ID")" != "true" ]; do
    echo Waiting.
    sleep 1
done

echo Opening Session
docker compose exec ardupilot bash

echo Stopping Container
docker compose down
