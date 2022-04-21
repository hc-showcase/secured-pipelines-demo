#!/bin/sh

cd 01_setup_vault
#terraform destroy
rm -rf temp_data
cd -

cd 02_setup_gitlab
terraform destroy
rm -rf temp_data
cd -

cd 03_setup_tfc
terraform destroy
rm -rf temp_data
cd -


