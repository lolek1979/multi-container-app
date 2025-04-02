#!/bin/bash

ACTION=${1:-build}
VERSION=${2:-1.0.0}

act -j k8s \
  -e <(echo "{\"inputs\":{\"action\":\"$ACTION\",\"version\":\"$VERSION\"}}") \
  --container-options "-v $HOME/.kube:/root/.kube"