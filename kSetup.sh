#!/bin/bash

action=$1

if [[ "$action" == "create" ]]; then
    echo "Creating namespaces and deploying services..."
    kubectl create ns kafka
    kubectl create ns order
    kubectl create ns inventory
    kubectl create ns payment
    
    kubectl apply -f kafka_zookeeper.yaml -n kafka
    kubectl apply -f order-service-kubernetes/ -n order
    kubectl apply -f inventory-service-kubernetes/ -n inventory
    kubectl apply -f payment-service-kubernetes/ -n payment
    
    elif [[ "$action" == "delete" ]]; then
    echo "Deleting all resources..."
    
    kubectl delete -f payment-service-kubernetes/ -n payment
    kubectl delete -f inventory-service-kubernetes/ -n inventory
    kubectl delete -f order-service-kubernetes/ -n order
    kubectl delete -f kafka_zookeeper.yaml -n kafka
    
    kubectl delete ns payment
    kubectl delete ns inventory
    kubectl delete ns order
    kubectl delete ns kafka
    
else
    echo "Usage: $0 [create|delete]"
    exit 1
fi
