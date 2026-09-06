# gitops-starter-kit

**GitOps explained by someone who runs it in production, for people who have never touched a cluster.**

One command gives you a local Kubernetes cluster, Argo CD, and a sample app deployed from this repo. Then six short exercises walk you from "what is GitOps" to fixing a deliberately broken deployment the way a platform engineer would.

Built by [Endah Bongo-Awah](https://www.linkedin.com/in/endah-bongo-awah) (Cloud Platform Engineer, AWS Community Builder, founder of Mentorship Matters Africa) to accompany a two-week LinkedIn series on GitOps. No vendor. No hype. Free forever.

> **If you learn one thing here:** the cluster is a projection of Git. Change Git, the cluster follows. Change the cluster by hand, Git wins.

## Quick start (about 5 minutes after prerequisites)

```bash
git clone https://github.com/BongoE/gitops-starter-kit.git
cd gitops-starter-kit
make up        # kind cluster + Argo CD + root Application
make login     # prints the admin password, port-forwards the UI to https://localhost:8080
```
Then open http://localhost:30080 to see the sample app, and start with `exercises/01-first-sync.md`.

Prerequisites (Docker, kind, kubectl, kustomize): see [docs/PREREQUISITES.md](docs/PREREQUISITES.md).
Tear everything down with `make down`. Your laptop is untouched apart from one Docker container.

## What is in here

```
kind/         one-node local cluster definition
bootstrap/    (reserved) alternative Argo CD install options
argocd/       root-app.yaml: the App of Apps that bootstraps everything
apps/         one Argo CD Application per environment (dev auto-syncs, prod waits for a human)
manifests/    the sample app: kustomize base + dev/prod overlays
exercises/    01 first sync, 02 drift, 03 rollback, 04 troubleshooting, 05 promotion, 06 secrets
labs/         the broken-on-purpose manifests and the solutions (spoilers behind a click)
docs/         glossary in plain English, decisions log, prerequisites, GitOps beyond Kubernetes
scripts/      setup, teardown, login, create-broken-branch
.github/      CI that validates every manifest on each PR (this is the "CI" half of CI/CD)
```

## The exercises

| # | Exercise | Time | You will feel |
|---|---|---|---|
| 01 | [First sync](exercises/01-first-sync.md) | 10 min | Git becoming the cluster |
| 02 | [Drift](exercises/02-drift.md) | 5 min | Your manual edit being reverted |
| 03 | [Rollback](exercises/03-rollback.md) | 5 min | `git revert` as a deploy tool |
| 04 | [Troubleshooting lab](exercises/04-troubleshooting.md) | 30 to 60 min | Five layered bugs, five tools to find them |
| 05 | [Promotion](exercises/05-promotion.md) | 15 min | Environments as folders, humans as gates |
| 06 | [Secrets](exercises/06-secrets.md) | 10 min | Why this repo has none, and what to add |

## The broken branch

`broken/troubleshooting-lab` is the same app with five deliberate bugs, layered so fixing one reveals the next. Point `hello-dev` at that branch and work your way to green. Instructions in [labs/README.md](labs/README.md). Solutions in [labs/SOLUTIONS.md](labs/SOLUTIONS.md), hidden behind spoiler tags.

Finished it? Post your five commits on LinkedIn and tag me. That is a portfolio piece, not a tutorial.

## Learning path

See [LEARNING-PATH.md](LEARNING-PATH.md) for where to start, where to stop, which YouTube teachers to use for what, and the one project to build for interviews.

## Fork it, break it, improve it

- Star the repo if it helped. It tells the next beginner it is worth their time.
- Stuck? Open an issue with the "I'm stuck" template. Real questions from beginners make the kit better.
- Add a secrets pattern, a Flux variant, a Helm version of the app, or a new bug for the lab. PRs from first-time contributors are welcome and reviewed kindly.

## Licence

MIT. Use it in your team, your bootcamp, your own tutorials. A link back is appreciated, never required.
