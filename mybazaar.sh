#!/bin/bash
source bzrvar
case "$1" in
	up)
		bzr add
		bzr commit 
		bzr push $bzrvar
		;;	

	init)
		bzr init
		bzr add
		bzr commit 
		bzr push $bzrvar
		;;

	change-all)
		for i in $(find . -maxdepth 1 -type d | cut -c 3-50); do
			cd $i
			git log --decorate > changelog
			git add .
			git commit -a -m "* changelog"
			git push --all
			cd ..
		done
		;;

	refresh)
		for i in $(find . -maxdepth 1 -type d | cut -c 3-50); do
    			cd $i
			git pull
			cd ..
		done
		;;

	*)
		echo "USO: $0 {up|init|change-all|refresh}"
		exit 0
		;;

esac
exit 0
