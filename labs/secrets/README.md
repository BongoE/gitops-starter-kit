# Secrets lab

This folder contains starter manifests for three secrets patterns mentioned in `exercises/06-secrets.md`.
They are **not applied** by the root Application — they are here to read, adapt, and optionally apply manually.

## Why this folder exists

Exercise 06 asks you to pick a secrets pattern and argue for it. These stubs give you something concrete
to apply and observe rather than reading docs in the abstract.

## Pattern A — Sealed Secrets (simplest to self-host)

`sealed-secrets/` contains:
- `controller.yaml` — installs the Sealed Secrets controller via its upstream manifest
- `example-sealedsecret.yaml` — a pre-encrypted placeholder (cluster-specific; see below)
- `kustomization.yaml`

**Try it:**
```bash
# 1. Install the controller
kubectl apply -f labs/secrets/sealed-secrets/controller.yaml

# 2. Install the kubeseal CLI (https://github.com/bitnami-labs/sealed-secrets#kubeseal)
# 3. Create a real SealedSecret from a plain Secret:
kubectl create secret generic hello-secret \
  --from-literal=API_KEY=supersecret \
  --dry-run=client -o yaml \
  | kubeseal --format yaml > labs/secrets/sealed-secrets/my-sealedsecret.yaml

# 4. Apply and verify
kubectl apply -f labs/secrets/sealed-secrets/my-sealedsecret.yaml
kubectl get secret hello-secret -o jsonpath='{.data.API_KEY}' | base64 -d
```
The encrypted blob is safe to commit. Only the cluster that has the controller's private key can decrypt it.

---

## Pattern B — External Secrets Operator (recommended for cloud teams)

`external-secrets/` contains:
- `operator.yaml` — installs ESO via its upstream manifest
- `secret-store.yaml` — a `ClusterSecretStore` pointing at AWS SSM Parameter Store (region placeholder)
- `external-secret.yaml` — an `ExternalSecret` that syncs a parameter into a Kubernetes Secret

**Try it (requires AWS credentials):**
```bash
# 1. Install the operator
kubectl apply -f labs/secrets/external-secrets/operator.yaml

# 2. Create a Kubernetes secret holding your AWS creds (do not commit this)
kubectl create secret generic aws-credentials \
  --from-literal=access-key-id=YOUR_ACCESS_KEY \
  --from-literal=secret-access-key=YOUR_SECRET_KEY

# 3. Edit secret-store.yaml and external-secret.yaml with your region/parameter name, then:
kubectl apply -f labs/secrets/external-secrets/secret-store.yaml
kubectl apply -f labs/secrets/external-secrets/external-secret.yaml
kubectl get secret hello-secret
```

---

## Pattern C — SOPS + age (best for Flux / no-cluster-operator preference)

`sops/` contains:
- `example.enc.yaml` — a mock encrypted Secret (not real ciphertext; replace with your own)
- `encrypt.sh` — a helper script showing the `sops --encrypt` workflow

**Try it:**
```bash
# 1. Install age: https://github.com/FiloSottile/age#installation
# 2. Generate a key pair
age-keygen -o age.key   # store the private key safely; never commit it

# 3. Encrypt a secret
kubectl create secret generic hello-secret \
  --from-literal=API_KEY=supersecret \
  --dry-run=client -o yaml \
  | sops --encrypt --age $(grep 'public key' age.key | awk '{print $4}') \
         --input-type yaml --output-type yaml /dev/stdin \
  > labs/secrets/sops/example.enc.yaml

# 4. Commit example.enc.yaml — the plaintext never leaves your machine
# 5. Decrypt to verify
sops --decrypt labs/secrets/sops/example.enc.yaml
```

---

## Decision prompt

After trying at least one pattern, add an entry to `docs/DECISIONS.md`:

> **Decision NNN: Secrets management pattern**
> We chose [pattern] because [one paragraph of reasoning tailored to our team's AWS / Vault / on-prem context].

That entry is the real deliverable of exercise 06.
