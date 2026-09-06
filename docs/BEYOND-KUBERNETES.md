# GitOps beyond Kubernetes

The four principles (declarative, versioned, pulled, reconciled) never mention Kubernetes. Kubernetes is simply the easiest place to run the agent because it has a reconciliation loop built in.

| Target | Tool | What you get |
|---|---|---|
| Terraform / OpenTofu | Atlantis, Terrateam | plan on PR, apply on merge. PR gate, audit log. Not continuous reconciliation. |
| Cloud infra as Kubernetes objects | Crossplane + Argo CD / Flux | full GitOps for AWS/GCP/Azure resources, reconciled continuously. |
| VMs, legacy apps | CI runner inside the environment, Ansible, AWX | GitOps-style: declarative config in Git, applied on merge. |

Honest summary: outside Kubernetes you usually get rules 1 to 3. Rule 4 is the hard one, and it is why Kubernetes and GitOps grew up together.
