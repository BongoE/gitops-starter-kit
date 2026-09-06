#!/usr/bin/env bash
# Prints the Argo CD admin password and starts a port-forward to the UI.
set -euo pipefail
echo "admin password: $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d)"
echo "Opening https://localhost:8080 (Ctrl+C to stop)"
kubectl -n argocd port-forward svc/argocd-server 8080:443
