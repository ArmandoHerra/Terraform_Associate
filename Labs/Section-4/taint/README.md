# Instructions to run and use this lab.

1.- Check if you have Terraform installed by running `terraform --version`, if you have terraform installed you should see the version you have as a result, ideally you should have Terraform version `0.13` or later, the lab was developed on version `0.14.X`.

2.- To test the entire lab just run `make lab` and check step by step what occurs. The most important steps are:

```    
- terraform plan
- terraform apply -auto-approve
- terraform taint aws_instance.instance (Here we taint the resource)
- terraform plan (We run another plan to see the change that will occur after tainting the resource)
- terraform apply -auto-approve (We apply the changes and the tainted resource is recreated)
- terraform destroy -auto-approve
```

If you want to run the steps by hand run the following steps in order to make sure all the prerequisites are covered.

```
terraform --version
aws s3 ls
terraform init
terraform plan
terraform apply -auto-approve
terraform taint aws_instance.instance
terraform plan
terraform apply -auto-approve
terraform destroy -auto-approve
```