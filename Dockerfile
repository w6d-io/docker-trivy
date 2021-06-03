FROM w6dio/docker-bash
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

ENV DESIRED_VERSION $DESIRED_VERSION
RUN mkdir -p $PWD/src/github.com/aquasecurity
RUN git clone --depth 1 --branch v0.18.3 https://github.com/aquasecurity/trivy $PWD/src/github.com/aquasecurity
RUN cd $PWD/src/github.com/aquasecurity/trivy/cmd/trivy/ && export GO111MODULE=on
RUN cd $PWD/src/github.com/aquasecurity/trivy/cmd/trivy/ && go install
