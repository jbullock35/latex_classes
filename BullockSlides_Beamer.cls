\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{BullockSlides_Beamer}[2017/09/21 v0.1 Custom class for John Bullock's slides]


% Passes and class options to the underlying article class
\newif\ifjustified
\newif\ifwideMargins
\DeclareOption{justifiedText}{\justifiedtrue}
\DeclareOption{wideMargins}{\wideMarginstrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}%
\ProcessOptions%
\LoadClass[xetex,professionalfonts,14pt,t,compress]{beamer}
%\documentclass[handout,professionalfonts,14pt,t,compress]{beamer}
  % [handout] removes overlays
  % [14pt] is a special option to make the text big
  % [t] top-justifies the inner frame text
  % [c] is the default; it center-justifies the inner frame text
  %
  %\documentclass{beamer}           % for default, 11-pt body text
  %\documentclass[17pt]{beamer}
  %\documentclass[compress]{beamer} % for one-line headlines

\newcommand{\setNormalFontSize}{\fontsize{12bp}{14.4bp}\selectfont}  % needs to be set before caption section
\mode<presentation> {
  \usetheme{BullockMalmoe}
  %\usetheme{Bullock} % Blue background, thick headers
  %\usetheme{Malmoe}
  \setbeamertemplate{navigation symbols}{}  % get rid of the PDF navigation symbols at bottom of inner frame
  \setbeamertemplate{itemize items}[circle]
  %\setbeamertemplate{footline}{\hfill{\insertframenumber\hspace*{.067in}\vspace*{.05in}}}
    %\setbeamertemplate{footline}[page number] % gives current_page / total_pages
  %\usecolortheme{sidebartab}

  % TEXT TO BE UNCOVERED
  % To entirely hide text more than one step away, use
  % \opaqueness<2->{0}.%
  \setbeamercovered{still covered={%
    \opaqueness<1>{60}%
    \opaqueness<2->{60}%
  }}
  %\setbeamercovered{transparent=60} % transparent=xx; xx% of the "hidden" text shows through
  %\setbeamercovered{still covered={\opaqueness<1->{55}}} % same as \setbeamercovered{transparent=55}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BOOLEANS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BOOLEAN LOGIC
% \usepackage{optional} doesn't seem to work with Beamer.
% thickfootline is for Harvard and other places where screen doesn't
%   drop down quite far enough.  Note that I will also need to change
%   the footline settings in beamerouterthemesplit_BullockMalmoe.sty
%   when this changes. [2011 03 24]
%     Unfortunately, the \footline lengths set here don't seem to be
%   useful.  I keep them here just as a reference to the proper "thick"
%   and "thin" footline measurements; they serve no other purpose.
%   [2011 03 24]
\usepackage{ifthen}
  \newboolean{handout}
    \setboolean{handout}{FALSE} % use \documentclass[handout] to remove overlays
  \newboolean{thickfootline}
    \setboolean{thickfootline}{TRUE}
    \newlength{\footlineheight}
    \newlength{\footlinedp}
    \ifthenelse{\boolean{thickfootline}}{
      \setlength{\footlineheight}{4ex}
      \setlength{\footlinedp}{2.375ex}
    }{
      \setlength{\footlineheight}{3ex}
      \setlength{\footlinedp}{1.375ex}
    }



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HANDOUTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pgfpages doesn't seem to work with XeLaTeX.  So use
% pdflatex when creating handouts.  [2010 09 02]
% be sure to use the [handout] argument to \documentclass to remove overlays [2010 09 20]
\ifthenelse{\boolean{handout}}{
  \setbeamercolor{background canvas}{bg=black!5} % light grey background to distinguish slides
  \usepackage{pgfpages}
  \pgfpagesuselayout{4 on 1}[letterpaper,landscape,border shrink=5mm] % could be 2 on 1
  \setbeamercolor*{normal text}{fg=black,bg=white}
  \setbeamercolor*{titlelike}{fg=black,bg=white}
  \setbeamercolor*{item}{fg=black,bg=white}
  \setbeamercolor*{page number in head/foot}{fg=black}
}{}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FONTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage{fontcommands} % my own package of font commands
\setbeamerfont{frametitle}{size=\large}
  % \setbeamerfont{frametitle}{size=\large,series=\bfseries}
  % \setbeamerfont{item}{size=\large}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PAGE GEOMETRY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% use \begin{changemargin}{addtoleft}{addtoright} after \begin{frame} to change individual frames
  \usepackage{chngpage}
  \newenvironment{changemargin}[2]{%
    \begin{list}{}{%
      \setlength{\topsep}{0pt}%
      \setlength{\leftmargin}{#1}%
      \setlength{\rightmargin}{#2}%
      \setlength{\listparindent}{\parindent}%
      \setlength{\itemindent}{\parindent}%
      \setlength{\parsep}{\parskip}%
    }%
    \item[]}{\end{list}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NEW AND REDEFINED ENVIRONMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % LEFT MARGINS
  % It's hard to get item labels set flush left against the left margin so that they line up with paragraph text.  [2010 09 16]
  \newlength{\lefttextmargin}
  \setlength{\lefttextmargin}{1.40em}
  \newlength{\leftitemmargin}
  \setlength{\leftitemmargin}{\lefttextmargin}
  \addtolength{\leftitemmargin}{.75em}
  \ifdim 1in > 0in
    \setbeamersize{text margin left = \lefttextmargin} % aligns paragraph text with left-hand side
    \setbeamersize{sidebar width left = 0em}
    \setlength{\leftmargini}{\leftitemmargin}
    %\addtolength{\leftmargini}{-\labelwidth}          % changes more than the item indentation
    \setlength{\leftmarginii}{2.05ex}

    % Left margin for frametitle.  Without these commands, it's indented a bit more than ordinary text.
    % The parbox is required to ensure that titles with multiple lines are all outdented to the same
    % degree [2010 09 16]
    \setbeamertemplate{frametitle}{%
      \hspace*{-.03em}%
      \parbox{\textwidth}{\flushleft\insertframetitle}%
      \vspace*{.11in}%
    }
  \fi


  % LIST PARAMETERS
  % This gets the item indentation right, but the \addtolength line screws up the title indentation
  %\makeatletter
  %  \let\leftmargini=\beamer@leftmargin
  %\makeatother
  %\addtolength{\leftmargini}{0em} % screws up title indentation

  % Seemingly useless in a Beamer preamble
  %\setlength\leftmargin{0in}       % space before label box; seems to have no effect
  %\setlength\labelwidth{0in}       % width of label box (label right-aligned within box)
  %\setlength\labelsep{.3in}        % space after label
  %\setlength\itemindent{0in}       % indent of first line
  %\setlength\topsep{\baselineskip} % skip before first item
  %\setlength\itemsep{0in}          % skip between items

  % ADJUST SPACING IN LISTS
  \ifdim 1in > 0in
    \makeatletter
      \def\@listi{%
        \leftmargin \leftmargini
        \topsep 3\p@ \@plus2\p@ \@minus2.5\p@
        \parsep 0\p@
        %\itemsep3\p@ \@plus2\p@ \@minus3\p@}
        \itemsep10\p@ \@plus2\p@ \@minus3\p@%
      }
      \let\@listI\@listi
      \def\@listii{\leftmargin\leftmarginii
        \topsep 2\p@ \@plus1\p@ \@minus2\p@
        \parsep 0\p@ \@plus\p@
        \itemsep \parsep}
      \def\@listiii{\leftmargin\leftmarginiii
        \topsep 2\p@ \@plus1\p@ \@minus2\p@
        \parsep 0\p@ \@plus\p@
        \itemsep \parsep}
    \makeatother
  \fi

  % NEW ENVIRONMENTS
  \newenvironment{Quote}%
    {\begin{list}{}%
                 {\setlength\leftmargin{.35in}%
                  %\setlength\rightmargin{1in}%
                  \fontsize{.9em}{1.08em}\selectfont%
                  }
                  \item[]}
                  {\end{list}}
  \newenvironment{Indent.5in}%
    {\begin{list}{}%
                 {\setlength\leftmargin{.5in}
                  \setlength\parsep{0in}}
                  \item[]}
                  {\end{list}}

  % If you wish to uncover everything in a step-wise fashion, uncomment
  % the following command:
      %\beamerdefaultoverlayspecification{<+->}

  % ADD HORIZONTAL SPACE TO SECTION NAMES IN FOOTERS
  \newcommand\aftersectionspace{\hspace*{3.5em}} % can be set in a subsidiary file with \renewcommand
  %\newlength{\aftersectionspace}
  %\setlength{\aftersectionspace}{2.75em}
  %\let\oldsection\section
  %\renewcommand{\section}[2][]{\oldsection[#1]{#2\aftersectionspace}}

  % SAVE ITEM NUMBERS ACROSS LISTS
  \newcounter{enumsave} % \setcounter{enumsave}{\value{enumi}}, \setcounter{enumi}{\value{enumsave}}
  \newcounter{enumtmp}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TABLES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%\renewcommand\frametitle[1][]{\frametitle[#1]\vspace*{1in}}
%\renewcommand\frametitle[1][]{\vskip2pt plus.5fill\oldft[#1]}
%\let\oldtable\table
%\renewcommand\table[1][]{\oldtable[#1]\sffamily\relscale{.9}}
%\newcounter{tablecount}
%\newenvironment{tablefigure}{\begin{figure}[t]\refstepcounter{tablecount}}{\end{figure}\addtocounter{figure}{-1}}
%\newenvironment{tablefigurehere}{\begin{figure}[h]}{\end{figure}\addtocounter{figure}{-1}}
\usepackage{tabulary}
\ifxetex
  \usepackage{booktabs} % provides \addlinespace for tables
\else
  \usepackage{booktabs}
    \setlength{\heavyrulewidth}{.08em} % for \toprule and \bottomrule.  .08em is the default.
    \setlength{\belowrulesep}{1.2ex}   % for \cmidrule.  .08ex is the default.
  \usepackage{array} % improves the tabular environment
    \setlength{\extrarowheight}{1.2pt}
  \usepackage[autolanguage, noaddmissingzero, warning]{numprint}
                                     % in tables, numprint allows for decimal alignment of numbers in text mode
                                     % note: warning switches -off- warnings.  (I don't want warnings about negative signs.)
    \npfourdigitnosep % print "6002.54" instead of "6,002.45"
\fi
\newcommand{\ph}[1][1]{\phantom{#1}}   % for quick alignment of cell entries without using the dcolumn package
% To add space between columns, a dirty fix is something like column type N{5}{2} where I would
% ordinarily put N{1}{2}.  It's dirty because it doesn't correctly align everything, e.g.,
% "N & {{402}}" at the bottom of the page.  (The "402" gets left-aligned.)
%\newcommand{\sigstar}{{\relsize{-1}\BPChem{\^*}}}
%\newcommand{\sigplus}{{\relsize{-1}\BPChem{\^+}}}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GRAPHICS AND FIGURES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To put an image in the background, just use
% {
%   \usebackgroundtemplate{\includegraphics[width=\paperwidth, height=\paperheight]{tmpimage.png}}
%   \begin{frame}{frametitle}
%   \end{frame}
%}
%   Spaces in the filename can cause weird problems.  For example,
% they can cause an image to be weirdly right-shifted on the slide.
% [2011 03 20]

%\usepackage{etex}        % helps with the xy package
%\usepackage[all,pdf]{xy} % for diagrams
\usepackage{graphics}     % for importing graphics
\usepackage{tikz}         % for overlays of pictures and "greying out" of slides
\newcommand{\greyout}[2]{%
    % Overlays slide with a semitransparent block of color.
    % Usage: \greyout{gray}{.8} or \greyout{red}{.5}.
    % Position of the command within a frame determines what is
    %   "grayed out": only the frame title and the text that
    %   comes before the command will be affected.
    % "Grey" is not an accepted spelling.
\begin{tikzpicture}[overlay, fill opacity=#2]
  \fill[#1] (-20,-20) rectangle (20,20);%
\end{tikzpicture}%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BIBLIOGRAPHY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage{bibentry,natbib}
  \bibpunct{(}{)}{;}{a}{}{,} % Natbib.dvi pg 12.  2nd-to-last arg. controls punctuation before yr. of cite.
\bibliographystyle{apsr2006_syllabi}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PDF: HYPERREF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hyperref is automatically loaded by Beamer when in presentation mode.
% But the "bookmarksopenlevel" c+ommand here makes no difference.
%\hypersetup{bookmarksopen=true,bookmarksopenlevel=3}
\hypersetup{pdfpagemode=UseOutlines,    % If "None," bookmarks don't show on open.
          bookmarksopen=true,
          bookmarksopenlevel={1},
          colorlinks=true,
          urlcolor=blue,
          linkcolor=black, % makes footnotes black
          anchorcolor=black,
          citecolor=black,
          filecolor=red,
          linkbordercolor={1 1 1},
          hyperfootnotes=false,
          pdfauthor={John G. Bullock}}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MISCELLANY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage{setspace}
\def\Quran{Qur'\!\!\;an}   % properly kerned
\usepackage{moredefs,lips} % for ellipses
\usepackage{url}
  \urlstyle{same}
\newlength{\quotewidth}   % for outdenting quoted passages
  \settowidth{\quotewidth}{``}
  \setlength{\quotewidth}{1.35\quotewidth}
\newlength{\starwidth}    % for outdenting asterisks
  \settowidth{\starwidth}{*}
  \setlength{\starwidth}{1.2\starwidth}
