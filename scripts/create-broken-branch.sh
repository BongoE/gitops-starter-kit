#!/usr/bin/env bash
# Creates (or recreates) the branch broken/troubleshooting-lab from main,
# replacing the healthy manifests with the deliberately broken ones in labs/broken-manifests.
# Run this once after cloning if the branch does not exist on the remote.
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"
BRANCH="broken/troubleshooting-lab"
START="$(git branch --show-current)"

git branch -D "$BRANCH" 2>/dev/null || true
git checkout -b "$BRANCH" main
rm -rf manifests/hello/base manifests/hello/overlays/dev
cp -r labs/broken-manifests/base manifests/hello/base
cp -r labs/broken-manifests/overlays/dev manifests/hello/overlays/dev
git add manifests
git commit -q -m "lab: introduce five deliberate bugs for troubleshooting practice"
git checkout -q "$START"
echo "Branch $BRANCH created. Push it with: git push -u origin $BRANCH"
