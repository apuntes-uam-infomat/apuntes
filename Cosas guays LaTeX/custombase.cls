\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{custombase}[2013/04/20 Base class]

\def\@fontsizeopt{}
\newif\if@removechapters

% Si nos pasan la opción nochap, no ponemos número de capítulo en las secciones.

\DeclareOption{palatino}{%
	\renewcommand{\rmdefault}{ppl}
	\renewcommand{\sfdefault}{fla}
	\renewcommand{\ttdefault}{lmtt}
	\renewcommand*{\familydefault}{\rmdefault}
	\def\@fontsizeopt{11pt}
	\message{Loading Palatino fonts}
}

\DeclareOption{sansserif}{
	\renewcommand*{\familydefault}{\sfdefault}
	\def\@fontsizeopt{12pt}
	\message{Loading Sans-Serif fonts}
}

\DeclareOption{english}{
	\def\@babel@load{\RequirePackage[english]{babel}}
}

\DeclareOption{spanish}{
	\def\@babel@load{\RequirePackage[spanish,es-noquoting,es-noshorthands,es-tabla]{babel}}
}

\DeclareOption{noprobframes}{\PassOptionsToPackage{\CurrentOption}{exmath}}
\DeclareOption{probframes}{\PassOptionsToPackage{\CurrentOption}{exmath}}

\DeclareOption{nochap}{
	\PassOptionsToPackage{\CurrentOption}{exmath}
	\@removechapterstrue
}

\DeclareOption{chap}{
	\PassOptionsToPackage{\CurrentOption}{exmath}
	\@removechaptersfalse
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\ExecuteOptions{sansserif,spanish,probframes,chap}
\ProcessOptions

\PassOptionsToClass{\@fontsizeopt}{report}

\LoadClass[a4paper]{report}

\RequirePackage[usenames,dvipsnames]{xcolor}
\RequirePackage[includemp, left=3cm,right=1cm,top=3cm,bottom=2cm, marginparwidth=1.6cm, marginparsep=0.7cm]{geometry} % Márgenes
\RequirePackage{imakeidx} % Creación de índices
\RequirePackage{titling} % Para poder referenciar \thetitle, \thedate, etc.
\RequirePackage{fancyhdr} % Cabeceras de página
\RequirePackage{lastpage} % Módulo para añadir una referencia a la última página
\@babel@load
\RequirePackage{amsthm} % Paquete de matemáticas
\RequirePackage{framed} % Marcos
\RequirePackage{mdframed} % Más marcos
\RequirePackage[pdfencoding=auto,psdextra]{hyperref} % Para que salgan enlaces en la tabla de contenidos y el glosario
\RequirePackage{exmath}
\RequirePackage{wrapfig} % Figuras flotantes
\RequirePackage{MathUnicode} % Paquete para poder poner caracteres griegos y demás cosas raras.
\RequirePackage{calc}	 % Cálculos de longitudes
\RequirePackage{listings} % Para poner código.

\if@removechapters
	\def\thesection{\arabic{section}}

	% El marcador de capítulo sí que va en los apéndices
	\let\oldappendix\appendix
	\renewcommand{\appendix}{
		\renewcommand{\thesection}{\thechapter.\arabic{section}}
		\oldappendix
	}
\fi

% Ajustes para que no haya demasiados cortes de palabras
\pretolerance=7000
\tolerance=500
\emergencystretch=3pt

% Números en las subsecciones
\setcounter{secnumdepth}{3}
\def\thechapter{\Roman{chapter}}

% Ajustes para los enlaces
\hypersetup{
	hyperindex,
    colorlinks,
    allcolors=blue!60!black
}

\newcommand{\seprule}[1][$\ast\quad\ast\quad\ast$]{{\color{gray} \noindent \hspace{40pt} \hrulefill~ \raisebox{-4pt}[10pt][10pt]{#1}~ \hrulefill\hspace{40pt}}}

\newlength{\@proofline}
\newcommand{\proofpart}[1]{
	\vspace{10pt}
	\setlength{\@proofline}{\maxof{\widthof{\textbf{#1}} + 40pt}{150pt}}
	\hspace{-30pt}\rule[-0.5em]{\@proofline}{0.7pt}
	\hspace{-\@proofline}\hspace{25pt} % I don't know how to add lengths
	\textbf{#1}
}

%%%%% Listings UTF8 %%%%%
\lstset{literate=%
{á}{{\'a}}1
{é}{{\'e}}1
{í}{{\'i}}1
{ó}{{\'o}}1
{ú}{{\'u}}1
{Á}{{\'A}}1
{É}{{\'E}}1
{Í}{{\'I}}1
{É}{{\'O}}1
{Ú}{{\'U}}1
}


\RequirePackage{caption}

\captionsetup{style=base}
\captionsetup[figure]{labelfont=bf,textfont=it}
\captionsetup[table]{labelfont=bf,textfont=it,name=Tabla}

