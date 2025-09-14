# Spring Boot Kubernetes Demo

This is a Spring Boot application demonstrating modern GitOps-based deployment to Kubernetes using GitHub Actions and ArgoCD.

## Tech Stack

- Spring Boot
- Docker
- Kubernetes
- Helm
- GitHub Actions (CI)
- ArgoCD (CD)

## CI/CD Flow

1. **CI Pipeline (GitHub Actions)**
   - Builds Java application
   - Runs tests
   - Builds Docker image
   - Pushes to GitHub Container Registry
   - Runs security scans (Trivy)
   - Validates Helm charts

2. **CD Pipeline (ArgoCD)**
   - Manages deployments to all environments (dev/stage/prod)
   - Automatically syncs with Git repository
   - Provides deployment visualization and health status
   - Implements GitOps practices

## Prerequisites

- Kubernetes cluster
- ArgoCD installed in the cluster
- GitHub account with Container Registry enabled

## Local Development

1. Build the application:
   ```bash
   ./mvnw clean package
   ```

2. Build Docker image:
   ```bash
   docker build -t k8s-deploy-demo:latest .
   ```

3. Run locally:
   ```bash
   docker run -p 8080:8080 k8s-deploy-demo:latest
   ```

## Deployment

The application uses GitOps with ArgoCD for deployments:

1. **Dev Environment**
   - Automatically deploys from the `develop` branch
   - Uses `values-dev.yaml` for environment-specific config

2. **Staging Environment**
   - Automatically deploys from the `main` branch
   - Uses `values-stage.yaml` for environment-specific config

3. **Production Environment**
   - Requires manual promotion
   - Uses `values-prod.yaml` for environment-specific config

## Monitoring

- Application metrics are exposed at `/actuator/prometheus`
- Ready for Prometheus/Grafana monitoring stack

## Future Enhancements

- [ ] Add Argo Rollouts for advanced deployment strategies
- [ ] Implement canary deployments
- [ ] Add automated testing in staging
- [ ] Implement service mesh

## Deployment
Application deployed using ArgoCD
# Last updated: Sun Sep 14 15:07:15 IST 2025
