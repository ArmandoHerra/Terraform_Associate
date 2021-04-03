#!/bin/bash

lab:
	terraform --version 						&& \
	aws s3 ls 									&& \
	terraform init								&& \
	terraform plan								&& \
	terraform apply -auto-approve				&& \
	terraform workspace list					&& \
	terraform workspace show					&& \
	terraform workspace new test_workspace_1	&& \
	terraform workspace list					&& \
	terraform workspace show					&& \
	terraform plan								&& \
	terraform apply -auto-approve				&& \
	terraform workspace select default			&& \
	terraform workspace new prod_workspace_1	&& \
	terraform plan								&& \
	terraform apply -auto-approve				&& \
	sleep 240									&& \
	terraform destroy -auto-approve				&& \
	terraform workspace select test_workspace_1	&& \
	terraform workspace list					&& \
	terraform workspace delete prod_workspace_1	&& \
	terraform workspace list					&& \
	terraform destroy -auto-approve				&& \
	terraform workspace select default			&& \
	terraform workspace delete test_workspace_1	&& \
	terraform destroy -auto-approve				&& \
	terraform workspace list