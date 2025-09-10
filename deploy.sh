#!/bin/bash

# Set default profile if not provided
PROFILE=${1:-stage}

# Build the application
echo "Building application..."
./mvnw clean package -DskipTests

# Build Docker image
echo "Building Docker image..."
docker build -t k8s-deploy-demo:latest .

# Apply Kubernetes manifests with environment variables
echo "Deploying to Kubernetes..."
SPRING_PROFILE=$PROFILE envsubst < k8s/deployment.yaml | kubectl apply -f -
kubectl apply -f k8s/service.yaml

echo "Deployment completed! The application will be available at http://localhost:30080"
