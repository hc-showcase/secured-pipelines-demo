#!/bin/sh

docker build -t mskaesz/secured-iac-pipelines-demo:latest docker-image/

docker push mskaesz/secured-iac-pipelines-demo:latest
