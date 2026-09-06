# Prerequisites

You need four things installed. Roughly 15 minutes on a fresh laptop.

| Tool | Why | Install |
|---|---|---|
| Docker Desktop (or Podman) | kind runs Kubernetes inside containers | https://docs.docker.com/get-docker/ |
| kind | Local Kubernetes cluster | https://kind.sigs.k8s.io/docs/user/quick-start/#installation |
| kubectl | Talk to the cluster | https://kubernetes.io/docs/tasks/tools/ |
| kustomize | Validate manifests locally (`make validate`) | https://kubectl.docs.kubernetes.io/installation/kustomize/ |

Optional: the `argocd` CLI (https://argo-cd.readthedocs.io/en/stable/cli_installation/) and `git` (you almost certainly have it).

Laptop: 4 GB RAM free is enough. Windows users: run everything from WSL2.

Check:
```bash
docker version && kind version && kubectl version --client && kustomize version
```
