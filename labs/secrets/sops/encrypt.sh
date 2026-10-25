#!/usr/bin/env bash
# Helper: encrypt a Kubernetes Secret with SOPS + age.
# Run from the repo root.
# Prerequisites: sops (https://github.com/getsops/sops), age (https://github.com/FiloSottile/age)
set -euo pipefail

KEY_FILE="${AGE_KEY_FILE:-age.key}"

if [[ ! -f "$KEY_FILE" ]]; then
  echo "Generating age key pair → $KEY_FILE"
  echo "Store the private key safely. Never commit it."
  age-keygen -o "$KEY_FILE"
fi

PUBLIC_KEY=$(grep "public key:" "$KEY_FILE" | awk '{print $4}')
echo "Public key: $PUBLIC_KEY"

echo ""
echo "Encrypting a sample secret..."
kubectl create secret generic hello-secret \
  --from-literal=API_KEY=supersecret \
  --dry-run=client -o yaml \
  | sops --encrypt \
         --age "$PUBLIC_KEY" \
         --input-type yaml \
         --output-type yaml \
         /dev/stdin \
  > labs/secrets/sops/example.enc.yaml

echo ""
echo "Encrypted Secret written to labs/secrets/sops/example.enc.yaml"
echo "You can safely commit this file. Decrypt with:"
echo "  SOPS_AGE_KEY_FILE=$KEY_FILE sops --decrypt labs/secrets/sops/example.enc.yaml"
