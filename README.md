# Cloud-DevOps-Engineer-Assessment

## Web App Kubernetes Deployment

### Prerequisites
- Terraform installed
- AWS CLI configured
- kubectl installed
- Docker installed

### Steps to Deploy
1. Provision the infrastructure:
   ```bash
   cd terraform
   terraform init
   terraform apply
   ```

2. Build and push the Docker image:
   ```bash
   cd app
   docker build -t <your-dockerhub-username>/web-app:latest .
   docker push <your-dockerhub-username>/web-app:latest
   ```

3. Deploy the Kubernetes manifests:
   ```bash
   kubectl apply -f k8s/deployment.yaml
   kubectl apply -f k8s/service.yaml
   ```

4. Deploy Prometheus:
   ```bash
   kubectl apply -f monitoring/prometheus-deployment.yaml
   kubectl apply -f monitoring/prometheus-config.yaml
   kubectl apply -f monitoring/service-monitor.yaml
   ```

5. Access the application:
   - Find the LoadBalancer IP using:
     ```bash
     kubectl get svc web-app-service
     ```
   - Open the IP in your browser.

6. Access Prometheus:
   - Find the Prometheus IP using:
     ```bash
     kubectl get svc prometheus
     ```
   - Open the IP in your browser.
