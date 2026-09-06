.PHONY: up down login validate broken-branch
up:            ## Create cluster, install Argo CD, apply root app
	./scripts/setup.sh
down:          ## Delete the cluster
	./scripts/teardown.sh
login:         ## Print admin password and port-forward the UI
	./scripts/argocd-login.sh
validate:      ## Build every kustomization to catch YAML mistakes before Argo CD does
	@for d in manifests/hello/overlays/dev manifests/hello/overlays/prod; do echo "== $$d"; kustomize build $$d >/dev/null && echo ok; done
broken-branch: ## Create the broken/troubleshooting-lab branch locally
	./scripts/create-broken-branch.sh
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'
