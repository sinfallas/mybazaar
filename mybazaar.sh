#!/bin/bash
bzrvar="lp:~user/+junk/example"
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

	change)
		bzr log > CHANGES
		bzr add
		bzr commit -m "* changelog"
		bzr push $bzrvar
		;;

	*)
		echo "USO: $0 {up|init|change}"
		exit 0
		;;

esac
exit 0
