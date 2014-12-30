#!/bin/bash
bzrvar="lp:$(cat .bzr/branch/branch.conf | grep push_location | cut -c 48-99)"
case "$1" in
	up)
		bzr add
		bzr commit 
		bzr push $bzrvar
		;;	

	init)
		echo "Introduzca su nombre de usuario en Bazaar:"
		read yo
		echo "Introduzca el nombre de la rama:"
		read donde
		bzr init
		bzr add
		bzr commit -m "* primer commit"
		bzr push lp:~$yo/+junk/$donde
		;;

	change)
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
		echo "USO: $0 {up|init|change|change-all|refresh}"
		;;
esac
exit 0
