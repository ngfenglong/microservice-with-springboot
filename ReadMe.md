# Spring Boot Microservices System

This is a microservices-based project built using Spring Boot, demonstrating key concepts such as service discovery, centralized configuration, API gateway routing, inter-service communication, containerization with Docker, and orchestration using Kubernetes.

## Overview

The system consists of several independently deployable microservices:

- **Config Server** – Centralized configuration management.
- **Eureka Server** – Service discovery.
- **Gateway Server** – API Gateway for routing external traffic to internal services.
- **Accounts, Loans, Cards Services** – Domain-specific services handling different aspects of user data.
- **Message Service** – Supports message handling between services.
- **Keycloak Integration** – Authentication and authorization using Keycloak.
- **Common Library** – Shared DTOs and utilities.

## Features

- Spring Boot microservices architecture
- RESTful API design
- Config Server with centralized config management
- Eureka service registry for dynamic service discovery
- Spring Cloud Gateway as API gateway
- Feign Clients for inter-service communication
- Dockerized services with `jib` plugin
- Kubernetes deployment-ready YAMLs
- Sample observability setup using Prometheus, Grafana, and OpenTelemetry

## Deployment

All services are containerized using Docker and ready for deployment on Kubernetes using provided YAMLs under the `kubernetes/` directory.


### Build Docker Images
```bash
make build-all    # Builds Docker images for all microservices
```

### Run with Docker Compose (for local development)
```bash
make docker-up    # Start all services with Docker Compose
make docker-down  # Stop all services
```

### Deploy to Kubernetes
Kubernetes manifests are located in the kubernetes/ directory.
```bash
make kube-up      # Deploy all services to Kubernetes
make kube-down    # Tear down all services from Kubernetes
```

## Note
This project was initially developed by following the Udemy course "Master Microservices with Spring Boot, Docker, Kubernetes". It has been adapted and cleaned for demonstration and public showcasing purposes.

