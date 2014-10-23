\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{apuntes}[2013/04/20 Note taking class]

\RequirePackage{pdfpages}
\RequirePackage{datetime}

\LoadClass[titlepage]{custombase}
\DeclareOption{nochap}{\def\thesection{\arabic{section}}
\numberwithin{equation}{subsection}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{custombase}}
\ProcessOptions\relax

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

\apptocmd{\printindex}{\renewcommand{\compdate}{\tiny{\today\, \currenttime}}}{}{}
\apptocmd{\maketitle}{\footnotetext{\tiny Documento compilado el \today\ a las \currenttime}}{}{}

\newcommand{\placeholder}[1]{\begin{framed}\textit{\textbf{A rellenar:} #1}\end{framed}}

\RequirePackage{caption}

\captionsetup{style=base}
\captionsetup[figure]{labelfont=bf,textfont=it}

\makeindex
