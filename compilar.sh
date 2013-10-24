#!/bin/bash
read -p "Compilar (y/n)?" yn
case $yn in
	[Yy]* ) echo "Compilando..."
		echo "-----------------------------------------"
		cd "Cosas guays LaTeX"
		sudo ./install > /dev/null
		cd ..
		cd "Analisis Matematico"
		pdflatex Analisis_Matematico.tex > /dev/null
		cp Analisis_Matematico.pdf ..
		cd ..
		cd "Estructuras Algebraicas"
		pdflatex Apuntes.tex > /dev/null
		cp Apuntes.pdf ..
		cd ..
		cd "Estadistica I"
		pdflatex EI.tex > /dev/null
		cp EI.pdf ..
		cd ..;;
	[Nn]* ) echo "Ok";;
        * ) echo "???";;
    esac
echo "-----------------------------------------"
mv Apuntes.pdf Est_Alg.pdf
echo "Escribe el path donde quieres copiar los pdfs (a partir de home):"
read directory
cp *.pdf ~/$directory
echo "Listo."
