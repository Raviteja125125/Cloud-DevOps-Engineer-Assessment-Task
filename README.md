# Cloud-DevOps-Engineer-Assessment-Task


To Provision Cloud Infrastructure using Terraform (IAC)
we will need to provision cloud infrastructure 

-VPC, subnets, and security groups.
-An EKS (Elastic Kubernetes Service) cluster for Kubernetes deployment.
-IAM roles and policies.

Documentation for Deploying the Solution
You’ll need clear documentation to guide anyone deploying the solution. Here’s an example structure:






-- Overview

This project sets up a simple web application in a cloud-based Kubernetes environment with Prometheus for monitoring.

-- Prerequisites

1. Terraform installed (for Infrastructure as Code).
2. AWS CLI configured (if using AWS).
3. Kubernetes (kubectl) configured.
4. Docker installed (to build the container image).

-- Setup Instructions

--- Step 1: Provision Infrastructure using Terraform
 Run the following commands:
   
   terraform init
   terraform apply

   
Step 2: Deploy Kubernetes Resources
.
Apply the Kubernetes manifests:

kubectl apply -f deployment.yml
kubectl apply -f prometheus.yml
Step 3: Build and Push Docker Image

Build the Docker image:

docker build -t raviteja12/web-app:latest .
Push it to Docker Hub:

docker push raviteja12/web-app:latest
Step 4: Monitor the Application
Once the application is running, you can access Prometheus at http://12.0.0.0:9090.
