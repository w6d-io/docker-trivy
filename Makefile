
IMG ?= w6dio/docker-trivy:latest


REF=$(shell git symbolic-ref --quiet HEAD 2> /dev/null)
VERSION=$(shell basename $(REF) )
VCS_REF=$(shell git rev-parse HEAD)
BUILD_DATE=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ")

all: build push

# Build the docker image
build:
	docker build  --build-arg=VERSION=${VERSION} --build-arg=VCS_REF=${VCS_REF} --build-arg=BUILD_DATE=${BUILD_DATE}  -t ${IMG} .

# Push the docker image
push:
	docker push ${IMG}

