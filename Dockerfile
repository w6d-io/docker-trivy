FROM alpine:3.13
ARG VCS_REF
ARG BUILD_DATE
ARG VERSION
ARG USER_EMAIL="jack.crosnier@w6d.io"
ARG USER_NAME="Jack CROSNIER"
LABEL maintainer="${USER_NAME} <${USER_EMAIL}>" \
        org.label-schema.vcs-ref=$VCS_REF \
        org.label-schema.vcs-url="https://github.com/w6d-io/docker-owaspzap" \
        org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.version=$VERSION

RUN apk --no-cache add ca-certificates git
RUN cd trivy/cmd/trivy/ && \
export GO111MODULE=on && \
go install
COPY trivy /usr/local/bin/trivy
COPY contrib/*.tpl contrib/
ENTRYPOINT ["trivy"]
