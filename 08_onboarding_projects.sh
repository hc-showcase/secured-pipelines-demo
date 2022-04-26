#!/bin/sh
set -x
on() {
    cloud=$1
    project_name=$2
    base_path=08_onboarding_projects/$cloud
    blueprint_path=$base_path/project-blueprint/
    project_path=$base_path/projects/$project_name
    terraform_state=projects/$project_name/terraform-state

    mkdir -p $project_path
    cp -r $blueprint_path/* $project_path
    cd $base_path
    terraform init
    terraform apply -var=project_name=$project_name -state=$terraform_state
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
	on $2 $3
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
