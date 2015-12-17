#!/bin/bash
if [[ $1 == "" ]]; then
	echo "Argumento por favor"
else
	cd /var/lib/xkb/
	sudo rm *.xkm
	cd -
	sudo cp ./$1 /usr/share/X11/xkb/symbols/custom
	setxkbmap custom
fi