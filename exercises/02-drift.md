# Exercise 02: Drift, and why it does not survive (5 minutes)

**Goal:** feel rule 4 (continuous reconciliation).

1. Scale the app by hand, the "old way":
   ```bash
   kubectl -n hello-dev scale deployment hello --replicas=5
   kubectl -n hello-dev get pods
   ```
2. Watch Argo CD. `hello-dev` briefly shows OutOfSync, then `selfHeal` puts it back to the
   replica count declared in `manifests/hello/overlays/dev/kustomization.yaml` (currently 3).
3. Now try to change the message by hand:
   ```bash
   kubectl -n hello-dev set env deployment/hello PODINFO_UI_MESSAGE="I edited prod by hand"
   ```
   Same thing. It reverts.

**What you just proved:** the cluster is a projection of Git. Manual edits are drift, and drift is corrected. This is the single behaviour that ends "who changed this?" conversations.

**Think:** is there a case where you *want* a human to be able to hand-edit? (Hint: incidents. Look up "break-glass" in `docs/GLOSSARY.md`.)
