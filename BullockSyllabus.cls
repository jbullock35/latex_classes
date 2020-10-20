% BullockSyllabus.cls
% created 2017 09 17 from BullockArticle.cls

\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{BullockSyllabus}[2017/09/16 v0.1 Custom class for John Bullock's syllabi]

% Passes and class options to the underlying article class
\newif\ifjustified
\newif\ifwideMargins
\DeclareOption{justifiedText}{\justifiedtrue}
\DeclareOption{wideMargins}{\wideMarginstrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}%
\ProcessOptions%
\LoadClass[letterpaper, 12pt, oneside]{article}

\usepackage{ifxetex}
\newcommand{\setNormalFontSize}{\fontsize{12bp}{14.4bp}\selectfont}  % needs to be set before caption section



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PAGE LAYOUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\frenchspacing
\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000     % avoid orphans and widows.
%\relpenalty=0                 % split inline math expressions at relations operators, e.g., =
%\binoppenalty=0
\predisplaypenalty=5000        % permit a page to begin with a displayed (not in-text) equation
%\sloppy % permits some line breaks, esp. where inline math would go over the edge

% SET PAGE MARGINS
% For use with fancyhdr, headheight needs to be at least 14.5pt.
% If it isn't, fancyhdr will throw a warning about headheight in
% the error log, and the top margins on the first page will
% differ from those that follow.  [2016 06 27]
%
% Note that the page margins are currently the same whether or not
% I use the "wideMargins" option.  [2017 09 16]
\ifwideMargins
  \usepackage[pdftex, tmargin=1.25in, bmargin=1in, hmargin=1.25in, headheight=.6in]{geometry} % headsep=28.8bp
\else
  \usepackage[pdftex, tmargin=1.25in, bmargin=1in, hmargin=1in, headheight=.6in]{geometry} % headsep=28.8bp
\fi


%\usepackage{chngpage}
\usepackage{pdflscape}                 % allows typesetting individual pages as landscape
\usepackage{afterpage}                 % delays arguments until after their page is typeset.  Useful for landscaped floats.
\usepackage{float}                     % allows for the [H] -- here, period -- float specification
\setcounter{totalnumber}{1}            % no more than one float per page
\renewcommand{\floatpagefraction}{.05} % permit lots of white space on a float page -- and thus no more than one per page
\renewcommand{\topfraction}{.99}       % permit float at top    of page to take up X% of page (the max is really less)
\renewcommand{\bottomfraction}{.99}    % permit float at bottom of page to take up X% of page (the max is really less)
\newlength\oldheadheight
  \setlength\oldheadheight{\headheight}
\newlength\oldheadsep
  \setlength\oldheadsep{\headsep}
\newlength\oldtextheight
  \setlength\oldtextheight{\textheight}
%\addtolength{\headheight}{.25in}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GRAPHICS AND PDF SETUP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%\usepackage[pdftex]{graphics} % graphicx has problems with clipping.  Use graphics.
\setlength\belowcaptionskip{.3in}

\usepackage[font=rm, labelfont={it}, justification=RaggedRight, margin={0in}, parskip=0pt]{caption}
  \setlength{\textfloatsep}{30pt plus 2pt minus 2pt}
  \DeclareCaptionFont{11pt}  {\fontsize{11.0pt}{13.2pt}\selectfont}
  \DeclareCaptionFont{11.5bp}{\fontsize{11.5bp}{13.8bp}\selectfont}
  \DeclareCaptionFont{normal}{\setNormalFontSize}
  \DeclareCaptionLabelFormat{noindent}{\bothIfFirst{\noindent\hspace*{-\RaggedRightParindent}#1\ }{#2}}
  \DeclareCaptionLabelFormat{cont}{\selectfont\bothIfFirst{\noindent\hspace*{-\RaggedRightParindent}#1\ }{#2\alph{ContinuedFloat}}}
  \DeclareCaptionJustification{justifyBoth}{\justifying}
  \DeclareCaptionJustification{RR}{\setlength\RaggedRightParindent{\captionIndent}\RaggedRight}

  \ifjustified
    \captionsetup[figure]{font=normal, labelformat=noindent, aboveskip=32bp, justification=justifyBoth}
    \captionsetup[table] {font=normal, labelformat=noindent, aboveskip=20bp, justification=justifyBoth}
  \else
    \captionsetup[figure]{font=normal, labelformat=noindent, aboveskip=32bp, justification=RaggedRight}
    \captionsetup[table] {font=normal, labelformat=noindent, aboveskip=20bp, justification=RaggedRight}
  \fi
  \captionsetup[ContinuedFloat]{font=normal, labelformat=cont}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MATH COMMANDS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage{mathcommands}  % my own package



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FONT COMMANDS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage{fontcommands}
  % 2013 02 02: I tried using microtype to kern right single apostrophes.  No success.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEXT SPACING AND JUSTIFICATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To keep text from breaking at an inconvenient place, just put it in an \mbox{}.
% Load the ragged2e package after fonts and font sizes have been established.  (Companion 2e, 106.)
\newlength{\indentSize}
\ifwideMargins
  \setlength{\indentSize}{.425in}
\else
  \setlength{\indentSize}{.5in}
\fi

\ifjustified
  \usepackage{ragged2e}  % still needed for some caption material
  \setlength\parindent{\indentSize}
  \setlength\RaggedRightParindent{0in}
  \lefthyphenmin=3  % at least three characters before a hyphen
\else
  \usepackage[document]{ragged2e}
    \setlength\JustifyingParindent{0in}
    \setlength\RaggedRightParindent{\indentSize}
  \usepackage[none]{hyphenat}  % doesn't allow line breaks even when a word has a hyphen
\fi

\setlength\RaggedRightRightskip{0pt plus .6in} %  for hyphenation % .6
% \hyphenpenalty=10000
% \renewcommand{\hyp}{-\newline}
\usepackage{setspace}        % for working with spacing.  See setspace.sty for instructions
\usepackage{relsize}         % for relative font sizing
\usepackage{indentEnvirons} % my own package, for the "Quote", "Indent.5in" environs, etc.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BOOLEANS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage{ifthen}
\newboolean{anon}
\newboolean{haveTAs}

\usepackage[xxx]{optional}
  %\usepackage[note,notes]{optional}  % for editing.  I think all documentation is in optional.sty.
                               % See also TLC2 21-22.
                               % "nothing" -- print no comments to self
                               % "note" -- print general notes
                               % "not_xxx"--- DO PRINT comments that are not to be seen by xxx
  \newcommand{\optnote}[1]{\opt{note}{#1}}
  \newcommand{\optbnote}[1]{\opt{note}{\textbf{#1}}}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HEADERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage{datetime} % For formatting time of day on the title page.
  \usdate % print in format "March 2, 2002"
  \newdateformat{mydateformat}{\THEYEAR~\monthname[\THEMONTH]~\THEDAY}
  \settimeformat{ampmtime}
\usepackage{color}
  \definecolor{gray}{gray}{.50}

\usepackage{fancyhdr} % allows me to customize headers and footers
  \pagestyle{fancy}
  \lhead{
    \color{gray}%
    %\today\\
    %\ifthenelse{\boolean{anon}}{}{\today~(\currenttime)}
  }
  \rhead{\thepage}
  \cfoot{\ }
  \renewcommand{\headrulewidth}{0pt} % gets rid of the header rule

\makeatletter
\newcommand\restoreHead{
  \lhead{
    \color{gray}%
    %\today\\
    %\ifthenelse{\boolean{anon}}{}{\today~(\currenttime)}
  }
  \rhead{\thepage}
}
\makeatother

% useful if I change the page margins in the middle of the document
\makeatletter
  \newcommand{\resetHeadWidth}{\fancy@setoffs}
\makeatother



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FOOTNOTES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage[big]{footnotecommands} % options are "big", "doublespace"



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION HEADINGS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setcounter{secnumdepth}{-2} % Don't number sections
\makeatletter
\renewcommand\section{\@startsection
    {section}{1}{0in}%           % name, level, indent
    {-2.25\baselineskip}%         % beforeskip
    {.25\baselineskip}%                     % afterskip -- must be positive for a display heading
    {%\bfseries%
     \fontsize{16.5bp}{20bp}\selectfont}}%
\makeatother


\makeatletter
\renewcommand\subsection{\@startsection
    {subsection}{2}{0in}%         % name, level, indent
    {-1.75\baselineskip}%         % beforeskip
    {.01in}%                      % afterskip -- must be positive for a display heading
    {%\bfseries
     \fontsize{14.5bp}{14.5bp}\selectfont%
     \scshape%
     \phantomsection
     \MakeLowercase%
    }%
}%
\makeatother


\makeatletter
\renewcommand\subsubsection{\@startsection
    {subsubsection}{3}{0in}%         % name, level, indent
    {-1.5\baselineskip}%           % beforeskip
    {.01in}%                      % afterskip -- must be positive for a display heading
    {%\bfseries
     %\scshape%
     \it
     \fontsize{12bp}{12bp}\selectfont}%
}%
\makeatother



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TABLES AND ARRAYS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Set rule widths in tables.
% For \toprule and \bottomrule, 08em is the default.
% For \cmidrule, .03em is the default.
\usepackage{booktabs}
  \setlength{\heavyrulewidth}{.05em} %
  \setlength{\belowrulesep}{2.0ex}   % for \cmidrule.  .08ex is the default.


\usepackage{array} % improves the tabular environment
  \setlength{\extrarowheight}{7pt}   % adding 1pt of space to every row in every table
%\usepackage{dcolumn}                  % for aligning on decimal point.  But it always prints cells in math mode.
%  \newcolumntype{d}{D{.}{.}{2}}
\usepackage[autolanguage, noaddmissingzero, warning]{numprint}
                                       % in tables, numprint allows for decimal alignment of numbers in text mode
                                       % note: warning switches -off- warnings.  (I don't want warnings about negative signs.)
  \npfourdigitnosep % print "6002.54" instead of "6,002.45"
\newcommand{\ph}[1][1]{\phantom{#1}}   % for quick alignment of cell entries without using the dcolumn package
\newcommand{\tabcent}[1] {\multicolumn{2}{c}{#1}}
\newlength{\standardExtraColSep}
\setlength{\standardExtraColSep}{\extracolsep}
% To add space between columns, a dirty fix is something like column type N{5}{2} where I would
% ordinarily put N{1}{2}.  It's dirty because it doesn't correctly align everything, e.g.,
% "N & {{402}}" at the bottom of the page.  (The "402" gets left-aligned.)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MISCELLANEOUS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage{url}
  \urlstyle{same}
%\usepackage{bpchem} % For superscripts and subscripts in ordinary text.
\usepackage[draft=false,               % to find citations that break across page boundaries (which cause problems), set draft=true
            breaklinks=true,
            pdfpagemode=UseOutlines,  % If "None," bookmarks don't show on open.
            bookmarks=true,           % Put hyperref before natbib but close to the end of the preamble
            bookmarksopen=true,
            bookmarksopenlevel=2,
            dvipdfmx-outline-open,
            colorlinks=true,
            urlcolor=blue,
            %pagecolor=blue,
            linkcolor=black, % makes footnotes black
            anchorcolor=black,
            citecolor=black,
            filecolor=red,
            linkbordercolor={1 1 1},
            hyperfootnotes=false,
            %pagebackref=true,
            ]{hyperref}
%\def\sectionautorefname{Section} % when using \autoref{Sec_1}, I will get a link to "Section 1"

\newenvironment{changemargin}[2]{%
  \begin{list}{}{%
    \setlength{\topsep}{0pt}%
    \setlength{\partopsep}{0pt}% extra rubber space added to \topsep at top and bottom of environment
    \setlength{\leftmargin}{#1}%
    \setlength{\rightmargin}{#2}%
    \setlength{\listparindent}{\parindent}%
    \setlength{\itemindent}{\parindent}%
    \setlength{\parsep}{\parskip}%
  }%
  \item[]}{\end{list}}
\newcounter{appendixcount}
\renewcommand\theappendixcount{\Alph{appendixcount}}

% ELLIPSES
% Using "..." doesn't work: the dots are too close together.
% \ldots is better, but it isn't spaced well against adjacent punctuation.
\usepackage{moredefs, lips}
  % For ellipses.  \lips requires the moredefs package.
  % We can also try the "ellipsis" package."
