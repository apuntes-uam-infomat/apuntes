#!/bin/bash

# Uso:
# ./compilar.sh -> Compila todos los apuntes que estén desactualizados.
# ./compilar.sh [directorio] -> Compila todos los apuntes que estén en el directorio [directorio].
#	Por ejemplo, ./compilar EDP compilará sólo los apuntes de EDP.
#
# Además, el script instalará los paquetes si es necesario.

packages_dir="Cosas guays LaTeX"
packages_changed=false
failed=""
updated=""

function packages_install() {
	cd "$packages_dir"
	sudo ./install
	cd ..
}

function prebuild() {
	mkdir -p tikzgen
}

function build() {
	latexmk -pdf -silent -shell-escape "$1" &> /dev/null
}

cat > /tmp/uptodatecheck.latexmkrc << EOF
\$pdflatex = \$latex = 'internal die_pdflatex %S';
sub die_pdflatex {
    # Stop now, otherwise latexmk will update its knowledge of the
    # source files and not realize files are out-of-date on the next run.
    die "I won't do anything, but just note that '\$_[0]' is out of date\n";
}
EOF

IFS=$'\n'

dir_num=0
dir_upd=0
dir_err=0

tbold=$(tput bold)
tblack=$(tput setaf 0)
treset=$(tput sgr0)
tred=$(tput setaf 1)
tgreen=$(tput setaf 2)
tyellow=$(tput setaf 3)

for pkg in $(ls "$packages_dir"/*.{sty,cls}); do
	pkgname=$(basename "$pkg")
	system_path=$(kpsewhich $pkgname)

	# ¿Ha fallado kpsewhich? Entonces el paquete no está presente. A instalar.
	if [[ $? -ne 0 ]]; then
		packages_changed=true
		break
	fi

	# Si hay diferencias entre el paquete local y el instalado, a reinstalar.
	if ! diff "$system_path" "$pkg" &> /dev/null ; then
		packages_changed=true
		break
	fi
done

if $packages_changed; then
	echo "Instalando paquetes..."
	packages_install
fi

if [ -d "$1" ]; then
	files=$(ls "$1"/*.tex)
else
	files=$(ls */*.tex)
fi

for texfile in $files; do
	cwd=$(pwd)
	cd "$(dirname $texfile)"
	(( dir_num += 1))

	echo "Checking $texfile..."
	texfile="$(basename $texfile)"

	if [ "$packages_changed" = true ]; then
		latexmk -C
	fi

	prebuild

	if ! latexmk -pdf -r "/tmp/uptodatecheck.latexmkrc" "$texfile" &>/dev/null ; then
		echo "$texfile out of date. Compiling..."
		if build "$texfile" ; then
			echo "${tgreen}$texfile compile successful.${treset}"
			(( dir_upd += 1))
			updated="$updated $texfile"
		else
			(( dir_err += 1))
			echo "${tred}Compilation failed for $texfile${treset}"
			failed="$failed $texfile"
		fi
	fi

	cd "$cwd"
	echo
done

rm /tmp/uptodatecheck.latexmkrc

echo "${tbold}Found $dir_num courses, updated ${treset}${tgreen}$dir_upd${treset}${tbold}, failed ${tred}$dir_err.${treset}"
[[ -z "$failed" ]] || echo "Compilation failed for $failed "
[[ -z "$updated" ]] || echo "Updated $updated"
echo "done: $(date)"
