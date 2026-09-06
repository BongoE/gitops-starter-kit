# Exercise 05: Promote to prod, and decide who is allowed to (15 minutes)

**Goal:** understand environments as folders, and manual vs automated sync.

1. Look at `manifests/hello/overlays/prod/`. Same base, different folder, different values (2 replicas, green colour, port 30081).
2. `hello-prod` has no `automated` sync policy. Sync it by hand in the UI, or:
   ```bash
   kubectl -n argocd patch application hello-prod --type merge -p '{"operation":{"sync":{}}}'
   ```
   Then open http://localhost:30081. (Add a port mapping for 30081 in `kind/cluster.yaml` first if you want it reachable from your browser.)
3. Now "promote" a change: edit the base message, push. Dev syncs itself. Prod waits for a human.

**Decide:** should prod auto-sync? Write your answer in one paragraph in `docs/DECISIONS.md` under a new heading. There is no single right answer; there is a right *argument*. Senior engineers are paid for the argument.

**Going further:** read about Kargo (Argo's promotion tool) and Flux image automation. Both replace "a human edits the prod folder" with a declarative promotion pipeline.
