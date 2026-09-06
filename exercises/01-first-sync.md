# Exercise 01: Your first sync (10 minutes)

**Goal:** see Git become the cluster.

1. Run `make up`. Wait for the summary box.
2. Run `make login` in a second terminal, open https://localhost:8080, log in as `admin`.
3. You should see three Applications: `root`, `hello-dev`, `hello-prod`.
   - `root` is the App of Apps. It created the other two from the `apps/` folder.
   - `hello-dev` should be Synced and Healthy within a minute.
   - `hello-prod` is OutOfSync on purpose. Leave it for now.
4. Open http://localhost:30080. You should see podinfo with the DEV message.
5. Now change something **in Git**: edit `manifests/hello/overlays/dev/kustomization.yaml`, change the message text, commit, push to `main`.
6. Watch Argo CD. Within about three minutes (default poll interval) the app goes OutOfSync, then syncs itself. Refresh the browser.

**What you just proved:** rule 3 (pull) and rule 1 (declarative). You never ran `kubectl apply`.

**Speed it up (optional):** in the UI click Refresh on `hello-dev` instead of waiting for the poll.
