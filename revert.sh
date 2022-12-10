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
# This one really doesn't do much in its current state. I wrote it initially to restart some services I that I stopped in the start script.
# You can add your own stuff here, like unmounting drives, starting/stopping services, etc.
echo "Starting Display Manager and exiting." && sudo systemctl start display-manager.service
exit
