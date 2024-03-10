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

> You may need to manually enable a few GCP APIs, including Cloud Run Admin API, API Gateway API, etc, as we're not managing these on Terraform yet.

First, ensure you have a Service Account key. Contact the administrator. Save it to `terraform/gcp-service-account.json`.

```bash
# 1. Ensure you're at the root folder.
cd terraform-starter

# 2. Deploy (Build & Publish) the Docker images
$ ./scripts/deploy-image.sh carts-api 1.0.1

# 3. Change your Terraform image, so it points to the image tag you just published
# TODO: Get rid of this manual step, and deploy a new revision from CI on every new tag.
containers {
  image = "docker.io/stanleysathler/terraform-starter-carts-api:1.0.1"
  ...
}

# 4. Apply Terraform
$ terraform -chdir=./terraform apply
```