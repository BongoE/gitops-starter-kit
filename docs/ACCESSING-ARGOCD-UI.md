# Accessing the Argo CD UI (and why port-forward exists)

**You will type `./scripts/argocd-login.sh` a dozen times in this kit. Here is what it is actually doing, and why production looks nothing like it.**

## Why this matters

Beginners copy the port-forward command and never ask why it is needed. Then they get to a real job, try to "just open" the internal Argo CD UI the same way, and it does not work, because production is a different shape entirely. Knowing the shape now saves you a confused afternoon later.

## The mental model: three questions, three diagrams

### 1. On your laptop right now: how does `localhost:8080` reach a pod inside a Docker container?

```mermaid
flowchart LR
    subgraph Laptop["Your laptop. Nothing outside it is involved."]
        Browser["Browser<br/>https://localhost:8080"]
        Tunnel["kubectl port-forward<br/>a temporary tunnel, yours alone"]
        subgraph Cluster["kind cluster (just a Docker container)"]
            API["Kubernetes API server"]
            Svc["argocd-server Service<br/>ClusterIP: internal-only by design"]
            Pod["argocd-server Pod<br/>the actual UI code"]
        end
    end
    Browser --> Tunnel --> API --> Svc --> Pod
```

**The point:** `ClusterIP` means "reachable only from inside the cluster." That is not a bug, it is the safe default every Service gets. `kubectl port-forward` is a side door that only you can open, from your own machine, using your own kubeconfig credentials. Close the terminal, the door closes.

### 2. In a real company: how does a teammate open Argo CD from their own laptop?

```mermaid
flowchart LR
    User["A teammate, any laptop"] --> DNS["argocd.yourcompany.com<br/>a real DNS record"]
    DNS --> Ingress["Ingress + TLS certificate<br/>cert-manager / Let's Encrypt"]
    Ingress --> SSO["SSO login<br/>Okta, Google Workspace, Azure AD..."]
    SSO --> Svc["argocd-server Service"]
    Svc --> Pod["argocd-server Pod"]
    Pod -.-> RBAC["RBAC: what THEY can see and do<br/>not what admin can"]
```

**The point:** production swaps your one-person tunnel for four things nobody skips: a DNS name, a TLS certificate, a login system that is not a shared admin password, and RBAC that scopes each person to their own team's apps. None of that exists in this kit on purpose, it would be noise in a learning repo. But you should be able to name all four, because a senior engineer gets asked to build this exact chain.

### 3. Can someone else reach YOUR local Argo CD right now?

```mermaid
flowchart TD
    Q["Can a teammate open your localhost:8080?"] --> Default["Default answer: no"]
    Default --> Why["port-forward binds to 127.0.0.1.<br/>Only processes on your own laptop can even try."]
    Q --> Exposed["Only if you deliberately expose it<br/>ngrok, cloudflared, or opening your router"]
    Exposed --> Risk["Now a default admin login sits on the open internet,<br/>on a cluster never hardened for that"]
    Risk --> Lens["Senior lens: don't. Record a video, or spin up<br/>a real demo environment instead."]
```

**The point:** "local" is a real security boundary, not a weaker version of production. Treat the gap between them as a feature to explain, not a shortcut to close.

## Senior lens

The annoying five-step dance (run a script, leave a terminal open, click through a cert warning, log in with a password you just copied) is the price of a safe default. The moment it feels too annoying and you are tempted to make the Service a `LoadBalancer` or `NodePort` "just for now," ask: would I ship that same shortcut to a cluster that is not on my own laptop? If not, the friction is doing its job.

## Try it yourself

- Kill the port-forward terminal (`Ctrl+C`), then try loading `https://localhost:8080` again. Watch it fail. That failure *is* the ClusterIP boundary working.
- Run `kubectl -n argocd get svc argocd-server` and read the `TYPE` column. `ClusterIP` is the same word as in diagram 1.
