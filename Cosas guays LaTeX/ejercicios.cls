\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ejercicios}[2015/09/08 Clase para entregas de ejercicios]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{custombase}}
\ProcessOptions\relax

\LoadClass[10pt,a4paper,palatino,noprobframes]{custombase}

\geometry{left=-0.5cm, right=1.5cm, top=2cm, bottom=1.5cm}

\PrerenderUnicode{ÁáÉéÍíÓóÚúÑñ} % Para que salgan las tildes y demás mierdas en el título.

\renewcommand{\maketitle}{
	\pagestyle{plain}
	\thispagestyle{empty}
	\noindent \textbf{\Large \thetitle} \vspace{5pt} \\
	\theauthor \\
	\textit{\footnotesize \thedate}
	\vspace{20pt}
}

\fancypagestyle{plain}{%
	\lhead{\small \itshape \thetitle}
	\rhead{\small \theauthor}
	\cfoot{\thepage\ / \pageref{LastPage}}
}
