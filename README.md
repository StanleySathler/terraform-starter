# terraform-starter

A starter repository for Terraform projects. It consists of:

1. Google Cloud Provider
2. 2 Cloud Run instances running Node.js APIs - Products and Cart
3. 1 API Gateway

All endpoints are prefixed with `/api` and are accessible via the API Gateway.

- Requests to `/product` are routed to the Products API
- Requests to `/cart` are routed to the Cart API
