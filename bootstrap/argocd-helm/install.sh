#!/usr/bin/env bash
# Alternative ArgoCD install: Helm chart instead of the upstream raw manifest.
#
# When to use this instead of scripts/setup.sh:
#   - You want fine-grained control over ArgoCD's configuration via values.yaml
#   - You want to track ArgoCD as a Helm release (helm list, helm upgrade)
#   - You want to disable components (dex, notifications) to save resources
#
# Prerequisites: helm (https://helm.sh/docs/intro/install/)
# Usage: ./bootstrap/argocd-helm/install.sh
set -euo pipefail

ARGOCD_CHART_VERSION="${ARGOCD_CHART_VERSION:-7.7.0}"   # argo-helm chart version, not ArgoCD version
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

need() { command -v "$1" >/dev/null 2>&1 || { echo "Missing: $1"; exit 1; }; }
need helm; need kubectl

echo "==> Adding argo Helm repo"
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

echo "==> Installing ArgoCD via Helm (chart version $ARGOCD_CHART_VERSION)"
helm upgrade --install argocd argo/argo-cd \
  --version "$ARGOCD_CHART_VERSION" \
  --namespace argocd \
  --create-namespace \
  --values "$SCRIPT_DIR/values.yaml" \
  --wait \
  --timeout 5m

echo "==> Waiting for ArgoCD server rollout"
kubectl -n argocd rollout status deployment/argocd-server --timeout=300s

PASS="$(kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath='{.data.password}' | base64 -d)"

cat <<MSG

============================================================
 ArgoCD installed via Helm.

 UI:       kubectl -n argocd port-forward svc/argocd-server 8080:80
           open  http://localhost:8080   (insecure mode enabled in values.yaml)
 Username: admin
 Password: $PASS

 Next: apply the root Application
   kubectl apply -f argocd/root-app.yaml
============================================================
MSG
