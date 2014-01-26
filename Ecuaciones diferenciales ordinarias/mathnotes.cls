\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mathnotes}[2014/01/01 Math Notes]

\LoadClass[a4paper, 12pt]{article}

\RequirePackage[spanish]{babel}
\RequirePackage[utf8]{inputenc}
\RequirePackage{etoolbox}
\RequirePackage{makeidx}
\RequirePackage{fancyhdr}

\AfterEndPreamble{
	\maketitle
	\newpage
	\tableofcontents
	\newpage
}

\pagestyle{fancy}
\lhead{\color{DarkBlue}{\thetitle}}
\rhead{\color{DarkBlue}{\theauthor}}
\cfoot{\thepage}
\setlength{\headheight}{16pt}
\patchcmd{\headrule}{\hrule}{\color{DarkBlue}\hrule}{}{}

\vfuzz=2pt

\makeindex

\endinput