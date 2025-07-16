# Sample Helm App

Sample project with Helm chart for Kubernetes.

## Prerequisites

```bash
# Install Helm (Windows)
winget install Helm.Helm

# Or via Chocolatey
choco install kubernetes-helm

# Or download manually: https://helm.sh/docs/intro/install/
```

## Quick Test (Dry Run)

```bash
# Test staging
helm template sample-helm-app-staging ./charts -f ./charts/values-staging.yaml > debug.yml

# Test production
helm template sample-helm-app-production ./charts -f ./charts/values-production.yaml > debug.yml
```

## Deploy

```bash
# Staging
helm install sample-helm-app-staging ./charts -f ./charts/values-staging.yaml

# Production
helm install sample-helm-app-production ./charts -f ./charts/values-production.yaml
```

## Structure

```
charts/
├── Chart.yaml
├── values.yaml              # Default
├── values-staging.yaml      # Staging
├── values-production.yaml   # Production
└── templates/
    ├── deployment.yaml
    ├── service.yaml
    └── namespace.yaml
```

## Environments

- **Staging**: 1 replica, smaller resources
- **Production**: 3 replicas, larger resources
- **Namespace**: `sample-helm`

## Access

```bash
# Staging (port 3000)
kubectl port-forward -n sample-helm svc/sample-helm-app-staging 3000:80

# Production (port 3001)
kubectl port-forward -n sample-helm svc/sample-helm-app-production 3001:80
```

## ArgoCD

### 1. Adjust the repoURL
Edit the `argocd-app-*.yaml` files and change:
```yaml
repoURL: https://github.com/YOUR-USERNAME/sample-helm-app.git
```

### 2. Helm Configuration in ArgoCD
```yaml
helm:
  chart: sample-helm-app    # Chart name (from Chart.yaml)
  version: 0.1.0           # Chart version (from Chart.yaml)
  valueFiles:
    - values-staging.yaml   # Specific values file
```

### 3. Apply the Applications
```bash
# Staging
kubectl apply -f argocd-app-staging.yaml

# Production
kubectl apply -f argocd-app-production.yaml
```

### 4. Check in ArgoCD UI
- Access the ArgoCD interface
- You will see the two applications: `sample-helm-app-staging` and `sample-helm-app-production`
- Click "Sync" to perform the first deploy

### ArgoCD Configuration:
- **Path**: `charts` (where Chart.yaml is located)
- **Chart**: `sample-helm-app` (chart name)
- **Version**: `0.1.0` (chart version)
- **Value Files**: `values-staging.yaml` or `values-production.yaml`
- **Namespace**: `sample-helm` (created automatically)
- **Sync Policy**: Automatic with prune and self-heal 