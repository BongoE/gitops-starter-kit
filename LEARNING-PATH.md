# Learning path: GitOps from zero to "I can teach it"

## Start (weeks 1 to 2)
- Git until `revert` does not scare you: branch, commit, PR, revert.
- Build and run one container.
- Kubernetes basics: Deployment, Service, ConfigMap, Namespace. TechWorld with Nana's Kubernetes crash course is the standard entry point.
- Read the four OpenGitOps principles at https://opengitops.dev. Explain them to a friend without saying "Kubernetes" or "YAML".

## Middle (weeks 3 to 5)
- Run this kit. Do exercises 01 to 03.
- Watch TechWorld with Nana's Argo CD tutorial, then redo exercise 01 without the video.
- Do the broken branch (exercise 04). Take your time. This is the part that changes how you think.
- Install Flux once on a fresh kind cluster (Flux "Get Started" docs) so you know the other mental model.

## End (weeks 6 to 8)
- Exercises 05 and 06.
- Add a GitHub Actions job that builds your own image and opens a PR updating the dev overlay.
- Watch one DevOps Toolkit (Viktor Farcic) video on Argo CD vs Flux and write a one-page opinion.
- Read Container Solutions' "GitOps: the bad and the ugly" and list which pitfalls your setup has.

## Teachers, and when to use them
| Teacher | Use when |
|---|---|
| TechWorld with Nana | You are starting. Diagrams before commands. |
| KodeKloud | You want browser labs and certification structure (CKA). |
| DevOps Toolkit (Viktor Farcic) | You already run pods and want platform-level opinions. |
| That DevOps Guy | You are on Azure. |
| Vishakha Sadhwani's GitOps crash course | You want Argo CD and Flux in one sitting with a project repo. |
| Akuity's channel | You chose Argo CD and want current, official-adjacent tutorials. |
| CNCF YouTube (KubeCon talks) | You need real-world case studies to convince a manager. |

## The project to build
A public repo of your own: kind cluster, Argo CD via a root Application, one app in dev and prod, CI that builds the image, a secrets pattern, and a README explaining "before GitOps" and "after GitOps" in your own words. Fork this kit as the skeleton.

That README is worth more to a hiring manager than a certificate.

## Where to stop
When you can teach it. Not before.
