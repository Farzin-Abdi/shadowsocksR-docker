```markdown
# ShadowsocksR Docker Image

## Pull and Run from Docker Hub

```bash
docker pull farzinabdi/ssr_docker_img
docker run -d --restart always -p 443:443 --name ssr_docker farzinabdi/ssr_docker_img:latest
```

This will pull the pre-built image from Docker Hub and run the ShadowsocksR server in a Docker container. The container is named "ssr_docker" and is set to restart always.

## Build and Run Locally

```bash
docker build -t ssr_docker_img .
docker run -d --restart always -p 443:443 --name ssr_docker ssr_docker_img
```

If you prefer to build the Docker image locally, use the provided Dockerfile and then run the container with the same configuration as the pre-built image.

## Get SSR QR Code or Link

To obtain the SSR QR code or link, you can check the logs of the running container:

```bash
docker logs ssr_docker
```

Look for the output that includes the SSR link or QR code. This information includes the necessary connection details for your ShadowsocksR server.

## License

This project is licensed under the [MIT License](LICENSE).
```
