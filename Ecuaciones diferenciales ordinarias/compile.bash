#!/bin/bash

makeindex edo.idx
pdflatex edo.tex
texclean
