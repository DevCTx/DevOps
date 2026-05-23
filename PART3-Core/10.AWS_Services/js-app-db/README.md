# Demo App: Developing with Docker

This demo app shows a simple user profile application set up using:

- `index.html` with pure JavaScript and CSS styles
- Node.js backend using the Express module
- MongoDB for data storage

All components are Docker-based.

---

## Services and Ports

| Service         | Port |
|-----------------|------|
| MongoDB         | 27017|
| Mongo Express   | 8081 |
| Node.js App     | 3000 |

---

## Using Docker Compose

1. **Run all services** (MongoDB, Mongo Express, and Node.js app):

```bash
docker compose -f docker-compose.yaml up -d
```

2. **Check that all containers are running properly:**

```bash
docker compose ps
```

3. **Open Mongo Express in your browser:**

```
http://localhost:8081
```

- Login with: **user / pass** 
- Optionally, create a database named `user-account` and a collection `users`.

4. **Access the Node.js application UI in your browser:**

```
http://localhost:3000
```

5. **Stop all services:**

```bash
docker compose -f docker-compose.yaml down
```

- To remove volumes as well, add `-v`:

```bash
docker compose -f docker-compose.yaml down -v
```

> **Tip:** Docker Compose is recommended because it handles networks and volumes automatically.

---

## Using Docker CLI

1. **Create a Docker network:**

```bash
docker network create js-app-network
```

2. **Create Docker volumes for MongoDB and Mongo Express:**

```bash
docker volume create --name mongo-data
docker volume create --name mongo-express-data
```

3. **Start MongoDB:**

```bash
docker run -d \
  --name mongodb \
  --network js-app-network \
  -p 27017:27017 \
  -e MONGO_INITDB_ROOT_USERNAME=admin \
  -e MONGO_INITDB_ROOT_PASSWORD=password \
  -v mongo-data:/data/db \
  mongo:latest
```

4. **Start Mongo Express:**

```bash
docker run -d \
  --name mongo-express \
  --network js-app-network \
  -p 8081:8081 \
  -e ME_CONFIG_MONGODB_ADMINUSERNAME=admin \
  -e ME_CONFIG_MONGODB_ADMINPASSWORD=password \
  -e ME_CONFIG_BASICAUTH_USERNAME=user \
  -e ME_CONFIG_BASICAUTH_PASSWORD=pass \
  -e ME_CONFIG_MONGODB_SERVER=mongodb \
  -e ME_CONFIG_MONGODB_URL=mongodb://admin:password@mongodb:27017/ \
  -v mongo-express-data:/data/config \
  mongo-express:latest
```

5. **Open Mongo Express in your browser:**

```
http://localhost:8081
```

- Login with: **user / pass**  
- Optionally, create a database named `user-account` and a collection `users`.

6. **Build and run the Node.js application:**

```bash
docker build -t js-app-db:1.0 .
docker run -d \
  --name js-app-db \
  --network js-app-network \
  -p 3000:3000 \
  -e MONGO_DB_URL=mongodb://admin:password@mongodb:27017 \
  js-app-db:1.0
```

7. **Access the Node.js application UI in your browser:**

```
http://localhost:3000
```

8. **Stop and remove all containers, network, and volumes manually:**

```bash
docker stop js-app-db mongo-express mongodb
docker rm js-app-db mongo-express mongodb
docker network rm js-app-network
docker volume rm mongo-data mongo-express-data
docker rmi js-app-db:1.0 mongo-express:latest mongo:latest
```

> **Note:** Make sure to remove volumes only if you want to delete all data. MongoDB data is persistent in `mongo-data`.

