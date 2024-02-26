# terraform-starter-products-api

## Development

Pre-requisites

```bash
npm ci
```

Available commands:

```bash
npm run start:local # Start the server locally
npm run test # Run tests
```

## Building

```bash
docker build -t terraform-starter-products-api -f ./docker/Dockerfile . # Build a Docker image
docker run -d -p 3001:3001 --name terraform-starter-products-api terraform-starter-products-api # Run the Docker container
```