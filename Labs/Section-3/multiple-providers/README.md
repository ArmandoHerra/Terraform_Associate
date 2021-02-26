# Instructions to run this lab.

1.- Check if you have Terraform installed `terraform --version`, ideally you should have Terraform version 0.13 or later.

2.- Have the AWS CLI configured, run `aws s3 ls` and if you get a list of buckets from your account, your CLI is correctly configured.

3.- Once these steps have been verified, start by initializing the Terraform project with `terraform init`

4.- Once the providers have been installed, run `terraform plan` and you should see a Terraform output for 2 new resources.

5.- Run `terraform apply -auto-approve` in order to apply and deploy the defined resources in this lab.

6.- Verify that 2 EC2 instances have been created, 1 in the `us-east-1` region and the other instance in the `us-west-2` region.

7.- In this lab we are demonstrating how you use and declare multiple providers.

8.- To destroy the lab resources run `terraform destroy -auto-approve`