FROM ubuntu:24.04
LABEL maintainer="Krzysztof Królikowski <kkrolikowski@gmail.com>"
LABEL description="Docker image for a basic Ubuntu setup with IAC tools"
LABEL version="1.0"

ENV DEBIAN_FRONTEND="noninteractive"
ENV TERRAGRUNT_VERSION="v0.77.22"
ENV TF_VERSION="1.11.4"
ENV ARCH="amd64"
ENV OS="linux"
ENV BINARY_NAME="terragrunt_${OS}_${ARCH}"
ENV PATH="$PATH:/root/.local/bin"

RUN apt-get update && \
    apt-get install -y \
    git \
    curl \
    jq \
    unzip \
    pipx \
    python3-requests \
    python3-tz && \
    rm -rf /var/lib/apt/lists/*
RUN curl -L "https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/${BINARY_NAME}" -o "${BINARY_NAME}" && \
    chmod +x "${BINARY_NAME}" && \
    mv "${BINARY_NAME}" /usr/local/bin/terragrunt
RUN curl -L "https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_${OS}_${ARCH}.zip" -o terraform.zip && \
    unzip terraform.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform.zip && \
    chmod +x /usr/local/bin/terraform
RUN pipx install --include-deps ansible && \
    pipx inject ansible requests
