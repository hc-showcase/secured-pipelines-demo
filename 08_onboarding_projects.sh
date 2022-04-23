#!/bin/sh
set -x
on() {
	project_name=$1
	mkdir -p 08_onboarding_projects/projects/$project_name
	cp -r 08_onboarding_projects/project-blueprint/* 08_onboarding_projects/projects/$project_name
	cd 08_onboarding_projects
	terraform init
	terraform apply -var=project_name=$project_name -state=projects/$project_name/terraform-state
}

off() {
	project_name=$1
	cd 08_onboarding_projects/
	terraform destroy -var=project_name=$project_name -state=projects/$project_name/terraform-state
 	rm -rf 08_onboarding_projects/projects/$project_name
}

cmd() {
	echo
}

case $1 in
on)
	on $2
	;;
off)
	off $2
	;;
cmd)
	cmd
	;;
cleanup)
	cd 08_onboarding
	terraform destroy
	;;
*)
	echo "cmd for command line, onb for onboarding, cleanup for cleanup"
	;;
esac
