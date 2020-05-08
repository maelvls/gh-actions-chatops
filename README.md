# Terraform ChatOps using Github Actions

- ChatOps-based workflow inspired by [Prow](https://github.com/kubernetes/test-infra/tree/master/prow).
- When a PR is opened, `terraform plan` is run and shown as a PR comment.
- If `/apply` is sent as a comment in that PR, `terraform apply` is run.
- The `/apply` command only works after someone from the CODEOWNERS has
  approved this PR.
- Merging the PR does not trigger anything else.

Here is what it looks like in a
[PR](https://github.com/maelvls/gh-actions-chatops/pull/1):

<img width="751" alt="This image is stored in the description of https://github.com/maelvls/gh-actions-chatops/issues/2" src="https://user-images.githubusercontent.com/2195781/81424107-b5689880-9155-11ea-8b2e-a4a0dce10365.png">
