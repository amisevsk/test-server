# Simple test server

This repo contains a barebones server, originally built to test networking on Kubernetes and OpenShift. By default, it listens on port 8080 and responds with the message
```
Hello!
Listening on port 8080
```

The port the server listens on can be configured using the `--port` argument, and the message can be configured using the `--message` argument.

To build the a container image containing the server, use
```
podman build -t <tag> .
```

Builds are pushed to `quay.io/amisevsk/test-server:latest`
