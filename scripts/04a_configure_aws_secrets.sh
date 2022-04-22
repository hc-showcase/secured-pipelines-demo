#!/bin/sh

. 99_source_temp_data.sh

cd 04a_configure_aws_secrets
terraform init
terraform apply
