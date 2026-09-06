#!/usr/bin/env bash
# Deletes the kind cluster. Nothing else on your machine is touched.
set -euo pipefail
kind delete cluster --name gitops-starter
echo "Cluster deleted. Your Git repo is untouched, which is the whole point."
