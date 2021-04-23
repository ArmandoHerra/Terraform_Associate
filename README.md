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

- This is useful when you want to cause a certain side effect of recreating that is not visible in the attributes of a resource. Like re-running a bootstrap script, change the instance's IP address, etc. Or simply because you want to make Terraform re-create a resource even if Terraform doesn't think it's necessary due to it's default behaviour.

- Usage: `terraform taint [options] address`

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

- The `terraform import` command will find the resource associated with the address provided and import it into your Terraform state.

- Usage: `terraform import [options] ADDRESS_ID`

The address must be a valid resource address that depends on the resource type that is trying to be imported. Check the provider documentation for more information.

- All of the command-line flags are optional. The list of available flags are:
  - `-backup=path` - Used to indicate the path to backup the existing state file.
  - `-config=path` - Path to directory of Terraform configuration files that configure the provider for import.
  - `-input=true` - Whether to ask for input for provider configuration.
  - `-lock=true` - Lock the state file when locking is supported.
  - `-lock-timeout=0s` - Duration to retry a state lock.
  - `-no-color` - If specified, output won't contain any color.
  - `-parallelism=n` - Limit the number of concurrent operations as Terraform walks the graph. Defaults to 10.
  - `-state=path` - Path to the source state file to read from.
  - `-state-out=path` - Path to the destination state file to write to.
  - `-var 'foo=bar'` - Set a variable in the Terraform configuration.
  - `-var-file=foo` - Set variables in the Terraform configuration from a variable file.
  - `-ignore-remote-version` - When using the enhanced remote backend with Terraform Cloud, continue even if remote and local Terraform versions differ. Use with extreme caution.

- No labs are provided since existing resources are required to run the commands and demonstrate their use.

- For more detailed information run `terraform import --help`

### 4d. Given a scenario: choose when to use `terraform workspace` to create workspaces

- Terraform configuration has an associated backend that defines how operations are executed and where persistent data such as the Terraform `state` are stored. The persistent data stored in the backend, the state, belongs to a `workspace`.

- Terraform workspaces allow you to store your Terraform state in multiple, separate, named workspaces. Terraform by default saves your state in a workspace called `default`.

- The `default` workspace cannot be deleted.

- Managing workspaces is done via the `terraform workspace` command.

- Usage: `terraform workspace [options] WORKSPACE_NAME`

- Depending on the option, you may not need to specify the workspace name.

- The available options for the `terraform workspace` command are the following:
  - `delete WORKSPACE_NAME` - Delete a specific workspace.
  - `list` - Lists available workspaces.
  - `new WORKSPACE_NAME` - Create a new workspace.
  - `select WORKSPACE_NAME` - Select a specific workspace.
  - `show` - Show the name of the current workspace.

- For more detailed information run `terraform workspace --help`

To get more hands on experience, come and try the available options in the [Lab](./Labs/Section-4/workspace/)

- Situations when are Multiple Workspaces useful and more information about Workspaces.

  - One use is to create a parallel copy of the infrastructure you are working on, in order to test a specific set of changes before modifying the main production infrastructure.

  - To work on and replicate the infrastructure for several environments, also for isolating the state files between environment resources as a best practice. Although workspaces do not solve all the problems, sometimes you will need to separate environment resources across several Cloud Provider Accounts as well.

### 4e. Given a scenario: choose when to use `terraform state` to view Terraform state

- The `terraform state` command is used for advanced state management.

- In some cases you will need to modify or work with the state files, so instead of editing them directly, you will manipulate them via the `terraform state` command.

- As you will later on discover, the `terraform state` command works the same with remote state as it were local state. Reads and writes may take longer, since the state needs to be retrieved before doind any state operations.

- Usage: `terraform state <subcommand> [options] [args]`

### Advanced State Management Overview

### Inspecting State

- For reading and updating the state, Terraform includes several commands.

- `terraform state list` - This command shows the resource addresses for every resource Terraform knows about in a configuration, optionally filtered by partial resource address.

- `terraform state show` - This command displays detailed state data about one resource.

- `terraform refresh` - This command updates the state data to match the real-world condition of the managed resources. This is done automatically during plans and applies, but not when interacting with state directly.

### Forcing Re-Creation (Tainting)

- As we say briefly in the `terraform taint` command, we can use the taint command to force re-creation of a resource during next apply if we think it's necessary.

- `terraform taint` - This command tells Terraform to destroy and re-create a resource on the next apply, regardless of the default strategy of Terraform to edit in-place if this was the case.

