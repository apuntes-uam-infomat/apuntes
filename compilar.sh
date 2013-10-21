#!/bin/bash
cd "Cosas guays LaTeX"
sudo ./install
cd ..
cd "Analisis Matematico"
pdflatex Analisis_Matematico.tex
cp Analisis_Matematico.pdf ..
cd ..
cd "Estructuras Algebraicas"
pdflatex Apuntes.tex
cp Apuntes.pdf ..
cd ..
mv Apuntes.pdf Estructuras.pdf
cd "Estadistica I"
pdflatex EI.tex
cp EI.pdf ..
