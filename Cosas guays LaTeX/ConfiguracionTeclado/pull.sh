#!/bin/bash
#!/bin/bash
if [[ $1 == "" ]]; then
	echo "Argumento por favor"
else
	cp /usr/share/X11/xkb/symbols/$1 ./$1
fi