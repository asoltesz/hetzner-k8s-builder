#!/usr/bin/env bash
# ------------------------------------------------------------
#
# Creates or starts a local cluster for testing SolaKube features
#
# If it doesn't exist yet, it creates it.
# ------------------------------------------------------------

shift

# Docker based Minikube driver backend
minikube start \
    --kubernetes-version="v1.15.11" \
    --feature-gates="VolumeSnapshotDataSource=true" \
    --driver="docker" \
    $@


# When debugging is needed
# --alsologtostderr -v=5

# Deploy ingress
minikube addons enable ingress
minikube addons enable metrics-server
#minikube addons enable ingress-dns

minikube dashboard