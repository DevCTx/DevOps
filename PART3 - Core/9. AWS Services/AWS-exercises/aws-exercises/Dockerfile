FROM node:20-alpine AS builder
WORKDIR /opt/app
COPY ./app/package*.json ./
RUN npm ci
COPY ./app/ .
RUN npm test

FROM node:20-alpine
WORKDIR /opt/app
COPY --from=builder /opt/app ./
EXPOSE 3000
CMD ["node", "server.js"]
