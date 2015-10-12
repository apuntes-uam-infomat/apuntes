\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{custombase}[2013/04/20 Base class]

\def\@fontsizeopt{}
\newif\if@removechapters


% Si nos pasan la opción nochap, no ponemos número de capítulo en las secciones.
\DeclareOption{nochap}{\@removechapterstrue}

\DeclareOption{palatino}{%
	\renewcommand{\rmdefault}{ppl}
	\renewcommand{\sfdefault}{lmss}
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

\def\@exmathload{\RequirePackage{exmath}}

\DeclareOption{noprobframes}{
	\def\@exmathload{\RequirePackage[noproblemframes]{exmath}}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\ExecuteOptions{sansserif}
\ProcessOptions

\PassOptionsToClass{\@fontsizeopt}{report}

\LoadClass[a4paper,reqno]{report}

\RequirePackage[usenames,dvipsnames]{xcolor}
\RequirePackage[includemp, left=3cm,right=1cm,top=3cm,bottom=2cm, marginparwidth=1.6cm, marginparsep=0.7cm]{geometry} % Márgenes
\RequirePackage{imakeidx} % Creación de índices
\RequirePackage{titling} % Para poder referenciar \thetitle, \thedate, etc.
\RequirePackage{fancyhdr} % Cabeceras de página
\RequirePackage{lastpage} % Módulo para añadir una referencia a la última página
%\RequirePackage[spanish,es-noquoting,es-noshorthands]{babel} % Cadenas de LaTeX traducidas al español
\RequirePackage[english]{babel} % Cadenas de LaTeX traducidas al español
\RequirePackage{amsthm} % Paquete de matemáticas
\RequirePackage{framed} % Marcos
\RequirePackage{mdframed} % Más marcos
\RequirePackage{hyperref} % Para que salgan enlaces en la tabla de contenidos y el glosario
\@exmathload
\RequirePackage{wrapfig} % Figuras flotantes
\RequirePackage{MathUnicode} % Paquete para poder poner caracteres griegos y demás cosas raras.
\RequirePackage{listings} % Para poner código.

\if@removechapters
	\def\thesection{\arabic{section}}
\fi

% Números en las subsecciones
\setcounter{secnumdepth}{3}
\def\thechapter{\Roman{chapter}}

% Ajustes para los enlaces
\hypersetup{
	hyperindex,
    colorlinks,
    allcolors=blue!60!black
}

\newcommand{\seprule}{{\color{gray} \noindent \hspace{40pt} \hrulefill~ \raisebox{-4pt}[10pt][10pt]{$\ast\quad\ast\quad\ast$}~ \hrulefill\hspace{40pt}}}


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

