#!/usr/bin/env bash
# One command to a working GitOps lab: kind cluster + Argo CD + root Application.
# Usage: ./scripts/setup.sh
set -euo pipefail

ARGOCD_VERSION="${ARGOCD_VERSION:-stable}"
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

need() { command -v "$1" >/dev/null 2>&1 || { echo "Missing: $1. See docs/PREREQUISITES.md"; exit 1; }; }
need docker; need kind; need kubectl

echo "==> 1/4 Creating kind cluster (gitops-starter)"
if kind get clusters | grep -q '^gitops-starter$'; then
  echo "    cluster already exists, reusing it"
else
  kind create cluster --config "$REPO_ROOT/kind/cluster.yaml"
fi
kubectl config use-context kind-gitops-starter >/dev/null

echo "==> 2/4 Installing Argo CD ($ARGOCD_VERSION)"
kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -n argocd -f "https://raw.githubusercontent.com/argoproj/argo-cd/${ARGOCD_VERSION}/manifests/install.yaml"

echo "==> 3/4 Waiting for Argo CD to be ready (this can take 1 to 3 minutes)"
kubectl -n argocd rollout status deployment/argocd-server --timeout=300s
kubectl -n argocd rollout status deployment/argocd-repo-server --timeout=300s
kubectl -n argocd rollout status statefulset/argocd-application-controller --timeout=300s

echo "==> 4/4 Applying the root Application (App of Apps)"
kubectl apply -f "$REPO_ROOT/argocd/root-app.yaml"

PASS="$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d)"

cat <<MSG

============================================================
 GitOps starter kit is up.

 Argo CD UI:   run   kubectl -n argocd port-forward svc/argocd-server 8080:443
               open  https://localhost:8080   (accept the self-signed cert)
 Username:     admin
 Password:     $PASS

 Sample app (dev):  http://localhost:30080   (appears once hello-dev is Synced)

 Next: open exercises/01-first-sync.md
============================================================
MSG
