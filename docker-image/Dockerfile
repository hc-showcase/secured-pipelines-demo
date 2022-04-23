FROM ubuntu:latest

RUN apt-get update -y && apt-get install -y unzip curl wget tree jq

RUN echo "Download tfe-cli" && curl -L https://github.com/rgreinho/tfe-cli/releases/download/1.6.0/tfe-cli-1.6.0-linux-amd64 > /usr/local/bin/tfe-cli && chmod +x /usr/local/bin/tfe-cli

RUN echo "Download Vault" && curl -L https://releases.hashicorp.com/vault/1.10.0/vault_1.10.0_linux_amd64.zip > vault.zip && unzip vault.zip -d /usr/local/bin/ && chmod +x /usr/local/bin/vault

RUN echo "Download Teraform" && curl -L https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_linux_amd64.zip > terraform.zip && unzip terraform.zip -d /usr/local/bin && chmod +x /usr/local/bin/terraform
