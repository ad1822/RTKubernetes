# 🐘 Order Processing System on Kubernetes

This project contains a fully containerized, Kubernetes-based **Order Processing System** composed of three microservices (`Order`, `Payment`, `Inventory`) backed by PostgreSQL and Kafka. It also includes observability via **Kafka UI** and **Dozzle**.

## 🧱 Architecture

![Diagram](image.png)

```mermaid
flowchart TB
    subgraph Monitoring_UI
        direction TB
        KafkaUI[Kafka UI NodePort:31008]
        Dozzle[Dozzle Logs NodePort:31007]
    end

    subgraph Kafka_Cluster
        direction TB
        Zookeeper[Zookeeper StatefulSet]
        Kafka[Kafka Broker StatefulSet]
        Kafka --> Zookeeper
    end

    subgraph Order_Service
        direction TB
        Order[Order Service Deployment]
        OrderDB[Order PostgreSQL StatefulSet]
        Order --> OrderDB
        Order -->|Publishes Events| Kafka
    end

    subgraph Payment_Service
        direction TB
        Payment[Payment Service Deployment]
        PaymentDB[Payment PostgreSQL StatefulSet]
        Payment --> PaymentDB
        Payment -->|Publishes Events| Kafka
    end

    subgraph Inventory_Service
        direction TB
        Inventory[Inventory Service Deployment]
        InventoryDB[Inventory PostgreSQL StatefulSet]
        Inventory --> InventoryDB
        Inventory -->|Publishes Events| Kafka
    end

    Monitoring_UI -->|Monitors| Kafka_Cluster
    Monitoring_UI -->|Views Logs| Order_Service
    Monitoring_UI -->|Views Logs| Payment_Service
    Monitoring_UI -->|Views Logs| Inventory_Service

    classDef ui fill:#cff,stroke:#333;
    classDef kafka fill:#f9f,stroke:#333;
    classDef service fill:#9f9,stroke:#333;
    classDef db fill:#ff9,stroke:#333;

    class Monitoring_UI,KafkaUI,Dozzle ui;
    class Kafka_Cluster,Kafka,Zookeeper kafka;
    class Order,Payment,Inventory service;
    class OrderDB,PaymentDB,InventoryDB db;

```

## ⚙️ Components

- **Kafka & Zookeeper**: Messaging backbone for the microservices.
- **Kafka UI**: Inspect topics, consumers, messages.
- **Dozzle**: Real-time log viewer for Kubernetes pods.
- **PostgreSQL**: Each service has its own database.

## 🛠️ Namespaces Used

- `order`
- `payment`
- `inventory`
- `kafka`

## 📊 Observability

- **Dozzle**: Streams logs across services.
- **Kafka UI**: Monitor Kafka health, topics, and message flow.
