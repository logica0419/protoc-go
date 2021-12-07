FROM golang:1.17.4 AS builder
WORKDIR /protoc
RUN apt update && apt install git make curl jq unzip -y

RUN URI=$(curl -s https://api.github.com/repos/protocolbuffers/protobuf/releases | jq -r '.[0].assets[] | select(.name | test("linux-x86_64.zip")) | .browser_download_url') && \
  wget "$URI" -O "protobuf.zip"
RUN unzip -o protobuf.zip -d protobuf
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest

FROM golang:1.17.4 AS compiler

COPY --from=builder /protoc/protobuf/bin /usr/local/bin/
COPY --from=builder /protoc/protobuf/include /usr/local/include/
COPY --from=builder /go/bin/protoc-gen-go /usr/local/bin/
