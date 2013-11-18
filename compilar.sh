#!/bin/bash
read -p "Compilar (y/n)?" yn
case $yn in
	[Yy]* ) echo "Compilando..."
		echo "-----------------------------------------"
		cd "Cosas guays LaTeX"
		sudo ./install > /dev/null
		cd ..
		cd "Analisis Matematico"
		pdflatex tex/Analisis_Matematico.tex > /dev/null
		cp Analisis_Matematico.pdf ..
		cd ..
		cd "Estructuras Algebraicas"
		pdflatex Estructuras.tex > /dev/null
		cp Estructuras.pdf ..
		cd ..
		cd "Estadistica I"
		pdflatex EI.tex > /dev/null
		cp EI.pdf ..
		cd ..;;
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

