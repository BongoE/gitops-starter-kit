# bootstrap

This folder contains alternative Argo CD install paths. The default (`scripts/setup.sh` / `make up`)
installs from the upstream raw manifest. Use the options here when you want more control.

## Default install (raw manifest)

```bash
make up
# or, to pin a version:
ARGOCD_VERSION=v2.13.0 ./scripts/setup.sh
```

## Option A — Helm chart (`argocd-helm/`)

Use this when you want to:
- Track ArgoCD as a Helm release (`helm list`, `helm upgrade`)
- Configure ArgoCD components via `values.yaml` (disable dex, notifications, etc.)
- Save resources on a small local machine by disabling HA replicas

```bash
# Optionally pin the chart version:
export ARGOCD_CHART_VERSION=7.7.0

./bootstrap/argocd-helm/install.sh

# Then bootstrap the App of Apps as usual:
kubectl apply -f argocd/root-app.yaml
```

Edit `argocd-helm/values.yaml` to customise the install. The ArgoCD image tag is pinned there too.

## Option B — Flux (future contribution)

The four OpenGitOps principles are tool-agnostic. This kit's `manifests/` folder works identically
with Flux. A Flux bootstrap would live in `bootstrap/flux/` and is a great first contribution.
See `CONTRIBUTING.md` for guidance.
