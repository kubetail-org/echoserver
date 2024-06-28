# Echoserver

This is a fork of the enigmatic `k8s.gcr.io/echoserver`, designed to run on both amd64 and arm64 architectures.

## Introduction

The `k8s.gcr.io/echoserver` image is very useful but unfortunately it isn't available for [arm64 architecture](https://github.com/kubernetes-retired/contrib/issues/2991) and we couldn't find the source code online. So, to solve these problems, we dug into the image files, copied the nginx config and created this fork to make an `echoserver` that's more transparent and available across more architectures.

Echoserver, uses a lua script running inside Nginx to respond to HTTP requests on port 8080 and HTTPS requests on port 8443. On start-up, it creates a self-signed certificate for the ssl listener.

## Install

Here's a manifest you can use to run an echoserver deployment on kubernetes:

```yaml
kind: Deployment
apiVersion: apps/v1
metadata:
  name: echoserver
  namespace: default
  labels:
    app.kubernetes.io/name: echoserver
spec:
  selector:
    matchLabels:
      app.kubernetes.io/name: echoserver
  replicas: 3
  revisionHistoryLimit: 5
  template:
    metadata:
      labels:
        app.kubernetes.io/name: echoserver
    spec:
      containers:
      - name: echoserver
        image: kubetail/echoserver:0.0.1
        ports:
        - name: http
          containerPort: 8080
        - name: https
          containerPort: 8443
```

## Build

```console
docker build -t echoserver:latest .
```
