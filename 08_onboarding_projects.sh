#!/bin/sh
. 99_source_temp_data.sh

on() {
    cloud=$1
    project_name=$2
    base_path=08_onboarding_projects/$cloud
    blueprint_path=$base_path/project-blueprint/
    project_path=$base_path/projects/$project_name
    terraform_state=projects/$project_name/terraform-state

    mkdir -p $project_path
    cp -r $blueprint_path/* $project_path
    cd $base_path/setup
    terraform init
    terraform apply -auto-approve -var=project_name=$project_name -state=$terraform_state
}

off() {
    cloud=$1
    project_name=$2
    base_path=08_onboarding_projects/$cloud
    blueprint_path=$base_path/project-blueprint/
    project_path=$base_path/projects/$project_name
    terraform_state=projects/$project_name/terraform-state

    cd $base_path/setup
    terraform destroy -var=project_name=$project_name -state=$terraform_state
    rm -rf projects/$project_name
    cd -
    rm -rf $project_path
}

cmd() {
	echo
}

case $1 in
on)
	on $2 $3
	;;
off)
	off $2 $3
	;;
cmd)
	cmd
	;;
*)
	echo "cmd for command line, on for onboarding, off for offboarding"
	;;
esac
