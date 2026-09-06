# Exercise 06: Secrets, the thing this repo deliberately does not do (reading, 10 minutes)

There are no secrets in this repo, on purpose. That is the correct starting point.

The rule: **never commit a plaintext Secret to a GitOps repo.** Git history is forever, and public forks are forever.

Three patterns, in order of how often you will meet them:
1. **External Secrets Operator**: secret lives in AWS Secrets Manager / Vault; Git holds only a reference. Most common in cloud teams.
2. **SOPS + age/KMS**: the encrypted secret *is* in Git; the controller decrypts at sync time. Flux supports this natively, Argo via a plugin.
3. **Sealed Secrets**: encrypt with a cluster public key; only that cluster can decrypt.

**Task:** pick one, read its README, and write in `docs/DECISIONS.md` which one you would choose for a team on AWS and why. Then, if you feel brave, add it to this kit and open a PR.
