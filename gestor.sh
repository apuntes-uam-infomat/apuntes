#!/usr/bin/env bash

# ===================================================================
# Utilidades

# Modo seguro
set -eu
set -o pipefail
# Mejor globbing
shopt -s extglob nullglob

# Navegamos al directorio donde este este script
cd "$( dirname "${BASH_SOURCE[0]}" )"
ROOT_DIR="$(pwd)"

PACKAGE_DIR="$ROOT_DIR/Cosas Guays LaTeX"
SILENT=false

# Formateo
F_RESET=$(tput sgr0)
F_BOLD=$(tput bold)
F_UNDER=$(tput smul)
F_RED=$(tput setaf 1)
F_GREEN=$(tput setaf 2)
F_YELLOW=$(tput setaf 3)
#F_BLUE=$(tput setaf 4)
#F_MAGENTA=$(tput setaf 5)
#F_CYAN=$(tput setaf 6)
#F_WHITE=$(tput setaf 7)

# Mini-comandos
INFO()  { "$SILENT" || echo >&2 "${F_BOLD}${F_GREEN}>>${F_RESET} $1"; }
WARN()  { "$SILENT" || echo >&2 "${F_BOLD}${F_YELLOW}>>${F_RESET} $1"; }
ERR()   { "$SILENT" || echo >&2 "${F_BOLD}${F_RED}>>${F_RESET} $1"; }
abort() { ERR "$1"; exit 1; }

# Seleccionador de asignatura
seleccionar_asignatura() {

	local asignatura="${1%%/}"

	# Comprobamos que tenga longitud no-nula
	[[ -n "$asignatura" ]] || abort "No se proporciono el nombre de la asignatura"

	# Comprobamos que exista el directorio
	[[ -d "$asignatura" ]] || abort "No existe un directorio '$asignatura/'"

	# Y que tenga al menos un .tex dentro!
	[[ -n "$(find "$asignatura" -maxdepth 1 -iname '*.tex')" ]] || abort "El directorio '$asignatura/' no contiene ningun fichero .tex"

	# Exito!
	echo "$asignatura"
	return 0
}

# ===================================================================
# Sub comandos

## crear_asignatura
##
## Crea la estructura de ficheros para una asignatura nueva.
## Uso: crear_asignatura asignatura [abreviacion]
##
crear_asignatura() {

	# Procesamos los argumentos
	# Si no hay abreviatura, usamos el nombre SIN los espacios
	local name="$1"
	local abbr="${2:-${name//[[:space:]]/}}"

	# Comprobamos que se haya proporcionado un nombre
	[[ -z "$name" ]] && abort "usage: $0 [name] [abbreviation]"

	# Sanity check: que no exista ya el directorio!
	[[ -e "$name" ]] && abort "Ya existe un fichero con el nombre $name!"

	INFO "Creando $name/ (abbrev: $abbr)"
	mkdir "$name" && cd "$name"

	local extra_tex_files_input="" subdir suffix

	# Creamos algunos directorios extra
	for subdir in img pdf tex tikzgen; do
		INFO "Creado directorio $name/$subdir (con fichero .keep)"
		mkdir "$subdir"
		touch "$subdir/.keep"
	done

	# Creamos fichero de ejercicios (antes era un bucle)
	suffix=Ejs

	texfile="tex/${abbr}_${suffix}.tex"
	printf -v extra_tex_files_input "%s\n\chapter{---}\n%s\n" "$extra_tex_files_input" "\input{$texfile}"
	echo "% -*- root: ../${abbr}.tex -*-" > "$texfile"
	INFO "Creado fichero extra $texfile"

	local current_year
	current_year=$(date +%y)
	local docdate

	# Primer o segundo cuatrimestre?
	if [[ $(date +%m ) -ge 8 ]]; then
		docdate="$current_year/$((current_year + 1)) C1"
	else
		docdate="$((current_year - 1))/$current_year C2"
	fi

	# Creamos el fichero base a partir de una plantilla
	cat > "$abbr.tex" <<-EOF
		\documentclass[palatino]{apuntes}

		\title{$name}
		\author{}
		\date{$docdate}

		% Paquetes adicionales

		% --------------------

		\begin{document}
		\pagestyle{plain}
		\maketitle

		\tableofcontents
		\newpage
		% Contenido.

		%% Apendices (ejercicios, examenes)
		\appendix
		$extra_tex_files_input
		\printindex
		\end{document}
	EOF


	INFO "Terminado con exito!"
}

##
## compilar
##
## Compila los apuntes de la asignatura especificada.
## Uso: compilar [asignatura]
##
compilar() {

	# Esta separado para no ignorar el codigo de retorno
	local asignatura;
	asignatura="$(seleccionar_asignatura "${1:-}")"

	INFO "Compilando ${F_UNDER}$asignatura${F_RESET} ..."

	# Preparamos para compilar...
	cd "$asignatura"
	mkdir -p tikzgen

	# Compilamos comprobando el codigo de retorno
	if ! latexmk -r "../latexmkrc.pl" > /dev/null; then

		ERR "Ha ocurrido un error fatal al compilar"
		ERR "Informacion de diagnostico en"
		ERR "    ${F_UNDER}$asignatura/$(echo pdf/*.log)${F_RESET}"
		ERR "Resuelva los errores, y vuelva a intentarlo"
		return 1

	fi

	INFO "Compilado con exito!"
	return 0
}

