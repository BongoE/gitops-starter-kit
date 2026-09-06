# Decisions

Every GitOps repo carries invisible decisions. This file makes them visible. Add yours as you go.

## 001: Argo CD, not Flux, for the starter kit
Argo CD has a UI, and beginners learn faster when they can *see* Synced turn green. Flux is equally valid and better for composable, headless or edge setups. The principles are identical; swap the tool later and this repo's manifests still work.

## 002: Kustomize overlays, one folder per environment
Folders beat branches for environments: no long-lived branches to merge, and a diff between `overlays/dev` and `overlays/prod` is the full difference between the environments.

## 003: dev auto-syncs, prod does not
Dev is where you learn what auto-sync feels like. Prod is where you learn that a human gate is a choice, not a default. Exercise 05 asks you to argue for one or the other.

## 004: No secrets in this repo
See exercises/06-secrets.md. Adding a secrets pattern is the first "real" contribution a learner can make.

## 005: App of Apps for bootstrap
One `kubectl apply -f argocd/root-app.yaml` rebuilds everything. That is disaster recovery in one line.

## Your decisions
(Add below. Format: number, title, one paragraph of reasoning.)
