#!/bin/bash

# Function to check deployment status
check_deployment() {
    namespace=$1
    deployment=$2
    echo "Checking deployment status in namespace: $namespace"
    
    kubectl -n $namespace rollout status deployment/$deployment
    if [ $? -ne 0 ]; then
        echo "Deployment failed in $namespace namespace"
        exit 1
    fi
}

# Function to deploy to an environment
deploy_to_environment() {
    env=$1
    values_file="./helm/k8s-deploy-demo/values-${env}.yaml"
    release_name="k8s-deploy-demo"

    echo "Deploying to ${env} environment..."
    
    # Create namespace if it doesn't exist
    kubectl create namespace $env --dry-run=client -o yaml | kubectl apply -f -

    # Deploy using Helm
    helm upgrade --install $release_name ./helm/k8s-deploy-demo \
        --namespace $env \
        --values ./helm/k8s-deploy-demo/values.yaml \
        --values $values_file \
        --wait

    check_deployment "$env" "$release_name"
    
    # Get NodePort
    nodePort=$(kubectl -n $env get svc $release_name -o jsonpath='{.spec.ports[0].nodePort}')
    echo "${env} deployment successful! Available at http://localhost:${nodePort}"
}

# Build and package application
echo "Building application..."
./mvnw clean package -DskipTests
docker build -t k8s-deploy-demo:latest .

# Deploy to dev
deploy_to_environment "dev"

# Prompt for stage deployment
read -p "Dev deployment successful. Do you want to proceed with staging deployment? (y/n) " proceed
if [ "$proceed" != "y" ]; then
    echo "Deployment stopped after dev environment"
    exit 0
fi

# Deploy to stage
deploy_to_environment "stage"

# Prompt for production deployment
read -p "Stage deployment successful. Do you want to proceed with production deployment? (y/n) " proceed
if [ "$proceed" != "y" ]; then
    echo "Deployment stopped after staging environment"
    exit 0
fi

# Deploy to prod
deploy_to_environment "prod"
