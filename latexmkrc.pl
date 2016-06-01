# Commando usado para compilar el .tex
# (Activamos el -shell-escape)
$pdflatex = "pdflatex %O -shell-escape -interaction nonstopmode %S";

# Pone el resultado final en la carpeta pdf/
$out_dir = "pdf";

# Generamos solo el PDF
$pdf_mode = 1; $postscript_mode = $dvi_mode = 0;

# Modo silencioso
$silent = 1;

# Algunas variables de entorno que usa pdflatex
$ENV{'TEXINPUTS'}      	= "../Cosas guays LaTeX:" . $ENV{'TEXINPUTS'};
$ENV{'max_print_line'} 	= 1000; # Cualquier numero
$ENV{'error_line'}     	= 254; # Maximo: 254
$ENV{'half_error_line'}	= 238; # Maximo: error_line - 16
