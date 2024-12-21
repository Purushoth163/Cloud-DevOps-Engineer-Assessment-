# setup.sh
#!/bin/bash

# Initialize Terraform and apply configuration
cd terraform
terraform init
terraform apply -auto-approve

# Build and push Docker image
cd ../app
docker build -t <dockerhub-username>/web-app:latest .
docker push <dockerhub-username>/web-app:latest

# Apply Kubernetes manifests
cd ../k8s
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml

# Deploy monitoring stack
cd ../monitoring
kubectl apply -f prometheus-deployment.yaml
kubectl apply -f prometheus-config.yaml
kubectl apply -f service-monitor.yaml

# Install NGINX ingress controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/aws/deploy.yaml

# Output application and monitoring endpoints
kubectl get svc
