# terraform-starter

A starter repository for Terraform + Google Cloud projects. It consists of:

- Google Cloud as provider;
- GCP Cloud Run running the APIs (Node.js + Fastify);
- GCP API Gateway;

- Requests to `api-gateway.example/product` are routed to the Products API
- Requests to `api-gateway.example/cart` are routed to the Cart API

![image](https://github.com/StanleySathler/terraform-starter/assets/11931916/0def9ccf-8313-44ad-b7f2-a49ea360702f)

## For developers

### Prerequisites

- Node.js 20.x & npm 9.x
- Terraform 1.x

For running each service, go to their respective folder.

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

Then, once all your changes have been applied, open:
- `https://api-gateway-aadbg2ri.uc.gateway.dev/product`
- `https://api-gateway-aadbg2ri.uc.gateway.dev/cart`
