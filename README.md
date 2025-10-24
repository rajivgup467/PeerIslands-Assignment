# Production-like AKS Deployment using Terraform, GitHub Actions, and Monitoring

This project provisions a production-like Azure Kubernetes Service (AKS) environment using Terraform, builds and deploys a microservice-based application through GitHub Actions, enforces infrastructure security scanning (Checkov), and sets up Prometheus + Grafana monitoring for observability.

# Architecture Overview

The end-to-end system is fully automated — from infrastructure creation to app deployment and monitoring setup.

High-Level Flow
Developer Push → GitHub Actions Pipeline
        │
        ├── Checkov Security Scan (Terraform)
        ├── Build & Push Docker images → Azure Container Registry (ACR)
        ├── Terraform Apply → Azure Resources (AKS, VNet, ACR)
        ├── kubectl apply → Deploy Microservices to AKS
        └── Helm install → Prometheus & Grafana monitoring stack


 

# Repository Structure
project-root/
├── infrastructure/            # Terraform IaC for Azure resources
│   ├── main.tf
│   ├── variables.tf
│   ├── providers.tf
│   ├── outputs.tf
│   └── terraform.tfvars
│
├── app/                       # Sample microservice application
│   ├── api/                   # Flask-based REST API
│   │   ├── app.py
│   │   └── Dockerfile
│   └── frontend/              # Nginx-based frontend
│       ├── index.html
│       └── Dockerfile
│
├── k8s/                       # Kubernetes manifests for microservices
│   ├── namespace.yaml
│   ├── deployment-api.yaml
│   ├── service-api.yaml
│   ├── deployment-frontend.yaml
│   ├── service-frontend.yaml
│   └── ingress.yaml
│
└── .github/workflows/         # CI/CD automation (GitHub Actions)
    └── deploy.yaml

# Technologies Used
Layer	Technology	Purpose
Infrastructure	Terraform + AzureRM Provider	Declarative IaC provisioning
Security	Checkov	Terraform compliance & vulnerability scanning
CI/CD	GitHub Actions	Build, scan, deploy automation
Containerization	Docker + ACR	Image build & storage
Orchestration	AKS (Kubernetes)	Microservice runtime
Monitoring	Prometheus + Grafana (Helm)	Metrics collection & visualization

# Prerequisites

Azure CLI (az login)

Terraform (≥ 1.5)

kubectl

Helm 3

# GitHub repository with the following Secrets configured:

Secret	Description
AZURE_CREDENTIALS	Output JSON from az ad sp create-for-rbac --sdk-auth
ARM_CLIENT_ID	Service principal client ID
ARM_CLIENT_SECRET	Service principal secret
ARM_TENANT_ID	Tenant ID
ARM_SUBSCRIPTION_ID	Azure subscription ID
RESOURCE_GROUP	e.g., rg-aks-prod
AKS_CLUSTER_NAME	e.g., aks-prod-cluster
ACR_LOGIN_SERVER	e.g., acrprodappdemo.azurecr.io
ACR_USERNAME	ACR username
ACR_PASSWORD	ACR password
# Deployment Workflow (CI/CD)
# Stage 1: Terraform Security Scan

Runs Checkov to identify misconfigurations or security issues in Terraform code.

# Stage 2: Build & Push

Builds Docker images for both frontend and api microservices and pushes them to Azure Container Registry (ACR).

# Stage 3: Terraform Apply

Provisions Azure resources:

Resource Group

Virtual Network + Subnet

AKS Cluster (RBAC enabled)

Azure Container Registry (ACR)

# Stage 4: Deploy to AKS

Applies Kubernetes manifests for:

API Deployment & Service

Frontend Deployment & Service

Ingress resource for external access

# Stage 5: Install Prometheus & Grafana

Automatically installs Prometheus and Grafana via Helm charts for monitoring.