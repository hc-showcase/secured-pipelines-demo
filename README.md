# secured-pipelines-demo

Execute the following command to setup up everything:
```
bash 00_check_prerequisites.sh tf

bash 01_setup_vault.sh tf

bash 02_setup_gitlab.com.sh tf

bash 03_setup_tfc.sh tf
```
For AWS:
```
bash 04a_configure_aws_secrets.sh tf
```

For Azure:
```
bash 04b_configure_azure_secrets.sh tf
```

```
bash 05_configure_vault_tfc_secrets.sh tf

bash 06_configure_vault_gitlab_jwt_auth.sh tf
```

Deploy multiple example projects:
```
bash 08_onboarding_projects.sh on project_name
```

Cleanup onboarding example projects:
```
bash 08_onboarding_projects.sh off project_name
```

Build and upload Docker image for Gitlab pipelines:
```
bash 30_build_and_publish_docker_image.sh
```
