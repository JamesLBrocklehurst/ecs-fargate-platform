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
{"status":"ok"}
```

![Health check](images/healthcheck-nodocker.png)

**Configuration**

The application is configured via `gatus/config.yaml`. Edit this file to add or change the endpoints you want to monitor.

**Stopping the application**

Press `Ctrl + C` in the terminal where the application is running.
