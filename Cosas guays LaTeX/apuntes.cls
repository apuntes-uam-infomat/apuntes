\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{apuntes}[2013/04/20 Note taking class]

\RequirePackage{pdfpages}

\LoadClass[titlepage]{custombase}

% Cabecera super molona
\fancyhf{}
\PrerenderUnicode{ÁáÉéÍíÓóÚúÑñ} % Para que salgan las tildes y demás mierdas en el título.
\fancypagestyle{plain}{%
\lhead{\itshape \thetitle\, -\, \thedate\, -\, UAM} 
\rhead{\theauthor} 
\cfoot{\thepage\ de \pageref{LastPage}}
}

\setlength{\parskip}{2mm}
\setlength{\headheight}{15pt}

\newcommand{\placeholder}[1]{\begin{framed}\textit{\textbf{A rellenar:} #1}\end{framed}}

\makeindex
