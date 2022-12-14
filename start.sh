#!/bin/zsh
# If you want to run yours with root, then you can remove this. I run mine as the user so I can run some commands that are far more annoying to run with root.
if [[ $(id -u) = 0 ]]; then
	echo "This script does not run properly with root."
	exit 33
else
	echo "Checking for sudo."
	sudo -k
	if sudo true; then
		echo "You have sudo."
	else
		echo "No sudo."
		exit 33
	fi
fi
echo "Stopping Display Manager." && sudo systemctl stop display-manager.service
sleep 10
# You can add anything else you want in here, like starting an SMB service for a network drive in your VM.
echo "Running GPU driver checks."
if sudo fuser -s /dev/dri/renderD128 || sudo fuser -s /dev/dri/card0; then
	echo "GPU still in use."
	read -q REPLY\?"Attempt to force kill all processes using the GPU? [Y/n] "
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		sudo lsof -t /dev/dri/renderD128 | xargs -I '{}' sudo kill {}
		if sudo fuser -s /dev/dri/renderD128 || sudo fuser -s /dev/dri/card0; then
			echo "\nGPU still in use, even after force kill. \n\nAborting."
			read -s -k \?"Press any key to start Display Manager and exit."
			sudo systemctl start display-manager.service
			{ exit 1; }
		else
			echo "\nGPU no longer in use."
			# You can add services, drive mounts, etc here as well. Make sure to add them in the other places this comment is placed as well.
			echo "Waiting 5 seconds, then booting Windows."
			sleep 5
			virsh start win10
		fi
	else
		echo "\nAborting."
		read -s -k \?"Press any key to start Display Manager and exit."
		sudo systemctl start display-manager.service
		{ exit 1; }
	fi
else
	# You can add services, drive mounts, etc here as well. Make sure to add them in the other places this comment is placed as well.
	echo "Waiting 5 seconds, then booting Windows"
	sleep 5
	virsh start win10
fi
