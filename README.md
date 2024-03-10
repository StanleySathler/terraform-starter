# terraform-starter

A starter repository for Terraform projects. It consists of:

1. Google Cloud Provider
2. 2 Cloud Run instances running Node.js APIs - Products and Cart
3. 1 API Gateway

All endpoints are prefixed with `/api` and are accessible via the API Gateway.

- Requests to `/product` are routed to the Products API
- Requests to `/cart` are routed to the Cart API

![image](https://github.com/StanleySathler/terraform-starter/assets/11931916/0def9ccf-8313-44ad-b7f2-a49ea360702f)

## For developers

### Prerequisites

- Docker & Docker Compose
- Node.js 20.x & npm 9.x
- Terraform 1.x

### Running all services

Ensure you're at the root folder.

```bash
# Ensure you're at the root folder - eg. my-apps/terraform-starter

$ docker-compose up # Start Kong
$ cd products-api && npm run start:local # Start Products API - Soon we'll move this to Docker Compose too
$ cd cart-api && npm run start:local # Start Cart API - Soon we'll move this to Docker Compose too
```

Once all services are running, open your browser and do:

```bash
GET http://localhost:8000/product
GET http://localhost:8000/cart
```

### Deploying new versions

> Before you apply Terraform, you may need to enable a few Google Cloud APIs, including Cloud Run Admin API, API Gateway API, etc.

First, ensure you have a Service Account key. Contact the administrator. Save it in the root folder as `service-account.json`.

```bash
# Ensure you're at the root folder.
cd terraform-starter

# Deploy (Build & Publish) the Docker images
$ ./scripts/deploy-image.sh

# Apply Terraform
$ terraform apply
```