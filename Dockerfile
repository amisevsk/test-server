# Build the binary
# https://access.redhat.com/containers/?tab=tags#/registry.access.redhat.com/ubi8/go-toolset
FROM registry.access.redhat.com/ubi8/go-toolset:1.17.7-13 as builder
ENV GOPATH=/go/
USER root
WORKDIR /test-server

# Copy the go source
COPY . .

RUN go mod download && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GO111MODULE=on go build \
  -a -o _output/bin/test-server \
  -gcflags all=-trimpath=/ \
  -asmflags all=-trimpath=/ \
  ./main.go

# Make a smaller image
FROM scratch
COPY --from=builder /test-server/_output/bin/test-server /usr/local/bin/test-server

ENTRYPOINT ["/usr/local/bin/test-server"]
