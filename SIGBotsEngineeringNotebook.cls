%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIGBots Engineering Notebook
% Class File
% Version 1.0 (2/12/17)
%
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
%
% Notes:
% 1. This class file defines the structure and layout of the template file (main.tex).
% 2. It has been written in such a way that under most circumstances you should not need to edit it.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-----------------------------------------
% Class Definition and Parameters
%-----------------------------------------

\NeedsTeXFormat{LaTeX2e}[1996/12/01]
\newcommand{\classname}{SIGBotsEngineeringNotebook}
\ProvidesClass{\classname}[2/12/2017 v1.0 SIGBots Engineering Notebook]
\providecommand{\baseclass}{book}

\RequirePackage{etoolbox}
\RequirePackage{xparse}
\newbool{nolistspace}

\DeclareOption{nolistspacing}{\booltrue{nolistspace}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\baseclass}}

\ProcessOptions\relax
\raggedbottom %prevents latex from automatically expanding gaps to fill the page

\LoadClass{\baseclass}

%-----------------------------------------
% Class Options
%-----------------------------------------

\patchcmd{\tableofcontents}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\tableofcontents}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoffigures}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoffigures}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoftables}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoftables}{\MakeUppercase}{\MakeMarkcase}{}{}

% If the option `nolistspacing' is given, the spacing in the different lists is reduced to single spacing. This option is only useful, if the spacing of the document has been changed to onehalfspacing or doublespacing.
\ifbool{nolistspace}{
	\patchcmd{\listoffigures}{%
		\@starttoc{lof}}{%
			\begingroup%
			\singlespace\@starttoc{lof}\endgroup%
		}{}{}%
	\patchcmd{\listoftables}{%
		\@starttoc{lot}}{%
			\begingroup%
			\singlespace\@starttoc{lot}\endgroup%
		}{}{}%
	\patchcmd{\tableofcontents}{%
		\@starttoc{toc}}{%
			\begingroup%
			\singlespace\@starttoc{toc}\endgroup%
		}{}{}%
}{}
%-----------------------------------------
% Required Packages
%-----------------------------------------

\RequirePackage{babel} % Required for automatically changing names of document elements to languages besides english

\RequirePackage{scrbase} % Required for handling language-dependent names of sections/document elements

\RequirePackage{scrhack} % Loads fixes for various packages

\RequirePackage{setspace} % Required for changing line spacing

\RequirePackage{longtable} % Required for tables that span multiple pages (used in the symbols, abbreviations and physical constants pages)

\RequirePackage{siunitx} % Required for \SI commands

\RequirePackage{graphicx} % Required to include images
\graphicspath{{Figures/}{./}} % Specifies where to look for included images

\RequirePackage{booktabs} % Required for better table rules

\RequirePackage{fancyhdr} %used for header and footer editing

\RequirePackage{afterpage} %used for creating blank pages

\RequirePackage{float} %allows forced photo position

\RequirePackage{amsmath} %used for matrices

\RequirePackage{enumitem} %allow for more bulleting depth

\RequirePackage{tocloft} %used for TOC spacing
\tocloftpagestyle{plain}

%for strikethrough command
\RequirePackage{tikz}
\usetikzlibrary{calc}
\RequirePackage{zref-savepos}
\RequirePackage{tabu}

\RequirePackage{colortbl} %for grayed out cells

\RequirePackage{multirow} %allows tables to merge content into multiple rows

\RequirePackage{hyperref}%used for cross-referencing, url support, and a variety of other things

\RequirePackage[centerlast,labelfont=bf]{caption} % Required for customizing the captions
\setlength{\captionmargin}{50pt}

\RequirePackage{titlesec} %used to change section header formatting

\RequirePackage{python} %used for phabricator integration

\RequirePackage{algorithmic} %used for else if functionality

\RequirePackage{filecontents} %used to import other filetypes

\RequirePackage{minted} %used for code highlighting

\RequirePackage{csquotes}%makes bibliography happy

%-----------------------------------------
% Document Settings
%-----------------------------------------

%The depth to which the document sections are printed to the table of contents
\setcounter{tocdepth}{2}

%remove space above table of contents and table of figures titles\
\setlength{\cftbeforetoctitleskip}{0em}
\setlength{\cftbeforeloftitleskip}{0em}

%-----------------------------------------
% Class Specific Functions
%-----------------------------------------

%include option for labeling chapters, sections and subsections
\let\orichaptermark\chaptermark
\renewcommand\chaptermark[1]{\label{ch:#1}\orichaptermark{#1}}
\let\orisectionmark\sectionmark
\renewcommand\sectionmark[1]{\label{sec:#1}\orisectionmark{#1}}
\let\orisubsectionmark\subsectionmark
\renewcommand\subsectionmark[1]{\label{sec:#1}\orisubsectionmark{#1}}

%creates an intentionally blank page
\newcommand\blankpage{
	\null
    \thispagestyle{plain}
    \begin{center}
    \textsc{\large The rest of this page intentionally left blank.}
    \end{center}
    \newpage
}

%increase the vertical spacing in tabu tables
\tabulinesep=^5pt

%New command to make the lines in the title page
\newcommand{\HRule}{\rule{\linewidth}{0.5mm}}

\providecommand\addchaptertocentry[1]{%
\ifdef{\phantomsection}{\phantomsection}{}% The \phantomsection command is necessary for hyperref to jump to the correct page
\addcontentsline{toc}{chapter}{#1}%
}

%hacky fix for changing the headings in Intro material and Appendices
\newif\ifintro %boolean for introductory material section
\newif\ifappendix %boolean for appendix

%add a page break before every new section and subsection if desired
\newcommand{\sectionbreak}{\clearpage}

%macro for inserting images
\newcommand{\insertimage}
[2]%number of input arguments
%input should be {image name} {description of image}
{
  \begin{figure}[H]
  \begin{center}
  \includegraphics[height=265pt,width=\linewidth,keepaspectratio]{#1}\\
  \caption{#2}
  \label{fig:#1} %for future reference
  \end{center}
  \end{figure}
  \vspace{-24pt} %assistance in spacing, kind of a hack but it works
  ~\par %forces the next line to be indented
  \vspace{-12pt} %more spacing
}

%allow more than just three levels of bulleting
\setlistdepth{9}

\setlist[itemize,1]{label=$\bullet$}
\setlist[itemize,2]{label=$\circ$}
\setlist[itemize,3]{label=$\triangleright$}
\setlist[itemize,4]{label=$\bullet$}
\setlist[itemize,5]{label=$\bullet$}
\setlist[itemize,6]{label=$\bullet$}
\setlist[itemize,7]{label=$\bullet$}
\setlist[itemize,8]{label=$\bullet$}
\setlist[itemize,9]{label=$\bullet$}

\renewlist{itemize}{itemize}{9}

%Create Strikethrough command for tables
\newcounter{NoTableEntry}
\renewcommand*{\theNoTableEntry}{NTE-\the\value{NoTableEntry}}

\newcommand*{\strike}[2]{%
  \multicolumn{1}{#1}{%
    \stepcounter{NoTableEntry}%
    \vadjust pre{\zsavepos{\theNoTableEntry t}}% top
    \vadjust{\zsavepos{\theNoTableEntry b}}% bottom
    \zsavepos{\theNoTableEntry l}% left
    \hspace{0pt plus 1filll}%
    #2% content
    \hspace{0pt plus 1filll}%
    \zsavepos{\theNoTableEntry r}% right
    \tikz[overlay]{%
      \draw
        let
          \n{llx}={\zposx{\theNoTableEntry l}sp-\zposx{\theNoTableEntry r}sp-\tabcolsep},
          \n{urx}={\tabcolsep},
          \n{lly}={\zposy{\theNoTableEntry b}sp-\zposy{\theNoTableEntry r}sp},
          \n{ury}={\zposy{\theNoTableEntry t}sp-\zposy{\theNoTableEntry r}sp}
        in
        (\n{llx}, \n{lly}) -- (\n{urx}, \n{ury})
      ;
    }%
  }%
}

%Commands required for git/phabricator branching diagrams
\newcommand\commit[2]{\node[commit] (#1) {}; \node[clabel] at (#1) {\texttt{#1}: #2};}
\newcommand\ghost[1]{\coordinate (#1);}
\newcommand\connect[2]{\path (#1) to[out=90,in=-90] (#2);}

%-----------------------------------------
% Creating Environments
%-----------------------------------------
\newenvironment{Design Methodology}
{
	%\renewcommand{\subsection{\stdsubsection}
}
{
	\par
	\bigskip %ends the paragraph and adds a line break before next subsection
}

\newenvironment{Build Timeline}
{
	\noindent\textbf{Build Timeline}
	\\
}
{}

\newenvironment{Resources}
{
	~\\
	\noindent\textbf{Resources}
    \\
    \begin{enumerate}
    \vspace{-24pt}
}
{
	\end{enumerate}
}


%-----------------------------------------
% Penalties
%-----------------------------------------

\doublehyphendemerits=10000 % No consecutive line hyphens
\brokenpenalty=10000 % No broken words across columns/pages
\widowpenalty=9999 % Almost no widows at bottom of page
\clubpenalty=9999 % Almost no orphans at top of page
\interfootnotelinepenalty=9999 % Almost never break footnotes

%-----------------------------------------
% Document Formatting Settings
%-----------------------------------------
%Iteration heading formatting
\makeatletter
\def\@makechapterhead#1{%
  \vspace*{0\p@}%
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
        %\huge\bfseries \@chapapp\space \thechapter
        \ifintro
        	\thispagestyle{Intro}
        	\Huge\bfseries Section \thechapter.\space%
        \else
        	\ifappendix
        		\thispagestyle{Appendix}
        		\Huge\bfseries Appendix \thechapter.\space%
            \else
        		\thispagestyle{Iterations}
        		\Huge\bfseries Iteration \thechapter.\space%
        	\fi
        \fi
        %\par\nobreak
        %\vskip 20\p@
      \fi
    \fi
    \interlinepenalty\@M
    \Huge \bfseries #1\par\nobreak
    \vskip 20\p@
  }}

%increase space between section number and title in TOC
\setlength{\cftchapnumwidth}{2em}
\setlength{\cftsecnumwidth}{3em}
\setlength{\cftsubsecnumwidth}{4em}

\makeatletter
     \renewcommand*\l@figure{\@dottedtocline{1}{1em}{3.2em}}
\makeatother

%reset the chapter numbers for each part
\makeatletter
\@addtoreset{chapter}{part}
\makeatother

%increase size of the subsubsection headers
\titleformat*{\subsubsection}{\large\bfseries}

%-----------------------------------------
% Header and Footer Settings
%-----------------------------------------
\fancypagestyle{Iterations} %defines the header and footer style for the body of the document
{
  \fancyhead{}
  \headheight=14.5pt
  \lhead{\textsc{\teamname}}
  \chead{}
  \rhead{\textsc{Iteration \thechapter}}
  \lfoot{}
  \cfoot{}
  \rfoot{\textsc{Page \thepage}}
  \renewcommand{\headrulewidth}{0.4pt}
}

\fancypagestyle{Intro} %defines the header and footer style for the intro of the document
{
  \fancyhead{}
  \headheight=14.5pt
  \lhead{\textsc{\teamname}}
  \chead{}
  \rhead{\textsc{Section \thechapter}}
  \lfoot{}
  \cfoot{}
  \rfoot{\textsc{Page \thepage}}
  \renewcommand{\headrulewidth}{0.4pt}
}

\fancypagestyle{Appendix} %defines the header and footer style for the Appendix
{
  \fancyhead{}
  \headheight=14.5pt
  \lhead{\textsc{\teamname}}
  \chead{}
  \rhead{\textsc{Appendix \thechapter}}
  \lfoot{}
  \cfoot{}
  \rfoot{\textsc{Page \thepage}}
  \renewcommand{\headrulewidth}{0.4pt}
}

\fancypagestyle{plain}
{
  \fancyhead{}
  \headheight=14.5pt
  \lhead{\textsc{\teamname}}
  \chead{}
  \rhead{}
  \lfoot{}
  \cfoot{}
  \rfoot{\textsc{Page \thepage}}
  \renewcommand{\headrulewidth}{0.4pt}
}
%-----------------------------------------
% Define Notebook Information
%-----------------------------------------

%defines all info for current season globally
\newcommand*{\currentseason}[1]{\gdef\currentseason{#1}}
\newcommand*{\currentgame}[1]{\gdef\currentgame{#1}}
\newcommand*{\division}[1]{\gdef\division{#1}}

\newcommand*{\teamname}[1]{\gdef\teamname{#1}}
\newcommand*{\teamnumber}[1]{\gdef\teamnumber{#1}}

%-----------------------------------------
% Introductory Material Formatting
%-----------------------------------------
\NewDocumentEnvironment{Introductory Material}
{}
{
	%Make the numbering format roman numerals
	\renewcommand{\thechapter}{\roman{chapter}}
    \renewcommand{\thesection}{\thechapter.\roman{section}}
    \renewcommand{\thesubsection}{\thesection.\roman{subsection}}

}

%-----------------------------------------
% PDF Setup
%-----------------------------------------
\hypersetup{pdfpagemode={UseOutlines},
bookmarksopen=true,
bookmarksopenlevel=0,
hypertexnames=false,
colorlinks=true, % Set to false to disable coloring links
citecolor=blue, % The color of citations
linkcolor=red, % The color of references to document elements (sections, figures, etc)
urlcolor=blue, % The color of hyperlinks (URLs)
pdfstartview={FitV},
unicode,
breaklinks=true,
}

%-----------------------------------------
\endinput
