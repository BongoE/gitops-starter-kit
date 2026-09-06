# Troubleshooting lab

The branch `broken/troubleshooting-lab` contains the same sample app with **five deliberate bugs**, layered so that fixing one reveals the next. This is how real incidents feel: you never get all the errors at once.

## How to run it
1. Have the kit running (`make up`).
2. Point the dev app at the broken branch. Either edit `apps/hello-dev.yaml` and set `targetRevision: broken/troubleshooting-lab`, or run:
   ```bash
   kubectl -n argocd patch application hello-dev --type merge -p '{"spec":{"source":{"targetRevision":"broken/troubleshooting-lab"}}}'
   ```
3. Open the Argo CD UI. Something is red. Start there.
4. Fix each bug **in Git** on the branch (never with `kubectl edit`; Argo CD will revert you, that is the lesson). Commit, push, watch it sync.
5. You are done when http://localhost:30080 shows the message "If you can read this, you fixed all five bugs."

## Rules
- Every fix is a commit. Your git log becomes your incident timeline.
- Read the error before you change anything. Write down what you *think* is wrong, then check.
- Stuck for more than 20 minutes on one bug? Open `labs/SOLUTIONS.md` for that bug only.

## The five layers (no spoilers)
1. Argo CD cannot even render the manifests.
2. Kubernetes refuses the Deployment.
3. The pod exists but never pulls.
4. The pod runs but is never Ready.
5. Everything is green and the app is still unreachable.

Each one is a different tool in your belt: the Argo CD UI, `kubectl describe`, `kubectl get events`, `kubectl logs`, and reading a Service carefully.

When you finish, post your five commits on LinkedIn and tag the repo. That is a portfolio entry, not a tutorial.
