# Exercise 03: Rollback is a revert (5 minutes)

**Goal:** roll back without touching the cluster.

1. Make a bad change in Git: set `replicas` to 0 in the dev overlay via a patch, or change the image tag to something wrong. Commit and push.
2. Watch it break in Argo CD.
3. Roll back:
   ```bash
   git revert HEAD
   git push
   ```
4. Watch it heal.

**What you just proved:** rollback is a reviewed, logged, reversible change like any other. Compare that with "find the last good image tag in the registry at 2am".

**Also try:** the History and Rollback button in the Argo CD UI. Notice it warns you that rolling back in the UI disables auto-sync, because now the cluster and Git disagree. Git wins in GitOps, so the proper rollback is always in Git.
