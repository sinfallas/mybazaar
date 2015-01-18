#!/bin/bash
case "$1" in
	up)
		if [ -n "$(cat .bzr/branch/branch.conf | grep push_location | cut -c 48-99)" ]; then
			echo 1 > /dev/null
		else
			echo "push_location = bzr+ssh://bazaar.launchpad.net/"$(cat .bzr/branch/branch.conf | grep parent_location | cut -c 50-99) >> .bzr/branch/branch.conf
		fi
		bzrvar="lp:$(cat .bzr/branch/branch.conf | grep push_location | cut -c 48-99)"
		bzr add
		bzr commit 
		bzr push $bzrvar
		echo "Finished..."
		;;	

	up-all)
		for i in $(find . -maxdepth 1 -type d | cut -c 3-50); do
			cd $i
				if [ -n "$(cat .bzr/branch/branch.conf | grep push_location | cut -c 48-99)" ]; then
					echo 1 > /dev/null
				else
					echo "push_location = bzr+ssh://bazaar.launchpad.net/"$(cat .bzr/branch/branch.conf | grep parent_location | cut -c 50-99) >> .bzr/branch/branch.conf
				fi
				bzrvar2="lp:$(cat .bzr/branch/branch.conf | grep push_location | cut -c 48-99)"
				echo $(pwd)
				bzr add
				bzr commit -m $2
				bzr push $bzrvar2
			cd ..
		done
		echo "Finished..."
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
		echo "Finished..."
		;;

	change)
		if [ -n "$(cat .bzr/branch/branch.conf | grep push_location | cut -c 48-99)" ]; then
			echo 1 > /dev/null
		else
			echo "push_location = bzr+ssh://bazaar.launchpad.net/"$(cat .bzr/branch/branch.conf | grep parent_location | cut -c 50-99) >> .bzr/branch/branch.conf
		fi
		bzrvar="lp:$(cat .bzr/branch/branch.conf | grep push_location | cut -c 48-99)"		
		bzr log > CHANGES
		bzr add
		bzr commit -m "* changelog"
		bzr push $bzrvar
		echo "Finished..."
		;;

	change-all)
		for i in $(find . -maxdepth 1 -type d | cut -c 3-50); do
			cd $i
				if [ -n "$(cat .bzr/branch/branch.conf | grep push_location | cut -c 48-99)" ]; then
					echo 1 > /dev/null
				else
					echo "push_location = bzr+ssh://bazaar.launchpad.net/"$(cat .bzr/branch/branch.conf | grep parent_location | cut -c 50-99) >> .bzr/branch/branch.conf
				fi
				bzrvar2="lp:$(cat .bzr/branch/branch.conf | grep push_location | cut -c 48-99)"
				echo $(pwd)
				bzr log > CHANGES
				bzr add
				bzr commit -m "* changelog"
				bzr push $bzrvar2
			cd ..
		done
		echo "Finished..."
		;;

	refresh)
		for i in $(find . -maxdepth 1 -type d | cut -c 3-50); do
    			cd $i
			echo $(pwd)
			bzr pull
			cd ..
		done
		echo "Finished..."
		;;

	*)
		echo "USO: $0 {up|init|change|change-all|refresh|up-all <message>}"
		;;
esac
exit 0
