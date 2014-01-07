#!/bin/bash

install=false

makelatex() {
	includes="../Cosas guays LaTeX"

	echo "Compilando $1"
	cd "$1"
	if $install ; then
		cp "$includes/*.sty" ./
		cp "$includes/*.cls" ./
	fi
	latexmk -pdf -silent -c && cp *.pdf ..
	if $install ; then
		rm *.sty
		rm *.cls
	fi
	cd ..
}

read -p "Instalar paquetes (opcional)? (y/n) " iyn
case $iyn in 
	[Yy]* ) echo "Instalando paquetes.."
		echo "-----------------------------------------"
		cd "Cosas guays LaTeX"
		sudo ./install > /dev/null
		cd ..
		install=true;;
	esac


read -p "Compilar (y/n)? " yn
case $yn in
	[Yy]* ) echo "Compilando..."
		echo "-----------------------------------------"
		makelatex "Analisis Matematico"
		makelatex "Estructuras Algebraicas"
		makelatex "Estadistica I";;
	[Nn]* ) echo "Ok";;
        * ) echo "???";;
    esac
echo "-----------------------------------------"
if [ $USER=vicdejuan ]
then
	echo "Eres dejuan y me se tu directorio"
	cp *.pdf /home/vicdejuan/Compartido/Dropbox/Doble\ Grado\ UAM\ \(1\)/TERCEROGILIS/Primer\ Cuatrimestre/Apuntes\ Latex/
else
	echo "Escribe el path donde quieres copiar los pdfs (a partir de home):"
	read directory
	cp *.pdf ~/$directory/
fi
echo "Listo."

