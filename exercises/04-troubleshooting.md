# Exercise 04: The broken branch (30 to 60 minutes)

**Before you start:** switch `hello-dev` to the broken branch.

In `apps/hello-dev.yaml`, change `targetRevision: main` to `targetRevision: broken/troubleshooting-lab`,
then push. Argo CD will re-sync and show errors — that is expected and is the whole point.

If the branch does not exist yet:
```bash
make broken-branch
git push -u origin broken/troubleshooting-lab
```

Then go to `labs/README.md`. Five bugs, layered. Fix them all in Git.

When you finish, switch `apps/hello-dev.yaml` back to `targetRevision: main` and push.

This is the exercise to put on LinkedIn. Screenshot your five commits.

