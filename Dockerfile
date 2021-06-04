FROM golang:1.12-alpine AS builder
ARG VCS_REF
ARG BUILD_DATE
ARG VERSION
ARG USER_EMAIL="jack.crosnier@w6d.io"
ARG USER_NAME="Jack CROSNIER"
LABEL maintainer="${USER_NAME} <${USER_EMAIL}>" \
        org.label-schema.vcs-ref=$VCS_REF \
        org.label-schema.vcs-url="https://github.com/w6d-io/docker-trivy" \
        org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.version=$VERSION

RUN apk --no-cache add git upx
RUN mkdir -p /app/
RUN git clone --depth 1 --branch v0.18.3 https://github.com/aquasecurity/trivy /trivy
RUN mv /trivy/go.mod /app/go.mod
RUN mv /trivy/go.sum /app/go.sum
WORKDIR /app/
ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64
RUN go mod download
COPY . /app/
RUN mkdir -p /github.com/aquasecurity && cd /github.com/aquasecurity && git clone https://github.com/aquasecurity/trivy.git
RUN ls github.com/aquasecurity/trivy
RUN go build -ldflags "-X main.version=$(git describe --tags --abbrev=0)" -a -o /trivy /trivy/cmd/trivy/main.go
RUN upx --lzma --best /trivy

FROM alpine:3.10
RUN apk --no-cache add ca-certificates git rpm
COPY --from=builder /trivy /usr/local/bin/trivy

ENTRYPOINT ["trivy"]