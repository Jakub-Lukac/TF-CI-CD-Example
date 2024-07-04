# Terraform CI/CD pipeline for multiple customers

## Project Overview

This Demo project demostrates how to `use one IaC (Infrastructure as Code) for multiple customers` and automate it using CI/CD pipeline. Part of the project is also use of `OIDC (Open ID Connect)` method to login to Azure portal.

# OIDC Setup

## Azure Portal

Navigate to Azure Portal -> Entra ID (AAD) -> App Registration -> Create or use an existing app -> `Certificates & Secrets -> Federate Credentials` -> Create 3 Credentials (branch-main, environemt-staging, environment-prod).

As a scenario select `GitHub Actions deploying Azure resources`, Organization is the name of the GitHub account. Then fill the rest of the fields. As for the credential name selecet whatever means your organization naming standards.

```text
oidc-8118741            repo:Jakub-Lukac/TF-CI-CD-Example:ref:refs/heads/main
oidc-staging-987789     repo:Jakub-Lukac/TF-CI-CD-Example:environment:staging
oidc-prod-987789        repo:Jakub-Lukac/TF-CI-CD-Example:environment:prod
```

# CI/CD Pipeline Setup

## GitHub Secrets

Navigate to your repository, go to Settings -> Secrets and Variables -> Actions.

### Secrets

In here create **ARM** and **BACKEND** secrets</br>
ARM_CLIENT_SECRET is represented in var.tf file by the env_client_secret variable.

**Important to note**, like client secret, app ID, tenant ID, subscription ID, **MUST** start with phrase **ARM**

```text
ARM_CLIENT_ID
ARM_CLIENT_SECRET
ARM_SUBSCRIPTION_ID
ARM_TENANT_ID

BACKEND_RESOURCE_GROUP_NAME
BACKEND_STORAGE_ACCOUNT_NAME
BACKEND_STORAGE_CONTAINER_NAME
TF_BACKEND_KEY
BACKEND_ACCESS_KEY
```

## Pipeline Overview

The CI/CD pipeline takes advantage of built-in feature of GitHub Actions to specify `inputs for the workflow`. Each input represents a single customer. Based on this input parameter the `corresponding .tfvars, .out files` are used. Additionally, the `corresponding workspace` is selected, **if the workspace does not exists yet, then it is created.**

## GitHub repository environemts

The CI/CD Pipeline consits of two jobs, `terraform_plan` and `terraform_apply`, each run in different environment. `terraform_plan` runs in the `staging` environemt, and `terraform_apply` runs in the `prod` environemt. The `prod` environment has been assigned protection rule **(Only the designated reviewer can run the job)**. The purpose of this step is to ensure that the reviewer checks if `terraform_plan` outputs expected plan and then applies it inside the `terraform_apply`.
