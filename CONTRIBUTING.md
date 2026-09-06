# Contributing

This kit exists for beginners. Contributions are judged on one question: does this make the next beginner's first hour easier?

Good first contributions:
- A new bug for the troubleshooting lab (with a solution entry).
- A Flux variant of `apps/` and `argocd/`.
- A Helm version of the sample app.
- A secrets pattern (External Secrets, SOPS or Sealed Secrets) as exercise 07.
- Fixing anything in the docs that confused you. If it confused you it will confuse others.

Rules:
- Run `make validate` before opening a PR. CI runs the same check.
- No `latest` tags. No plaintext secrets. No em-dashes in docs (house style).
- Be kind in reviews. Many contributors here are making their first PR ever.
