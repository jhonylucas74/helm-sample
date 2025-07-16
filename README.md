# Sample Helm App

Projeto de exemplo com Helm chart para Kubernetes.

## Pré-requisitos

```bash
# Instalar Helm (Windows)
winget install Helm.Helm

# Ou via Chocolatey
choco install kubernetes-helm

# Ou baixar manualmente: https://helm.sh/docs/intro/install/
```

## Teste Rápido (Dry Run)

```bash
# Testar staging
helm template sample-helm-app-staging ./charts -f ./charts/values-staging.yaml --debug

# Testar production
helm template sample-helm-app-production ./charts -f ./charts/values-production.yaml --debug
```

## Deploy

```bash
# Staging
helm install sample-helm-app-staging ./charts -f ./charts/values-staging.yaml

# Production
helm install sample-helm-app-production ./charts -f ./charts/values-production.yaml
```

## Estrutura

```
charts/
├── Chart.yaml
├── values.yaml              # Padrão
├── values-staging.yaml      # Staging
├── values-production.yaml   # Production
└── templates/
    ├── deployment.yaml
    ├── service.yaml
    └── namespace.yaml
```

## Ambientes

- **Staging**: 1 replica, recursos menores
- **Production**: 3 replicas, recursos maiores
- **Namespace**: `sample-helm`

## Acesso

```bash
# Staging (porta 3000)
kubectl port-forward -n sample-helm svc/sample-helm-app-staging 3000:80

# Production (porta 3001)
kubectl port-forward -n sample-helm svc/sample-helm-app-production 3001:80
```

## ArgoCD

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: sample-helm-app-staging
spec:
  source:
    repoURL: https://your-repo.git
    path: charts
    helm:
      valueFiles: [values-staging.yaml]
  destination:
    namespace: sample-helm
``` 