#!/bin/bash

nvm_repo_path="${HOME}/.local/src/nvm"

my_pwd=$(pwd)

continue_on() {
	case "$1" in
		[Yy])
			return 0
			;;
		*)
			return 1
			;;
	esac
}

mkdir -p "${nvm_repo_path}"
git clone https://github.com/nvm-sh/nvm.git "${nvm_repo_path}"
