# Solutions (spoilers)

Open only for the bug you are stuck on.

<details><summary>Bug 1: Argo CD shows "ComparisonError" / cannot build kustomization</summary>

`manifests/hello/overlays/dev/kustomization.yaml` references `../../bases`. The folder is `base`. One letter.

**Lesson:** GitOps fails early and loudly. A typo in a path stops the whole sync, which is far better than a half-applied change. Run `kustomize build manifests/hello/overlays/dev` locally before pushing. The CI workflow in this repo does exactly that on every PR.
</details>

<details><summary>Bug 2: Sync error "selector does not match template labels"</summary>

In `deployment.yaml` the selector is `app: hello`, the pod template label is `app: helo`.

**Lesson:** The Kubernetes API validates this and rejects the Deployment. Argo CD shows the API error verbatim. Read it. It tells you exactly which field.
</details>

<details><summary>Bug 3: Pod stuck in ImagePullBackOff</summary>

Image tag `6.6.2-latest` does not exist. Correct tag: `6.6.2`.

**Lesson:** `kubectl -n hello-dev describe pod <name>` and read the Events at the bottom. "manifest unknown" means the tag is wrong. Also: never use `latest` in GitOps. It breaks rule 2 (versioned and immutable).
</details>

<details><summary>Bug 4: Pod is Running but 0/1 Ready, Argo CD shows "Progressing" forever</summary>

Readiness probe path is `/ready`. podinfo serves `/readyz`.

**Lesson:** Running is not Ready. `kubectl describe pod` shows "Readiness probe failed: 404". Argo CD's health check waits for Ready, so the app never turns green. Health, not sync, is what tells you users are served.
</details>

<details><summary>Bug 5: Everything is green, http://localhost:30080 does not respond</summary>

Service `targetPort` is 8080. The container listens on 9898.

**Lesson:** Argo CD says Synced and Healthy because from Kubernetes' point of view nothing is wrong: a Service pointing at a closed port is a valid object. GitOps guarantees the cluster matches Git. It does not guarantee Git is correct. That gap is why seniors add smoke tests and why "green in Argo" is never the end of an incident.
</details>

## What you just practised
Five bugs, five different places to look: the GitOps controller, the API server, the kubelet (image pull), the probe, and the network path. That is the shape of most production incidents on Kubernetes.
