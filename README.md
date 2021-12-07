# protoc-go

[![CI Pipeline](https://github.com/logica0419/protoc-go/actions/workflows/CI.yml/badge.svg)](https://github.com/logica0419/protoc-go/actions/workflows/CI.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/logica0419/protoc-go?logo=docker)](https://hub.docker.com/r/logica0419/protoc-go/)

Protobuf & Go Compiling Environment on Docker

## Usage

### Pull

```sh
docker pull logica0419/protoc-go
```

### In Dockerfile (as a Builder)

```docker
FROM logica0419/protoc-go:latest AS builder

# Copying some code

RUN protoc -I . --go_out=protobuf ./**/*.proto
RUN go build
```
