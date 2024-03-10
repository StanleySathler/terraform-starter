#!/bin/bash

# Check if service_name argument is provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <service_name> <tag>"
    exit 1
fi

service_name="$1"
tag="$2"

# Setup buildx 
docker buildx create --name terraform-starter-builder --bootstrap --use

# Build Docker image. 
# Docker Buildx, as we need multi-platform builds - we're building from MacOS (arm64) but for Cloud Run (amd64)
docker buildx build \
    --push \
    --platform linux/amd64,linux/arm64 \
    --tag stanleysathler/terraform-starter-$service_name:$tag \
    --tag stanleysathler/terraform-starter-$service_name:latest \
    --file $service_name/docker/Dockerfile \
    $service_name