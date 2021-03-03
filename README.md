# Terraform_Associate

## 1. Understand infrastructure as code (IaC) concepts

### 1a. Explain what IaC is
- It is the idea of managing infrastructure defined in a file or set a files, hence the name Infrastructure as Code, instead of managing the pieces by hand.
### 1b. Describe advantages of IaC patterns
- It makes working with Infrastructure, versionable, automatable and reusable. It also can be shared with the organization and it helps you keep track of the changes in the Infrastructure.

---

## 2. Understand Terraform's purpose (vs other IaC)

### 2a. Explain multi-cloud and provider-agnostic benefits
- Multi-cloud support allows for creating multi-cloud architectures, leveraging the benefits of several clouds or a hybrid cloud.

- Being provider-agnostic also allows the tool to be used by more providers that create their own plugins to manage their Infrastructure/Tools via Terraform.

### 2b. Explain the benefits of state
- State allows for the mapping of the current configuration of the Infrastructure with the Definition File Representation.

- Terraform State besides tracking resources can track metatada such as resource dependencies.

- It can also be cached locally so the state doesn't loose track of the current state of the resources, increasing performance when running `terraform plan`

---

## 3. Understand Terraform basics

### 3a. Handle Terraform and provider installation and versioning
- The recommended way to handle the definition, installation and versioning of a provider is by using the `required_providers` block. Example. Note, this works for Terraform version 0.13 and above.

```
terraform {
  required_providers {
    mycloud = {
      source  = "mycorp/mycloud"
      version = "~> 1.0"
    }
  }
}
```

- For versions 0.12.
```
terraform {
  required_providers {
    aws = "~> 1.0"
  }
}
```

### 3b. Describe plugin based architecture
- Terraform is built on a plugin-based architecture so developers can create and extend Terraform's functionality.

- There exist two main parts to Terraform: `Terraform Core` and `Terraform Plugins`.

### 3c. Demonstrate using multiple providers
- [Lab](./Labs/Section-3/multiple-providers/)

### 3d. Describe how Terraform finds and fetches providers
- When `terraform init` is run, Terraform reads the existing configuration files to determine which plugins are going to be used or have been required in the project. It searches for the plugins, it downloads them, and installs the determined pinned or version from the allowed version range. Finally, it writes a lock file to ensure Terraform will use the same plugin versions in the working directory until `terraform init` is run again.

- There are three types of provisioners/plugins.
    - Built-in provisioners. Which are always available, since they are included in the Terraform binary.
    - Providers distributed by HashiCorp . Which are automatically downloaded if not already installed/present.
    - Third-party providers and provisioners. They must always be manually installed.

### 3e. Explain when to use and not use provisioners and when to use `local-exec` or `remote-exec`

- The `local-exec` provisioner invokes a local executable command after a resource is created. Note that the process is run on the local machine where Terraform is being used, not the resources Terraform is managing.

- The `remote-exec` provisioner invokes a command on a remote resource after it is created. This can help running the first commands required for configuration management tools, initial bootstraping, etc. The commands are executed via `ssh` or `winrm` connections.

---

## 4. Use the Terraform CLI (outside of core workflow)

### 4a. Given a scenario: choose when to use `terraform fmt` to format code

- The `terraform fmt` command is used to rewrite the Terraform configuration files, applying some language style conventions and other adjustments for a standard and consistent format.

- The formatting may change between versions.
  - Eg. `0.12.X vs 0.13.X` or `0.13.X vs 0.14.X`
  - So it may be wise to run `terraform fmt` when upgrading Terraform versions.

- Usage: `terraform fmt [options] [DIR]` (Default DIR is current DIR)
  - `-list=false` - This option allows you to not list files that have formatting differences.
  - `-write=false` - When you run the command with this option, it doesn't overwrite the files, but does tell you which don't have the standard format.
  - `-diff` - With this option enabled you display a diff of the formatting changes that you are wanting to take place.
  - `-check` - This option allows you to "check" if the files have correct formatting, no rewriting is taken place, if they don't it will return a non-zero exit code, this can be used for linting scripts or tools.
  - `-recursive` - When using this option, you also enable the formatting to process files in subdirectories. Useful when dealing with multiple folder/file layouts.

