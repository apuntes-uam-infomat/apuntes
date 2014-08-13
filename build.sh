#!/bin/bash

cat > /tmp/uptodatecheck.latexmkrc << EOF
\$pdflatex = \$latex = 'internal die_pdflatex %S';
sub die_pdflatex {
    # Stop now, otherwise latexmk will update its knowledge of the
    # source files and not realize files are out-of-date on the next run.
    die "I won't do anything, but just note that '\$_[0]' is out of date\n";
}
EOF

tbold=$(tput bold)
treset=$(tput sgr0)
tred=$(tput setaf 1)
tgreen=$(tput setaf 2)
tyellow=$(tput setaf 3)

packages_dir="Cosas guays LaTeX"
packages_changed=false
failed=""

function packages_install() {
	cd "$packages_dir"
	sudo ./install
}

function prebuild() {
	mkdir -p tikzgen
}

function build() {
	latexmk -pdf -silent -shell-escape "$1"
}

function echob() {
	echo $tbold$@$treset
}

cd "$(dirname ${BASH_SOURCE[0]})"

IFS=$'\n'

for texfile in $(ls */*.tex); do
	cwd=$(pwd)
	cd "$(dirname $texfile)"
	
	echob "[ Checking $texfile... ]"
	texfile="$(basename $texfile)"

	prebuild

	if ! latexmk -pdf -r "/tmp/uptodatecheck.latexmkrc" "$texfile" &>/dev/null ; then
		echo "$tyellow$texfile out of date. Compiling...$treset"
		if ! build "$texfile" ; then
			echo "Compilation failed for $texfile."
			failed="$failed $texfile"
		fi
	else
		echo "$tgreen$texfile up to date.$treset"
	fi

	cd "$cwd"
done

[[ -z "$failed" ]] || echo "Compilation failed for $failed "
echo "done"

rm /tmp/uptodatecheck.latexmkrc
