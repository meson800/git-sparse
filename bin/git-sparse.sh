#!/bin/sh


if (( $# >= 3 )); then
	if test "$1" = 'clone'; then
		reponame=$(echo "$2" | sed 's%^.*/\([^/]*\)\.git$%\1%g')
		mkdir "$reponame"
		cd "$reponame"
		git init
		git config core.sparsecheckout true
		num=1
		for arg in "$@"
		do
			if (( $num > 2 )); then
				echo "$arg" >> .git/info/sparse-checkout
			fi
		((num++))
		done
		
		git remote set-url origin "$2"
		git pull origin master
	fi
fi