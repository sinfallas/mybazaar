#!/bin/bash
bzrvar="lp:$(cat .bzr/branch/branch.conf | grep push_location | cut -c 48-99)"
case "$1" in
	up)
		bzr add
		bzr commit 
		bzr push $bzrvar
		;;	

	init)
		bzr init
		bzr add
		bzr commit -m "* primer commit"
		bzr push $bzrvar
		;;

	change)
		bzr check
		bzr log > CHANGES
		bzr add
		bzr commit -m "* changelog"
		bzr push $bzrvar
		;;

	change-all)
		for i in $(find . -maxdepth 1 -type d | cut -c 3-50); do
			cd $i
				bzrvar2="lp:$(cat .bzr/branch/branch.conf | grep push_location | cut -c 48-99)"
				echo $(pwd)
				bzr check
				bzr log > CHANGES
				bzr add
				bzr commit -m "* changelog"
				bzr push $bzrvar2
			cd ..
		done
		;;

	refresh)
		for i in $(find . -maxdepth 1 -type d | cut -c 3-50); do
    			cd $i
			echo $(pwd)
			bzr pull
			cd ..
		done
		;;

	*)
		echo "USO: $0 {up|init|change|refresh}"
		;;
esac
exit 0
