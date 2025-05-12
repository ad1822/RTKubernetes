#!/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
kubectl create namespace kafka
helm install kafka bitnami/kafka --namespace kafka
kubectl get pods -n kafka
kubectl get svc -n kafka