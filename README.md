# Terraform_Associate

## 1. Understand infrastructure as code (IaC) concepts
### 1a. Explain what IaC is
    - It is Infrastructure defined as code with it's underlying configuration in definition files.
### 1b. Describe advantages of IaC patterns
    - It makes working with Infrastructure, versionable, automatable and reusable.

---

## 2. Understand Terraform's purpose (vs other IaC)
### 2a. Explain multi-cloud and provider-agnostic benefits
    - Multi-cloud support allows for creating multi-cloud architectures, leveraging the benefits of several clouds or a hybrid cloud.

    - Being provider-agnostic also allows the tool to be used by more providers that create their own plugins to manage their Infrastructure/Tools via Terraform.
### 2b. Explain the benefits of state
    - State allows for the mapping of the current configuration of the Infrastructure with the Definition File Representation.

    - Terraform State besides tracking resources can track metatada such as resource dependencies.

---

## 3. Understand Terraform basics
### 3a. Handle Terraform and provider installation and versioning
### 3b. Describe plugin based architecture
### 3c. Demonstrate using multiple providers
### 3d. Describe how Terraform finds and fetches providers
### 3e. Explain when to use and not use provisioners and when to use `local-exec` or `remote-exec`