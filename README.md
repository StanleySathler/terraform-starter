# terraform-starter

A starter repository for Terraform projects. It consists of:

1. Google Cloud Provider
2. 2 Cloud Run instances running Node.js APIs - Products and Cart
3. 1 API Gateway

All endpoints are prefixed with `/api` and are accessible via the API Gateway.

- Requests to `/product` are routed to the Products API
- Requests to `/cart` are routed to the Cart API

## For developers

### Prerequisites

- Docker & Docker Compose
- Node.js 20.x & npm 9.x

### Running all services

Ensure you're at the root folder.

```bash
# Ensure you're at the root folder - eg. my-apps/terraform-starter

$ docker-compose up # Start Kong
$ cd products-api && npm run start:local # Start Products API - Soon we'll move this to Docker Compose too
$ cd cart-api && npm run start:local # Start Cart API - Soon we'll move this to Docker Compose too
```
