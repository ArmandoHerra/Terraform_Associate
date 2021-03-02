# Instructions to run and use this lab.

1.- Check if you have Terraform installed by running `terraform --version`, if you have terraform installed you should see the version you have as a result, ideally you should have Terraform version `0.13` or later, the lab was developed on version `0.14.X`.

- I will list a few different combinations and the use cases for the `terraform fmt` and it's available options.

- `terraform fmt -list=false -write=false` should output the blocks of code that don't have any formatting differences. We use `-write=false` as well, because if we don't, we end up formatting the files that have formatting mistakes under the current directory, which would be `main.tf` and `variables.tf`.

- `terraform fmt -write=false` should output the names of the two files that contain formatting differences from the standard style conventions. For this lab, you should see.
    - `main.tf`
    - `variables.tf`

- `terraform fmt -diff -write=false` should output a diff of the changes that would be applied if we did not add the `-write=false` option, for the same reason explained above.

Diff Example
```
main.tf
--- old/main.tf
+++ new/main.tf
@@ -1,13 +1,13 @@
 data "aws_ami" "centos_east" {
   most_recent = true
 
-   filter {
-     name   = "name"
-     values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
-}
+  filter {
+    name   = "name"
+    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
+  }
 
   filter {
-   name   = "virtualization-type"
+    name   = "virtualization-type"
     values = ["hvm"]
   }
 
@@ -15,9 +15,9 @@
 }
 
 resource "aws_instance" "east_instance" {
-    ami           = data.aws_ami.centos_east.id
-    instance_type = var.instance_size
-    tags = {
-      Lab = var.lab_name
-    }
+  ami           = data.aws_ami.centos_east.id
+  instance_type = var.instance_size
+  tags = {
+    Lab = var.lab_name
+  }
 }
\ No newline at end of file
variables.tf
--- old/variables.tf
+++ new/variables.tf
@@ -1,7 +1,7 @@
 variable "lab_name" {
-    type = string
+  type = string
 }
 
 variable "instance_size" {
- type = string
+  type = string
 }
\ No newline at end of file
```

- `terraform fmt -check` should output the name of both of the files with formatting differences. For this lab, you should see.
    - `main.tf`
    - `variables.tf`
    - To see what exit code resulted from the previous command, on *nix systems you can run `echo $?` to see what non-zero exit code you got (if formatting differences are found).

- `terraform fmt -recursive -diff -write=false` should output the diff of 3 files, one of them in a subdirectory, but without rewritng any of the files.
    - The 3 files with differences are:
        - `main.tf`
        - `variables.tf`
        - `vars/generic.tfvars`

- `terraform fmt -recursive -check` should output the additional name of the `generic.tfvars` file.
    - To see what exit code resulted from the previous command, on *nix systems you can run `echo $?` to see what non-zero exit code you got (if formatting differences are found).

- `terraform fmt -recursive` for formatting the project and it's subdirectories entirely.