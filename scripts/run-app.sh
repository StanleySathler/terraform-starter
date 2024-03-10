#!/bin/bash

# Check if service_name argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <service_name>"
    exit 1
fi

service_name="$1"

# Build Docker image. 
docker build \
  -t stanleysathler/terraform-starter-$service_name:dev \
  -f $service_name/docker/Dockerfile \
  $service_name

# Remove previous container
docker rm -f terraform-starter-$service_name || true

# Run container with that image
docker run \
  -p 3000:8080 \
  -e PORT=8080 \
  --name terraform-starter-$service_name \
  stanleysathler/terraform-starter-$service_name:dev