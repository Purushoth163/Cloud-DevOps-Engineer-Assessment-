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
   docker build -t <dockerhub-username>/web-app:latest .
   docker push <dockerhub-username>/web-app:latest
   ```

3. Deploy the Kubernetes manifests:
   ```bash
   kubectl apply -f k8s/deployment.yaml
   kubectl apply -f k8s/service.yaml
   kubectl apply -f k8s/ingress.yaml
   ```

4. Deploy Prometheus:
   ```bash
   kubectl apply -f monitoring/prometheus-deployment.yaml
   kubectl apply -f monitoring/prometheus-config.yaml
   kubectl apply -f monitoring/service-monitor.yaml
   ```

5. Install NGINX Ingress Controller:
   ```bash
   kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/aws/deploy.yaml
   ```

6. Access the application:
   - Update your local `/etc/hosts` file to map the `web-app.local` domain to the ingress controller's external IP.
   - Find the Ingress Controller IP using:
     ```bash
     kubectl get svc -n ingress-nginx
     ```
   - Open `http://web-app.local` in your browser.

7. Access Prometheus:
   - Find the Prometheus IP using:
     ```bash
     kubectl get svc prometheus
     ```
   - Open the IP in your browser.
