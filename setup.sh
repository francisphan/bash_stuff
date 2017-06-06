#!/bin/bash

if [[ $EUID -eq 0 ]]; then
	echo "It is preferred you do not run this script as root as this is repo is not meant for root"
	exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "$0" )" && pwd )"
i=0
while [[ $i -eq 0 ]]; do
	if [[ -f ~/.bash_profile ]]; then
		read -p "Do you want to overwrite current bash profile? (y/n) " RESP
	else
		RESP="y"
	fi

	RESP=$(echo "$RESP" | tr '[:upper:]' '[:lower:]')
	echo $RESP
	if [[ $RESP -eq "y" ]]; then
		temp_path=$(grep PATH ~/.bash_profile)
		cp $SCRIPT_DIR/profiles/bash_profile ~/.bash_profile
		echo $temp_path >> ~/.bash_profile
		i=1
		echo $i
	elif [[ $RESP -eq "n" ]]; then
		i=1
	fi
done

i=0
while [[ $i -eq 0 ]]; do
	if [[ -f /etc/vimrc ]]; then
		read -p "Do you want to overwrite current vimrc? (y/n) " RESP
	else
		RESP="y"
	fi

	RESP=$(echo "$RESP" | tr '[:upper:]' '[:lower:]')
	if [[ $RESP -eq "y" ]]; then
		sudo cp $SCRIPT_DIR/profiles/vimrc /etc/vimrc
		i=1
	elif [[ $RESP -eq "n" ]]; then
		i=1
	fi
done


