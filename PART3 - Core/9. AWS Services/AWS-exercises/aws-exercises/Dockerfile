# Stage 1: build
FROM node:20-alpine AS builder
WORKDIR /opt/app
COPY ./app/package*.json ./
RUN npm ci
COPY ./app/ .
RUN npm test

# Stage 2: runtime
FROM node:20-alpine
WORKDIR /opt/app
COPY --from=builder ./app/node_modules ./node_modules
COPY --from=builder ./app/server.js ./
COPY --from=builder ./app/index.html ./
COPY --from=builder ./app/images ./images
EXPOSE 3000
CMD ["node", "server.js"]
