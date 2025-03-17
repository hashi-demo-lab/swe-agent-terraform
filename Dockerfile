FROM --platform=linux/amd64 composio/swe:py3.11

ENV DEBIAN_FRONTEND=noninteractive
ENV TERRAFORM_VERSION=1.11.2
ENV VAULT_VERSION=1.19.0

RUN sudo apt-get update \
&& sudo apt-get install -y unzip \
&& sudo apt-get install -y make \
&& sudo apt-get install -y jq \
&& sudo apt-get install -y wget \
&& sudo apt-get install -y git \
&& sudo apt-get install -y sudo \
&& sudo apt-get install -y coreutils

# # Install Vault
# RUN sudo wget --quiet "https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip" \
#     && sudo unzip vault_${VAULT_VERSION}_linux_amd64.zip \
#     && sudo mv vault /usr/local/bin \
#     && sudo rm vault_${VAULT_VERSION}_linux_amd64.zip

# Install Terraform
RUN sudo wget --quiet "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" \
    && sudo unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && sudo mv terraform /usr/local/bin \
    && sudo rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
