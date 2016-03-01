\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{apuntes}[2013/04/20 Note taking class]

\def\printbuilddate{\footnotetext{\tiny Documento compilado el \today\ a las \currenttime}}
\def\enableindexbuilddate{\renewcommand{\compdate}{\tiny{\today\, \currenttime}}}
\def\titlepagebuilddate{\par \vspace{3pt} \tiny \today\, \currenttime \vspace{-4pt}}
\newif\if@apuntestitlepage
\newif\if@shortheader
\@shortheaderfalse
\newcommand{\organization}{UAM}

\DeclareOption{nobuilddate}{%
	\def\printbuilddate{}%
	\def\enableindexbuilddate{}%
	\def\titlepagebuilddate{}%
}

\DeclareOption{titlepage}{
	\@apuntestitlepagetrue
	\PassOptionsToClass{\CurrentOption}{custombase}
}

\DeclareOption{notitlepage}{
	\@apuntestitlepagefalse
	\PassOptionsToClass{\CurrentOption}{custombase}
}

\DeclareOption{shortheader}{
	\@shortheadertrue
}

\DeclareOption{bibnumbers}{\PassOptionsToPackage{numbers}{natbib}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{custombase}}

\ExecuteOptions{titlepage}
\ProcessOptions

\LoadClass{custombase}

\RequirePackage{pdfpages}
\RequirePackage{datetime}
\RequirePackage{environ}
\RequirePackage{pgfkeys}
\RequirePackage{natbib}
\RequirePackage[nottoc]{tocbibind}% bibliografía y el índice no aparecen en el índice del pdf sin esta línea mágica. No sabemos qué hace, pero será mejor que tengas un buen motivo para quitarla

% Hacemos que el enlace al índice funcione bien.
\let\oldindex\printindex
\def\printindex{\clearpage\phantomsection\oldindex} % Simplemente hacemos que \printindex inserte un marcador de sección que se pueda enlazar

\if@removechapters
	\numberwithin{equation}{section}
\fi

%%%% Página de título superguay.

\definecolor{titlepagecolor}{cmyk}{1,.50,0,.10} % Definimos un color fijo para usar.

% Esto nos viene bien por si luego queremos
% reemplazar el título (en traducciones por ejemplo).
\def\@abstracttitle{Resumen}

% Incluimos el abstract (resumen)

% Primero eliminamos la definición del entorno abstract, si es que está.
% (si usamos \renewenvironment peta en algún caso extraño).
\let\abstract\@undefined
\let\endabstract\@undefined
\newif\if@abstractset % Para ver si el usuario lo ha configurado o no.
\NewEnviron{abstract}{
	\global\@abstractsettrue		% Decimos que el abstract se ha usado.
	\global\let\@abstractbody\BODY	% Y nos lo guardamos.
}

\def\and{\!,\ }
\renewcommand{\author}[1]{\def\theauthor{#1}}

\newif\if@showsignature

% Preparamos las opciones
\pgfkeys{
	/apntstitle/.is family, /apntstitle,
	signature/.is choice,
	signature/true/.code = {\@showsignaturetrue},
	signature/false/.code = {\@showsignaturefalse},
	default/.style = {signature = true} % Argumentos por defecto
}

% Ejecutamos los argumentos por defecto por si el usuario no pone
% \titlesetup en el documento
\pgfkeys{/apntstitle, default}

% Hay que hacer esta chapuza de pasar los argumentos a \maketitle antes con
% \titlesetup porque por alguna razón no puedo redefinir \maketitle con argumentos
% opcionales.
\newcommand{\titlesetup}[1]{\pgfkeys{/apntstitle, #1}} % Procesamos argumentos

\newcommand{\fullpagetitle}{
\begin{titlepage}
	% Primera parte: el título en modo chulo con un margen en la parte superior
	\vspace*{0.1\textheight}
	\noindent
	\textcolor{titlepagecolor}{%
		\begin{hyphenrules}{nohyphenation}%
		\Huge{\textbf{\fontfamily{lmss}\selectfont\thetitle}}%
		\end{hyphenrules}%
	}
	\par
	% Una línea que ocupe toda la página
	\noindent\makebox[\linewidth]{\color{titlepagecolor}\rule{1.1\paperwidth}{2pt}}\par
	\vspace{60pt} % Margen hasta el abstract
	\noindent
	\if@abstractset % Escribimos el abstract sólo si el usuario lo ha escrito.
		\begin{minipage}{0.6\linewidth}
			\setlength{\parskip}{5pt}
			\setlength{\parindent}{0pt}
			\textbf{\@abstracttitle}\par
			\small\@abstractbody
		\end{minipage}
	\fi
	\vfill  % Llenamos hasta el final de la página con espacio.
	\noindent
	\begin{minipage}{0.5\textwidth} % Dividimos en dos partes: Autores y la firmita.
		\begin{mdframed}[topline=false, rightline=false, bottomline=false, linewidth=1pt]
			\fontfamily{ppl}\selectfont
			\def\and{\\}
			\theauthor\par
			\vspace{5pt}
			\noindent{%
				\ifthenelse{\equal{\organization}{}}{}{\small \organization\;- }%
				\thedate
			}
			% Esta cadena la configuramos arriba, se puede quitar con una opción.
			\titlepagebuilddate
			\end{mdframed}
	\end{minipage}
	~
	\if@showsignature
		\begin{minipage}{0.5\textwidth} % Ahora la firmita.
			\fontfamily{ppl}\selectfont
			\begin{flushright}
				\footnotesize
				Apuntes UAM \par
				Doble Grado Mat.Inf. \par
				\vspace{5pt}
				\href{http://github.com/VicdeJuan/Apuntes}{Código en Github}
			\end{flushright}
		\end{minipage}
	\fi
	\vspace{30pt}
\end{titlepage}
}
\if@apuntestitlepage % Nos piden la página de título, así que renovamos el comando \maketitle.
\let\maketitle\fullpagetitle
\fi

\newcommand{\compdate}{}

% Cabecera super molona
\fancyhf{}
\PrerenderUnicode{ÁáÉéÍíÓóÚúÑñ} % Para que salgan las tildes y demás mierdas en el título.
\fancypagestyle{plain}{%
	\if@shortheader
		\lhead{\small \itshape \thetitle}
	\else
		\lhead{%
			\small \itshape \thetitle\, -\, \thedate\,%
			\ifthenelse{\equal{\organization}{}}{}{ -\, \organization}%
		}
	\fi
	\rhead{\small \theauthor}
	\cfoot{\thepage\ de \pageref{LastPage}}
	\rfoot{\compdate}
}

\setlength{\parskip}{2mm}
\setlength{\headheight}{15pt}

\apptocmd{\printindex}{\enableindexbuilddate}{}{}
\apptocmd{\maketitle}{\printbuilddate}{}{}

\newcommand{\placeholder}[1]{\begin{framed}\textit{\textbf{A rellenar:} #1}\end{framed}}

\makeindex
