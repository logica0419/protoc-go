FROM golang:1.17.7 AS builder
WORKDIR /protoc
RUN apt update && apt install jq unzip -y

RUN URI=$(curl -s https://api.github.com/repos/protocolbuffers/protobuf/releases | jq -r '.[0].assets[] | select(.name | test("linux-x86_64.zip")) | .browser_download_url') && \
  wget "$URI" -O "protobuf.zip"
RUN unzip -o protobuf.zip -d protobuf
RUN chmod -R 755 protobuf/*

RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
RUN go install github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc@latest

FROM golang:1.17.7 AS compiler

COPY --from=builder /protoc/protobuf/bin /usr/local/bin/
COPY --from=builder /protoc/protobuf/include /usr/local/include/
COPY --from=builder /go/bin/protoc-gen-go /usr/local/bin/
COPY --from=builder /go/bin/protoc-gen-go-grpc /usr/local/bin/
COPY --from=builder /go/bin/protoc-gen-doc /usr/local/bin/
