# Terraform ChatOps using Github Actions

This repo shows a simple `static_site.tf` that creates an tiny
[index.html](https://storage.googleapis.com/my-static-site/index.html)
using a GCP bucket. Instead of calling `terraform apply` locally (on the
developer's laptop) or on some CI, we want to give a bit more interactivity
and use the "ChatOps" approach which brings a higher level of transparency
(who did what and when). This idea comes from using
[Prow](https://github.com/kubernetes/test-infra/tree/master/prow), the
ChatOps bot that powers all Kubernetes repositories.

It goes like this:

1. When a PR is opened, `terraform plan` is run and shown as a PR comment.
1. If `/apply` is sent as a comment in that PR, `terraform apply` is run.
1. The `/apply` command only works after someone from the `CODEOWNERS` has
   approved this PR.
1. Merging the PR does not trigger anything else.

> ⚠ Since I use `GITHUB_TOKEN` to create/update the bot's comments, it
> won't work for PRs created from forks (see [GITHUB_TOKEN
> restrictions](https://help.github.com/en/actions/configuring-and-managing-workflows/authenticating-with-the-github_token#permissions-for-the-github_token))

Here is what it looks like in a
[PR](https://github.com/maelvls/gh-actions-chatops/pull/1):

<img width="751" alt="This image is stored in the description of https://github.com/maelvls/gh-actions-chatops/issues/2" src="https://user-images.githubusercontent.com/2195781/81424107-b5689880-9155-11ea-8b2e-a4a0dce10365.png">

