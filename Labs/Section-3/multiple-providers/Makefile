#!/bin/bash

lab:
	terraform --version 			&& \
	aws s3 ls 						&& \
	terraform init					&& \
	terraform plan					&& \
	terraform apply -auto-approve	&& \
	sleep 180						&& \
	terraform destroy -auto-approve
