# Echoserver

This is a fork of the enigmatic `k8s.gcr.io/echoserver` image, designed to run on both amd64 and arm64 architectures.

## Introduction

The `k8s.gcr.io/echoserver` image is very useful but unfortunately it isn't available for [arm64 architecture](https://github.com/kubernetes-retired/contrib/issues/2991) and we couldn't find the source code online. So, to solve this problem, we dug into the container image files, copied the nginx config and used it to created this fork. Currently, this version runs on amd64 and arm64 architectures but it should be easy to support more architectures if necessary.

Echoserver uses a lua script running inside Nginx to respond to HTTP requests on port 8080 and HTTPS requests on port 8443. On start-up, it creates a self-signed certificate for the ssl listener. When you send an http request to echoserver, it responds with details about the request such as host name, request args and http headers.

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
        image: kubetail/echoserver:0.1.1
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
