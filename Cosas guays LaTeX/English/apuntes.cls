\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{apuntes}[2013/04/20 Note taking class]

%\def\printbuilddate{\footnotetext{\tiny Documento compilado el \today\ a las \currenttime}}
\def\printbuilddate{\footnotetext{\tiny Document compiled \today\ at \currenttime}}
\def\enableindexbuilddate{\renewcommand{\compdate}{\tiny{\today\, \currenttime}}}

\DeclareOption{nobuilddate}{%
	\def\printbuilddate{}%
	\def\enableindexbuilddate{}%
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{custombase}}
\ProcessOptions

\LoadClass[titlepage]{custombase}

\RequirePackage{pdfpages}
\RequirePackage{datetime}

\if@removechapters
	\numberwithin{equation}{subsection}
\fi

\newcommand{\compdate}{}

% Cabecera super molona
\fancyhf{}
\PrerenderUnicode{ÁáÉéÍíÓóÚúÑñ} % Para que salgan las tildes y demás mierdas en el título.
\fancypagestyle{plain}{%
	\lhead{\small \itshape \thetitle\, -\, \thedate\, -\, UAM}
	\rhead{\small \theauthor}
	\cfoot{\thepage\ de \pageref{LastPage}}
	\rfoot{\compdate}
}

\setlength{\parskip}{2mm}
\setlength{\headheight}{15pt}

\apptocmd{\printindex}{\enableindexbuilddate}{}{}
\apptocmd{\maketitle}{\printbuilddate}{}{}

\newcommand{\placeholder}[1]{\begin{framed}\textit{\textbf{A rellenar:} #1}\end{framed}}

\RequirePackage{caption}

\captionsetup{style=base}
\captionsetup[figure]{labelfont=bf,textfont=it}

\makeindex
