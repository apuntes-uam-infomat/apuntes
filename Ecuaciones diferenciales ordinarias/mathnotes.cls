\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mathnotes}[2014/01/01 Math Notes]

\LoadClass[a4paper, 12pt]{article}

\RequirePackage[spanish,es-noquoting,es-noshorthands]{babel}
\RequirePackage{etoolbox}
\RequirePackage{imakeidx}
\RequirePackage{fancyhdr}
\RequirePackage{chngcntr}
\RequirePackage{hyperref}
\RequirePackage{MathUnicode}
\RequirePackage{wrapfig}

\hypersetup{
  colorlinks,
  citecolor=black,
  linkcolor=DarkBlue,
  urlcolor=DarkBlue}

\AfterEndPreamble{
	\maketitle
	\newpage
	\tableofcontents
	\newpage
}

\pagestyle{fancy}
\lhead{\color{DarkBlue}{\rightheader}}
\rhead{\color{DarkBlue}{\leftheader}}
\cfoot{\thepage}
\setlength{\headheight}{16pt}
\patchcmd{\headrule}{\hrule}{\color{DarkBlue}\hrule}{}{}

\vfuzz=6pt
\hfuzz=6pt

\counterwithin{figure}{section}
\counterwithin{equation}{section}

\makeindex

\endinput