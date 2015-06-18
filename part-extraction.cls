%!TEX program = lualatex
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{part-extraction}[2015/06/19 Class to extract parts from a full ensemble score.]

\directlua{
  part = require('part-extraction')
}

\newif\ifseparator
\separatorfalse
\DeclareOption{separator}{\separatortrue}

\DeclareOption*{%
  \PassOptionsToClass{
\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass{article}

\RequirePackage{graphicx}
\RequirePackage[
  margin=1cm,
  %includefoot,
  %foot=0.5cm,
  %showframe,
]{geometry}

\pagenumbering{gobble}

\setlength{\parindent}{0cm}

\newcommand{\part@system}[1]{%
  \includegraphics[width=\linewidth]{#1}%
  \ifseparator%
    \par%
    \includegraphics{separator}%
  \else%
  \fi%
    \par%
    \vfil%
}

\newcommand{\partallsystems}{%
  \directlua{
    part.print_all_systems()
  }%
  \vfill
}

\newcommand{\partsystem}{%
  \directlua{
    part.print_next_system()
  }%
  \vfill
}

\newcommand{\partsetpath}[1]{\directlua{part.set_path('#1')}}

\newcommand{\partsetextension}[1]{\directlua{part.set_extension('#1')}}

%%
% \piece{Gott ist da}
%%
\newcommand{\piece}[1]{\def\das@piece{#1}}

\newcommand{\composer}[1]{\def\der@composer{#1}}

\AtBeginDocument{%
  \directlua{part.scandir()}%
  {%
  \large%
  \das@piece\
  (\der@composer)%
  }%
  \makeatletter
}