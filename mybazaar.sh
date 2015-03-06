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
		echo -e "\e[00;1;92mFinished...\e[00m"
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
		echo -e "\e[00;1;92mFinished...\e[00m"
		;;

	init)
		echo "Enter your username in Bazaar:"
		read yo
		echo "Enter the name of the branch:"
		read donde
		bzr init
		bzr add
		bzr commit -m "* first commit"
		bzr push lp:~$yo/+junk/$donde
		echo -e "\e[00;1;92mFinished...\e[00m"
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
		echo -e "\e[00;1;92mFinished...\e[00m"
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
		echo -e "\e[00;1;92mFinished...\e[00m"
		;;

	refresh)
		for i in $(find . -maxdepth 1 -type d | cut -c 3-50); do
    			cd $i
			echo $(pwd)
			bzr pull
			cd ..
		done
		echo -e "\e[00;1;92mFinished...\e[00m"
		;;

	*)
		echo "usage: $0 {up|init|change|change-all|refresh|up-all <message>}"
		;;
esac
exit 0
