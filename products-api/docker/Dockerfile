FROM node:20-alpine3.18

# TODO: use multi-stage builds for better image sizes

WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
EXPOSE 3001
CMD ["npm", "run", "start:local"]