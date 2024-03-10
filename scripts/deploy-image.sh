#!/bin/bash

# Check if service_name argument is provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <service_name> <tag>"
    exit 1
fi

service_name="$1"
tag="$2"

# Build Docker image ---- docker build -t <image-name> -f <dockerfile-path> <context-path>
echo "[+] Building image..."
docker build -t stanleysathler/terraform-starter-$service_name:$tag -f $service_name/docker/Dockerfile $service_name # Note the image must contain our Docker username must be in this format

# Publish Docker image
echo "[+] Publishing image..."
docker push stanleysathler/terraform-starter-$service_name:$tag # Note the image must contain our Docker username and must be in this format

# Publishing a `latest` alias
echo "[+] Publishing latest alias..."
docker tag stanleysathler/terraform-starter-$service_name:$tag stanleysathler/terraform-starter-$service_name:latest
docker push stanleysathler/terraform-starter-$service_name:latest