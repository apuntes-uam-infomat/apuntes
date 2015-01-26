\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mathnotes}[2014/01/01 Math Notes Class]

% % Options

% % Process given options
\ProcessOptions\relax

% % Load base
\LoadClass[a4paper, 12pt]{article}

% % Packages
\usepackage[utf8]{inputenc}
\usepackage[spanish]{babel}
\usepackage{graphicx}

% % Color
\usepackage{xcolor}
\definecolor{DarkBlue}{rgb}{0.0, 0.0, 0.55}

% % Hyperref
\usepackage{hyperref}
\hypersetup{
  colorlinks,
  citecolor=black,
  linkcolor=DarkBlue,
  urlcolor=DarkBlue}

% % Custom
\title{\thetitle}
\author{\theauthor}
\date{\thedate}

% % Header
\usepackage{fancyhdr}
\setlength{\headheight}{15.8pt}
\pagestyle{fancy}
\renewcommand{\sectionmark}[1]{\markboth{#1}{}}
\fancyhead[L]{\thetitlename}
\fancyhead[R]{\leftmark}


\endinput