# ecs-fargate-platform
Gatus Monitoring Platform on AWS

## Running Locally

### Not in Docker

**Prerequisites**

- [Go](https://golang.org/dl/) 1.26 or higher
- Git (to initialise the submodule)

To verify your Go version:

```bash
go version
```

**Setup**

If you have just cloned this repo, initialise the submodule first:

```bash
git submodule update --init
```

**Run the application**

```bash
cd gatus
make run
```

The application will be available at `http://localhost:8080`.

On first run, Go will download the required dependencies automatically. This may take a minute.

**Verify the application is running**

Once the application is running, confirm it is healthy by running the following command in a separate terminal:

```bash
curl http://localhost:8080/health
```

You should see the following response:

```json
{"status":"UP"}
```

![Health check](images/healthcheck-nodocker.png)

**Configuration**

The application is configured via `gatus/config.yaml`. Edit this file to add or change the endpoints you want to monitor.

**Stopping the application**

Press `Ctrl + C` in the terminal where the application is running.

---

### In Docker

**Prerequisites**

- [Docker](https://docs.docker.com/get-docker/) installed and running

**Build the image**

Run this from the repo root:

```bash
docker build -f docker/gatus/dockerfile -t gatus:local ./gatus
```

**Run the application**

```bash
docker run -d -p 8080:8080 --name gatus gatus:local
```

The application will be available at `http://localhost:8080`.

**Verify the application is running**

Once the container has started, confirm it is healthy by running the following command:

```bash
curl http://localhost:8080/health
```

You should see the following response:

```json
{"status":"UP"}
```

To check the container is running and view recent logs:

```bash
docker ps --filter name=gatus
docker logs gatus
```

**Stopping the application**

```bash
docker stop gatus
```

To start it again without rebuilding:

```bash
docker start gatus
```
