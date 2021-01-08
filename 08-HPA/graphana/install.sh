#!/bin/bash

# This script will install the required dependencies in the cluster

## Install metric-server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# Install premeteus adapter
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus-community/prometheus --generate-name
helm install prometheus-community/prometheus-adapter --generate-name 

# Install graphana
kubectl create namespace monitoring

## Deploy Grafana Service in Kubernetes
kubectl create deployment grafana -n monitoring --image=docker.io/grafana/grafana:latest

## Expose Grafana Service using NodePort
kubectl -n monitoring expose deployment grafana --type="NodePort" --port 3000

# Verify that grapana install
kubectl describe service grafana -n monitoring