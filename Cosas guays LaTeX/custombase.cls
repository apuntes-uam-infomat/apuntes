\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{custombase}[2013/04/20 Base class]


\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

\LoadClass[12pt,a4paper]{article}

\RequirePackage[left=3cm,right=2cm,top=3cm,bottom=2cm]{geometry} % Márgenes
\RequirePackage{imakeidx} % Creación de índices
\RequirePackage{titling} % No tengo claro para qué es esto
\RequirePackage{fancyhdr} % Cabeceras de página
\RequirePackage{lastpage} % Módulo para añadir una referencia a la última página
\RequirePackage[spanish,es-noquoting,es-noshorthands]{babel} % Cadenas de LaTeX traducidas al español 
\RequirePackage{amsthm} % Paquete de matemáticas
\RequirePackage{framed} % Marcos 
\RequirePackage{mdframed} % Más marcos
\RequirePackage{exmath} % Nuestro querido paquete de utilidades
\RequirePackage{hyperref} % Para que salgan enlaces en la tabla de contenidos y el glosario
\RequirePackage{wrapfig} 
\RequirePackage{MathUnicode}

% Ajustes para los enlaces
\hypersetup{
	hyperindex,
    colorlinks,
    citecolor=black,
    filecolor=black,
    linkcolor=black,
    urlcolor=black
}

% Para cambiar la fuente por defecto.
\renewcommand*\familydefault{\sfdefault}

