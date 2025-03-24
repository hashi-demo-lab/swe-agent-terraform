FROM --platform=linux/amd64 composio/swe:py3.11

ENV DEBIAN_FRONTEND=noninteractive
ENV TERRAFORM_VERSION=1.11.2
ENV TERRAFORM_LS_VERSION=0.36.4

RUN apt-get update && apt-get install -y \
    unzip \
    make \
    jq \
    wget \
    git \
    coreutils \
    && rm -rf /var/lib/apt/lists/*

# Install Terraform
RUN wget --quiet "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && mv terraform /usr/local/bin \
    && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Install terraform-ls (Language Server)
RUN wget --quiet "https://github.com/hashicorp/terraform-ls/releases/download/v${TERRAFORM_LS_VERSION}/terraform-ls_${TERRAFORM_LS_VERSION}_linux_amd64.zip" \
    && unzip terraform-ls_${TERRAFORM_LS_VERSION}_linux_amd64.zip \
    && mv terraform-ls /usr/local/bin/ \
    && rm terraform-ls_${TERRAFORM_LS_VERSION}_linux_amd64.zip \
    && chmod +x /usr/local/bin/terraform-ls