##
## compilar_todo
##
## Compila todos los apuntes.
##
compilar_todo() {

	local dir_num=0
	local dir_upd=0
	local dir_err=0

	while IFS= read -r -d $'\0' asignatura; do

		if ( compilar "$(dirname "$asignatura")" ); then
			(( dir_upd += 1 ))
		else
			(( dir_err += 1 ))
		fi

		(( dir_num += 1 ))

		INFO "================================================================"

	done < <( find . -mindepth 2 -maxdepth 2 -iname '*.tex' -print0 )

	INFO "Encontrado ${F_BOLD}$dir_num${F_RESET} asignaturas, de las cuales"
	INFO "    ${F_GREEN}$dir_upd${F_RESET} han sido compilados sin errores."
	INFO "    ${F_RED}$dir_err${F_RESET} han tenido algun problema."
	INFO ""
	INFO "Terminado ($(date))"

}

##
## limpiar
##
## Limpia los apuntes de la asignatura especificada.
## Uso: limpiar [asignatura]
##
limpiar() {

	# Esta separado para no ignorar el codigo de retorno
	local asignatura;
	asignatura="$(seleccionar_asignatura "${1:-}")"

	INFO "Limpiando ${F_UNDER}$asignatura${F_RESET} ..."

	cd "$asignatura"
	latexmk -r "../latexmkrc.pl" -C
}

##
## empaquetar
##
## Empaqueta los ficheros de una asignatura en un zip.
## Uso: compilar [asignatura]
##
empaquetar() {

	# Esta separado para no ignorar el codigo de retorno
	local asignatura;
	asignatura="$(seleccionar_asignatura "${1:-}")"

	# Zip de salida es la asignatura sin espacios
	local salida_zip="${asignatura//[[:space:]]/}.zip"

	# Variable con patrones a ignorar al empaquetar
	local tex_ignore="tikzaux"

	INFO "Empaquetando ${F_UNDER}$asignatura${F_RESET} ..."
	cd "$asignatura"

	if [[ -e "$salida_zip" ]]; then
		mv "$salida_zip" "$salida_zip.bak"
		WARN "Ya existe un archivo '$salida_zip'"
		WARN "Ha sido renombrado a '$salida_zip.bak'"
	fi

	zip "$salida_zip" !($tex_ignore).tex
	zip -r "$salida_zip" tex pdf tikz
	zip -j "$salida_zip" "$PACKAGE_DIR"/*.sty "$PACKAGE_DIR"/*.cls

	INFO "Empaquetado en '$asignatura/$salida_zip'"
	return 0
}

##
## instalar
##
## Instala localmente los paquetes de los apuntes.
##
instalar() {
	WARN "Esta funcionalidad no esta implementada aqui."
	WARN "Si realmente quieres instalar los paquetes globalmente,"
	WARN "ejecuta el script situado en ${F_UNDER}Cosas guays LaTeX/install${F_RESET}"
	return 0
}


##
## ayuda
##
## Muestra una ayuda para los subcomandos.
##
ayuda() {
	echo "uso: ./util.sh [subcomando] [argumentos]..."
	echo "Subcomandos validos:"
	echo
	echo "${F_BOLD}crear_asignatura${F_RESET} [nombre completo] [abreviatura]"
	echo "   Crea la estructura de ficheros para una asignatura nueva"
	echo "   Si no se proporciona una abrev, se usara el nombre sin espacios"
	echo
	echo "${F_BOLD}compilar${F_RESET} [asignatura]"
	echo "    Compila una asignatura"
	echo
	echo "${F_BOLD}compilar_todo${F_RESET}"
	echo "    Compila todas las asignaturas"
	echo
	echo "${F_BOLD}limpiar${F_RESET} [asignatura]"
	echo "    Limpia los archivos generados de una asignatura"
	echo
	echo "${F_BOLD}empaquetar${F_RESET} [asignatura]"
	echo "    Zipea todos los ficheros necesarios para compilar una asignatura"
	echo
	echo "${F_BOLD}instalar${F_RESET}"
	echo "    Instala globalmente los paquetes"
	echo
	echo "${F_BOLD}ayuda${F_RESET}"
	echo "    Muestra esta ayuda"
	echo
}


# ===================================================================
# Seleccionador de utilidad

# Parseamos los argumentos
while getopts "qs" arg; do
	case "$arg" in
		s|q) SILENT=true                              	;;
		\?) abort "Argumento no reconocido (-$OPTARG)"	;;
		--) break                                     	;;
	esac
done
shift $((OPTIND-1))

# Ejecutamos el subcomando (ayuda por defecto)
subcmd="${1:-ayuda}"
shift || :
case "$subcmd" in
	# Comandos validos
	crear_asignatura)	( crear_asignatura  	"$@" ) ;;
	limpiar)         	( limpiar           	"$@" ) ;;
	compilar)        	( compilar          	"$@" ) ;;
	compilar_todo)   	( time compilar_todo	"$@" ) ;;
	empaquetar)      	( empaquetar        	"$@" ) ;;
	instalar)        	( instalar          	"$@" ) ;;
	ayuda)           	( ayuda             	"$@" ) ;;
	# Comando no reconocido
	*)
		ERR "Subcomando '$subcmd' no reconocido"
		ERR "Prueba escribir $0 ayuda"
		exit 1
	;;
esac

# Si llegamos aqui, no ha habido errores! Finalizamos
exit 0;
