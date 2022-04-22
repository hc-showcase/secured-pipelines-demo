#!/bin/sh

tf() {

}

cmd() {

}

case $1 in
	tf)
		tf;;
	cmd)
		cmd;;
	*)
		echo "cmd for command line, tf for terraform";;
esac