For more detailed information run `terraform fmt --help`

To get more hands on experience come and try the commands and the options in the [Lab](./Labs/Section-4/fmt/)


### 4b. Given a scenario: choose when to use `terraform taint` to taint Terraform resources

- The `terraform taint` command manually marks a resource that is being managed by Terraform as a `tainted` resource, a `tainted` resource is forced to be destroyed and recreated on the next apply.

- The command itself does not modify the infrastructure, it marks the state file so Terraform knows what to do to the resource after the next plan/apply.

- This is useful when you want to cause a certain side effect of recreating that is not visible in the attributes of a resource. Like re-running a bootstrap script, change the instance's IP address, etc.

- Usage `terraform taint [options] address`

- The `address` argument is the address of the resource to taint.

- All of the command-line flags are all optional.
  - `-allow-missing` - If specified, the command will succeed even if the resource is missing. It will only error in extreme erroneous cases.
  - `-backup=path` - Path to the backup file. Defaults to `-state-out` with the ".backup" extension. Disabled by setting to "-".
  - `-lock=true` - Lock the state file when locking is supported.
  - `-lock-timeout=0s` - Duration to retry a state lock.
  - `-state=path` - Path to read and write the state file to. Ignored when remote state is used.
  - `-state-out=path` - Path to write updated state file. By default, the `-state` path will be used. Ignored when remote state is used.
  - `-ignore-remote-version` - When using the enhanced remote backend with Terraform Cloud, continue even if remote and local Terraform versions differ. Use with extreme caution.

- Tainting a single resource can be done like this: `terraform taint aws_instance.foo.instance_name`

- Tainting a specific instance from a list of similar resources can be done like this: `terraform taint aws_instance.instance_naame[1]`

- Tainting a resource within a module can be done like this: `terraform taint module.module_name.aws_instance.instance_name`

- For more detailed information run `terraform taint --help`

To get more hands on experience come and try the commands and the options in the [Lab](./Labs/Section-4/taint/)


### 4c. Given a scenario: choose when to use `terraform import` to import existing infrastructure into your Terraform state

### 4d. Given a scenario: choose when to use `terraform workspace` to create workspaces
### 4e. Given a scenario: choose when to use `terraform state` to view Terraform state
### 4f. Given a scenario: choose when to enable verbose logging and what the outcome/value is

---

## 5. Interact with Terraform modules

### 5a. Contrast module source options
### 5b. Interact with module inputs and outputs
### 5c. Describe variable scope within modules/child modules
### 5d. Discover modules from the public Terraform Module Registry
### 5e. Defining module version

---

## 6. Navigate Terraform workflow

### 6a. Describe Terraform workflow ( Write -> Plan -> Create )
### 6b. Initialize a Terraform working directory (`terraform init`)
### 6c. Validate a Terraform configuration (`terraform validate`)
### 6d. Generate and review an execution plan for Terraform (`terraform plan`)
### 6e. Execute changes to infrastructure with Terraform (`terraform apply`)
### 6f. Destroy Terraform managed infrastructure (`terraform destroy`)

---

## 7. Implement and maintain state

### 7a. Describe default local backend
### 7b. Outline state locking
### 7c. Handle backend authentication methods
### 7d. Describe remote state storage mechanisms and supported standard backends
### 7e. Describe effect of Terraform refresh on state
### 7f. Describe `backend` block in configuration and best practices for partial configurations
### 7g. Understand secret management in state files

---

## 8. Read, generate, and modify configuration

### 8a. Demonstrate use of variables and outputs
### 8b. Describe secure secret injection best practice
### 8c. Understand the use of collection and structural types
### 8d. Create and differentiate `resource` and `data` configuration
### 8e. Use resource addressing and resource parameters to connect resources together
### 8f. Use Terraform built-in functions to write configuration
### 8g. Configure resource using a `dynamic` block
### 8h. Describe built-in dependency management (order of execution based)

---

## 9. Understand Terraform Cloud and Enterprise capabilities

### 9a. Describe the benefits of Sentinel, registry, and workspaces
### 9b. Differentiate OSS and TFE workspaces
### 9c. Summarize features of Terraform Cloud


---