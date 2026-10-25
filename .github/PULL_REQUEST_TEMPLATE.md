## What does this PR do?

<!-- One or two sentences. "Adds X", "Fixes Y", "Updates Z". -->

## Why?

<!-- What gap does this close, or what exercise does this improve? -->

## Type of change

- [ ] Bug fix (broken manifest, bad link, wrong command)
- [ ] Exercise improvement (clearer instructions, better prompts)
- [ ] New lab content (new bugs, new secrets pattern, new overlay)
- [ ] New bootstrap option (Helm, Flux, etc.)
- [ ] Docs / glossary update
- [ ] CI / workflow change
- [ ] Other (describe below)

## Checklist

- [ ] `make validate` passes locally (or I have confirmed it passes in CI)
- [ ] If I added or changed a Kustomize overlay, I ran `kustomize build <overlay-path>` and it exits 0
- [ ] If I added a new exercise or lab, the instructions point to real files in the repo
- [ ] I have not committed any plaintext secrets, credentials, or personal access tokens
- [ ] My changes follow the existing naming conventions (folders, file names, YAML style)

## Screenshots / output (optional)

<!-- Paste a terminal snippet or ArgoCD screenshot if it helps the reviewer understand the change. -->

## Notes for the reviewer (optional)

<!-- Anything the reviewer should know before merging, e.g. "this adds a bug that only manifests after fixing bug 3". -->
