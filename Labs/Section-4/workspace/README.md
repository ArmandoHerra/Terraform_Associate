# Instructions to run and use this lab.

1.- Check if you have Terraform installed by running `terraform --version`, if you have terraform installed you should see the version you have as a result, ideally you should have Terraform version `0.13` or later, the lab was developed on version `0.14.X`.

2.- To test the entire lab just run `make lab` and check step by step what occurs. 


If you want to run the steps individually, here they are:

```
- terraform plan
- terraform apply -auto-approve
- terraform workspace list
- terraform workspace show
- terraform workspace new test_workspace_1
- terraform workspace list
- terraform workspace show
- terraform plan
- terraform apply -auto-approve
- terraform workspace select default
- terraform workspace new prod_workspace_1
- terraform plan
- terraform apply -auto-approve
- terraform destroy -auto-approve
- terraform workspace select test_workspace_1
- terraform workspace list
- terraform workspace delete prod_workspace_1
- terraform workspace list
- terraform destroy -auto-approve
- terraform workspace select default
- terraform workspace delete test_workspace_1
- terraform destroy -auto-approve
- terraform workspace list
```

Note that when creating resources in several workspaces, your state files for the multiple workspaces will be saved in a directory called `terraform.tfstate.d`

And that the state that is handled by the `default` workspace is saved in the current directory under the following name: `terraform.tfstate`