#!/bin/bash

install=true
logfile="compilar.log"

makelatex() {
	includes="../Cosas guays LaTeX"

	cd "$1"
	if $install ; then
		echo "Copiando archivos temporales..."
		cp $includes/*.sty ./
		cp $includes/*.cls ./
	fi	
	echo "Compilando $1"
	latexmk -pdf -silent >> $logfile 2>&1 && cp *.pdf ../output || echo ">>>>>>>> Error procesando $1 <<<<<<<<"
	if $install ; then
		echo "Eliminando archivos temporales..."
		rm *.sty
		rm *.cls
	fi
	cd -
}

read -p "Instalar paquetes (opcional)? (y/n) " iyn
case $iyn in 
	[Yy]* ) echo "Instalando paquetes.."
		echo "-----------------------------------------"
		cd "Cosas guays LaTeX"
		sudo ./install > /dev/null
		cd ..
		install=false;;
	esac


read -p "Compilar (y/n)? " yn
case $yn in
	[Yy]* ) echo "Compilando..."
		echo > $logfile
		mkdir -p output
		echo "-----------------------------------------"
		IFS=$'\n'

		for dir in `ls`
		do
        	if [[ -d "$dir" && "$dir" != *LaTeX && "$dir" != "output" ]]; then
                makelatex "$dir"
        	fi
		done
		;;
	[Nn]* ) echo "Ok";;
        * ) echo "???";;
    esac

echo "-----------------------------------------"

read -p "Copiar? (y/n)? " yn
case $yn in
	[Yy]* ) if [ $USER="vicdejuan" ]
			then
				echo "Eres dejuan y me se tu directorio"
				cp output/*.pdf /home/vicdejuan/Compartido/Dropbox/Doble\ Grado\ UAM\ \(1\)/TERCEROGILIS/Primer\ Cuatrimestre/Apuntes\ Latex/
			else
				echo "Escribe el path donde quieres copiar los pdfs (a partir de home):"
				read directory
				cp output/*.pdf ~/$directory/
			fi
			echo "Listo."
			;;
		* ) echo "Ok";;
esac

