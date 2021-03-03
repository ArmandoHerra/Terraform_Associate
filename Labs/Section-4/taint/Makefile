#!/bin/bash

lab:
	terraform --version 					&& \
	aws s3 ls 								&& \
	terraform init							&& \
	terraform plan							&& \
	sleep 90								&& \
	terraform apply -auto-approve			&& \
	sleep 90								&& \
	terraform taint aws_instance.instance	&& \
	terraform plan							&& \
	terraform apply -auto-approve			&& \
	sleep 90								&& \
	terraform destroy -auto-approve