- `terraform untaint` - This command undoes a previously applied taint, this is mostly used if you tainted the incorrect resource or you no longer require tainting the resource.

### Moving Resources

- Terraform's state associates each real-world infrastructure piece with a configured resource at a specific resource address.

- But Terraform can lose track of a resource if you change it's name, move it to a different module, or change it's provider.

- In the case you want to preserve an existing infrastructure object, you can tell Terraform to associate it with a different configured resource.

- `terraform state mv` - This command changes which address in your configuration is associated with a particular real-world object. Use this to preserve an object when renaming a resource, or when moving a resource into or out of a child module.

- `terraform state rm` - This command tells Terraform to stop managing a resource as part of the current working directory and workspace, without actually destroying the corresponding real-world infrastructure object. If you need to recover management in a different workspace or project, you can use `terraform import`.

- `terraform state replace-provider` - This command transfers existing resources to a new provider without requiring them to be re-created.

### Disaster Recovery

- If something goes terribly wrong with your state files, you may need to take drastic actions to recover your state files.

- `terraform force-unluck` - This command can help you override the protection Terraform uses to prevent two processes from modifying the state file at the same time. You might need this command in the case that a Terraform process like a `terraform apply` is unexpectedly terminated and the state lock isn't released for the state backend. Do not run this command unless you are very sure about what occurred and that this can solve your state locking problem.

- `terraform state pull` - This command can help you read entire state files from the configured backend. You might need it to obtain a state backup.

- `terraform state push` - This command can help you write entire state files to the configured backend. You might need it to restore a state backup if the current state is not working.

### 4f. Given a scenario: choose when to enable verbose logging and what the outcome/value is

- When you are working on your usual day to day work and you notice some behaviour from Terraform that's unexpected or that doesn't work at all is the most common reason for why you might want to enable verbose logging to get a sense of what is going wrong.

- To enable verbose logging of the Terraform CLI you will need to set the `TF_LOG` environment variable to one of the following:

  - `TRACE`
  - `DEBUG`
  - `INFO`
  - `WARN`
  - `ERROR`

And setting the environment variable is done like this in a *nix system.

```
export TF_LOG=TRACE
```

- Note that when enabling other Log levels, we get the following message from the Terraform CLI

```
[WARN] Log levels other than TRACE are currently unreliable, and are supported only for backward compatibility.
  Use TF_LOG=TRACE to see Terraform's internal logs.
```

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

- When developing Terraform code in a project you will repeat many core steps before successfully configuring your Infrastructure, some of these steps are.
  
  - Writing your Initial Terraform configuration.
  - Initializing a Terraform directory.
  - Validating a Terraform configuration.
  - Generating and reviewing a Terraform execution plan.
  - Executing changes to Infrastructure with Terraform
  - Destroying Infrastructure with Terraform
  - Writing changes to your Terraform configuration.

- According to HashiCorp there exists a Core Terraform Workflow, whioch has three steps:

  1.- Write - Author infrastructure as code.
  
  2.- Plan - Preview changes before applying.

  3.- Apply - Provision reproducible infrastructure.

### 6b. Initialize a Terraform working directory (`terraform init`)

- This step is simple, it initializes a working directory that container Terraform configuration and takes care of installing providers, modules and initialize the corresponding configured backend.

- `terraform init`

### 6c. Validate a Terraform configuration (`terraform validate`)

- This step is used to validate if a Terraform configuration is valid, but does not access any remote services or check into any remote state, provider APIs, etc.

- Validate runs checks that verify whether a configuration is syntactically valid and internally consistent, regardless of any provided variables or existing state. It is thus primarily useful for general verification of reusable modules, including correctness of attribute names and value types.

- `terraform validate`

### 6d. Generate and review an execution plan for Terraform (`terraform plan`)

- Once you have validated your configuration, you are ready to create an execution plan.

- `terraform plan`

- This command is a convenient way to check whether the execution plan for a ser of changes matches your expectations without making any changes to real resources or to the state.

### 6e. Execute changes to infrastructure with Terraform (`terraform apply`)

- When you are ready to apply the changes you authored, you run the next command.

- `terraform apply`

- You can see an execution plan prior to running the command.

### 6f. Destroy Terraform managed infrastructure (`terraform destroy`)

- When you need to remove the Infrastucture you have been managing with Terraform, you run the destroy command.

- `terraform destroy`

- This command orders Cloud Providers to destroy/deprovision a resource, so be careful which resources you destroy!

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