%---------------------------------------------------------------------------%
%-                                                                         -%
%-                           Document Class                                -%
%-                                                                         -%
%---------------------------------------------------------------------------%
%- Copyright (C) Huangrui Mo <huangrui.mo@gmail.com> 
%- This is free software: you can redistribute it and/or modify it
%- under the terms of the GNU General Public License as published by
%- the Free Software Foundation, either version 3 of the License, or
%- (at your option) any later version.
%---------------------------------------------------------------------------%
%->> Identification
%---------------------------------------------------------------------------%
\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{ucasproposal}[2014/10/01 v0.1 LaTeX document class]%
%---------------------------------------------------------------------------%
%->> Declare options
%---------------------------------------------------------------------------%
%-
%-> Layout
%-
\DeclareOption{singlesided}{% enable single-sided printing
    \PassOptionsToClass{oneside}{ctexart}%
}
\DeclareOption{doublesided}{% enable double-sided printing
    \PassOptionsToClass{twoside}{ctexart}%
}
\newif\ifucas@printcopy \ucas@printcopyfalse
\DeclareOption{printcopy}{% enable print copy layout
    \PassOptionsToClass{twoside}{ctexart}%
    \ucas@printcopytrue%
}
%-
%-> Language
%-
\newif\ifucas@plain \ucas@plainfalse
\DeclareOption{plain}{% enable plain writing style
    \PassOptionsToClass{scheme=plain}{ctexart}%
    \ucas@plaintrue%
}
%-
%-> Draft version info
%-
\newif\ifucas@versioninfo \ucas@versioninfofalse
\DeclareOption{draftversion}{%
    \ucas@versioninfotrue%
}
%-
%-> Handle non-implemented options
%-
\DeclareOption*{%
    \PassOptionsToClass{\CurrentOption}{ctexart}%
}
%-
%-> Terminates all options processing
%-
\ProcessOptions\relax%
%---------------------------------------------------------------------------%
%->> Load class information
%---------------------------------------------------------------------------%
\LoadClass[UTF8,a4paper,zihao=-4]{ctexart}
%---------------------------------------------------------------------------%
%->> Required packages
%---------------------------------------------------------------------------%
\RequirePackage{ifxetex}% LaTeX engine detection
%---------------------------------------------------------------------------%
%->> Load class configuration
%---------------------------------------------------------------------------%
\AtEndOfPackage{% class cfg loaded after package to make preamble commands take effect
    \makeatletter
    \InputIfFileExists{Style/ucasproposal.cfg}{}{}
    \makeatother
}
%---------------------------------------------------------------------------%
%->> Page layout
%---------------------------------------------------------------------------%
%- part one -- horizontal widths
%- left side width + textwidth + right side width = paperwidth
%- binding side width + textwidth + nonbinding side width = paperwidth
%- binding side width of [odd, even] page = [left, right] side width
%- left side width of [odd, even] page = 1.0in (fixed) + hoffset + [odd, even]sidemargin
%- assuming A4 paper (210mm x 297mm)
\setlength{\textwidth}{146.6mm}% set required text width first
\setlength{\hoffset}{0mm}% set horizontal offset
\ifucas@printcopy% if print copy layout enabled
    \setlength{\oddsidemargin}{12.6mm}% binding side margin
    \setlength{\evensidemargin}{0mm}% ensure uniform binding side width for printing
\else
    \setlength{\oddsidemargin}{6.3mm}% left side margin
    \setlength{\evensidemargin}{6.3mm}% ensure uniform left side width for EThesis
\fi
\setlength{\marginparwidth}{35pt}% width of margin notes
\setlength{\marginparsep}{10pt}% width of space between body text and margin notes
%- part two -- vertical heights
%- top height + textheight + bottom height = paperheight
%- top height = 1.0in (fixed) + voffset + topmargin + headheight + headsep 
\setlength{\textheight}{246.2mm}% set required text height first
\setlength{\voffset}{-17.4mm}% set vertical offset
\setlength{\topmargin}{20pt}% vertical margin above header
\setlength{\headheight}{12pt}% header height
\setlength{\headsep}{17.5pt}% vertical margin between header and body text
\setlength{\footskip}{29.5pt}% vertical margin between footer and body text
%- specifies the amount of space between paragraphs.
\setlength{\parskip}{0.5ex plus 0.25ex minus 0.25ex}
%- line spacing
\linespread{1.5}% line space setting
\raggedbottom% prevent adding vertical white space in strange places
%- default pagestyle is page number at bottom without headers and footers
\pagestyle{plain}
%---------------------------------------------------------------------------%
%->> Style control commands
%---------------------------------------------------------------------------%
%- redefine cleardoublepage to have page style argument
\renewcommand{\cleardoublepage}[1][plain]{%
    \clearpage\if@twoside\ifodd\c@page\else%
    \thispagestyle{#1}%
    \hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi%
}
%- underline
\ifxetex% use underline from xeCJKfntef
    \renewcommand{\CJKunderlinecolor}{\color[rgb]{0,0,0}}% set underline color
    \renewcommand{\uline}[1]{\CJKunderline{#1}}% unified name
\else% use underline from ulem
    \RequirePackage{ulem}%
\fi
\newcommand{\ulenhance}[2][1pt]{% enhanced underline
    \def\ULthickness{#1}% set thickness
    \uline{#2}}
\newcommand{\ulhshift}{-3em}% horizontal shift on underline
\newcommand{\ulextend}[2][350pt]{% extend underline length
    \hbox to #1{\hfill\hspace*{\ulhshift}#2\hfill}}
%- special cell
%- \specialcell[<align2>]{align1}{text1\\text2};
%- <align1>: t,c,b; <align2> l,c,r; @{} suppress spaces before and after text 
\newcommand{\specialcell}[3][c]{%
    \begin{tabular}[#2]{@{}#1@{}}#3\end{tabular}}
%---------------------------------------------------------------------------%
%->> Titlepage
%---------------------------------------------------------------------------%
%-
%-> Chinese item commands
%-
\def\ucas@value@ch@schoollogo{}
\newcommand{\schoollogo}[2]{\def\ucas@value@ch@schoollogo{\includegraphics[#1]{#2}}}
\def\ucas@value@ch@title{}
\def\ucas@value@ch@titlemark{}
\renewcommand{\title}[2][\ucas@value@ch@title]{%
  \def\ucas@value@ch@title{#2}
  %\def\ucas@value@ch@titlemark{\MakeUppercase{#1}}}
  \def\ucas@value@ch@titlemark{#1}}
\renewcommand{\@title}{\ucas@value@ch@titlemark}
\def\ucas@value@ch@author{}
\renewcommand{\author}[1]{\def\ucas@value@ch@author{#1}}
\def\ucas@value@ch@authorid{}
\newcommand{\authorid}[1]{\def\ucas@value@ch@authorid{#1}}
\def\ucas@value@ch@advisor{}
\newcommand{\advisor}[1]{\def\ucas@value@ch@advisor{#1}}
\def\ucas@value@ch@advisortitle{}
\newcommand{\advisortitle}[1]{\def\ucas@value@ch@advisortitle{#1}}
\def\ucas@value@ch@degree{}
\newcommand{\degree}[1]{\def\ucas@value@ch@degree{#1}}
\def\ucas@value@ch@degreetype{}
\newcommand{\degreetype}[1]{\def\ucas@value@ch@degreetype{#1}}
\def\ucas@value@ch@major{}
\newcommand{\major}[1]{\def\ucas@value@ch@major{#1}}
\def\ucas@value@ch@field{}
\newcommand{\field}[1]{\def\ucas@value@ch@field{#1}}
\def\ucas@value@ch@institute{}
\newcommand{\institute}[1]{\def\ucas@value@ch@institute{#1}}
\def\ucas@value@ch@date{}
\newcommand{\chinesedate}[1]{\def\ucas@value@ch@date{#1}}
%-
%-> Redefine Chinese style
%-
\renewcommand{\maketitle}{%
    \cleardoublepage
    \thispagestyle{empty}
    \begin{center}
        \linespread{1.3}
        \zihao{-3}\bfseries
        \vspace*{10pt}

        {\ucas@value@ch@schoollogo}

        \vspace*{20pt}

        {\zihao{1}\bfseries\sffamily \ucas@label@ch@thesis}

        \vspace*{195pt}

        \def\tabcolsep{1pt}
        \def\arraystretch{1.2}
        \begin{tabular}{lc}
            %\ucas@label@ch@title & \ulenhance{\ulextend{\shortstack{\ucas@value@ch@title}}}\\
            \ucas@label@ch@title & \ulenhance{\ulextend{\specialcell[c]{b}{\ucas@value@ch@title}}}\\
            \ucas@label@ch@author & \ulenhance{\ulextend[151pt]{\hspace*{-\ulhshift}\ucas@value@ch@author}}\ucas@label@ch@authorid\ulenhance{\ulextend[170pt]{\hspace*{-\ulhshift}\ucas@value@ch@authorid}}\\
            \ucas@label@ch@advisor & \ulenhance{\ulextend[151pt]{\hspace*{-\ulhshift}\ucas@value@ch@advisor}}\ucas@label@ch@advisortitle\ulenhance{\ulextend[170pt]{\hspace*{-\ulhshift}\ucas@value@ch@advisortitle}}\\
            \ucas@label@ch@degree & \ulenhance{\ulextend{\ucas@value@ch@degreetype\ucas@value@ch@degree}}\\
            \ucas@label@ch@major & \ulenhance{\ulextend{\ucas@value@ch@major}}\\
            \ucas@label@ch@field & \ulenhance{\ulextend{\ucas@value@ch@field}}\\
            \ucas@label@ch@institute & \ulenhance{\ulextend{\ucas@value@ch@institute}}\\
            \ucas@label@ch@date & \ulenhance{\ulextend{\ucas@value@ch@date}}
      \end{tabular}

      \vspace*{50pt}

      {\ucas@label@ch@mark}
    \end{center}
    \clearpage
    \if@twoside
        \thispagestyle{empty}
        \ifucas@versioninfo
            \vspace*{\stretch{1}}
            \begin{footnotesize}
                \noindent
                Draft Version (\today)
            \end{footnotesize}
        \fi
        \cleardoublepage[empty]
    \else
        \ifucas@versioninfo
            \thispagestyle{empty}
            \vspace*{\stretch{1}}
            \begin{footnotesize}
                \noindent
                Draft Version (\today)
            \end{footnotesize}
            \cleardoublepage[empty]
        \fi
    \fi
}
%---------------------------------------------------------------------------%
%->> Structure elements
%---------------------------------------------------------------------------%
\ifucas@plain%
    \renewcommand{\contentsname}{\ucas@label@en@tocname}
    \renewcommand{\listfigurename}{\ucas@label@en@lsfigname}
    \renewcommand{\listtablename}{\ucas@label@en@lstabname}
    \renewcommand{\refname}{\ucas@label@en@bibname}
    \newcommand{\algname}{\ucas@label@en@algname}
    \newcommand{\bibetal}{\ucas@label@en@bibetal}
    \newcommand{\biband}{\ucas@label@en@biband}
    \newcommand{\axiomname}{\ucas@label@en@axiomname}
    \newcommand{\theoremname}{\ucas@label@en@theoremname}
    \newcommand{\lemmaname}{\ucas@label@en@lemmaname}
    \newcommand{\corollaryname}{\ucas@label@en@corollaryname}
    \newcommand{\assertionname}{\ucas@label@en@assertionname}
    \newcommand{\propositionname}{\ucas@label@en@propositionname}
    \newcommand{\conjecturename}{\ucas@label@en@conjecturename}
    \newcommand{\definitionname}{\ucas@label@en@definitionname}
    \newcommand{\examplename}{\ucas@label@en@examplename}
    \newcommand{\remarkname}{\ucas@label@en@remarkname}
    \renewcommand{\proofname}{\ucas@label@en@proofname}
\else
    \renewcommand{\contentsname}{\ucas@label@ch@tocname}
    \renewcommand{\listfigurename}{\ucas@label@ch@lsfigname}
    \renewcommand{\listtablename}{\ucas@label@ch@lstabname}
    \newcommand{\algname}{\ucas@label@ch@algname}
    \renewcommand{\refname}{\ucas@label@ch@bibname}
    \newcommand{\bibetal}{\ucas@label@ch@bibetal}
    \newcommand{\biband}{\ucas@label@ch@biband}
    \newcommand{\axiomname}{\ucas@label@ch@axiomname}
    \newcommand{\theoremname}{\ucas@label@ch@theoremname}
    \newcommand{\lemmaname}{\ucas@label@ch@lemmaname}
    \newcommand{\corollaryname}{\ucas@label@ch@corollaryname}
    \newcommand{\assertionname}{\ucas@label@ch@assertionname}
    \newcommand{\propositionname}{\ucas@label@ch@propositionname}
    \newcommand{\conjecturename}{\ucas@label@ch@conjecturename}
    \newcommand{\definitionname}{\ucas@label@ch@definitionname}
    \newcommand{\examplename}{\ucas@label@ch@examplename}
    \newcommand{\remarkname}{\ucas@label@ch@remarkname}
    \renewcommand{\proofname}{\ucas@label@ch@proofname}
\fi
%---------------------------------------------------------------------------%
%->> Structure elements configuration
%---------------------------------------------------------------------------%
%- section
\ctexset {
    section = {
        format = \centering\zihao{4}\sffamily,
        number = {\chinese{section}},
        aftername = \quad,
        beforeskip = {24pt},
        afterskip = {6pt},
    }
}
%- subsection
\ctexset {
    subsection = {
        format = \sffamily,
        aftername = \quad,
        beforeskip = {12pt},
        afterskip = {6pt},
    }
}
%- subsubsection
\ctexset {
    subsubsection = {
        format = \sffamily,
        aftername = \quad,
        beforeskip = {12pt},
        afterskip = {6pt},
    }
}
%---------------------------------------------------------------------------%
%->> Configure table of contents
%---------------------------------------------------------------------------%
%- the table of contents is specified by defining \l@chapter, \l@section, ...
%- most commands are then defined with the \@dottedtocline:
%- \@dottedtocline{⟨level⟩}{⟨indent⟩}{⟨numwidth⟩}{⟨title⟩}{⟨page⟩}
%- ⟨level⟩    an entry is produced only if ⟨level⟩ <= value of the tocdepth counter
%-            note, \chapter is level 0, \section is level 1, etc
%- ⟨indent⟩   indentation from the outer left margin of the start of the contents line
%- ⟨numwidth⟩ width of a box in which the section number is to go
%- <title>    title
%- <page>     page number

%- parameters for spacing and length in toc
\def\@dotsep{1.5mu}% separation between dots in mu units
\def\@pnumwidth{2em}% width of a box in which the page number is put
\def\@tocrmarg{2em}% right margin for multiple line entries, \@tocrmarg ≥ \@pnumwidth
\def\@sectionvspace{1ex}% vertical space between section titles

%- redefine dottedtocline from classes.dtx and latex.ltx
\renewcommand*{\@dottedtocline}[5]{% [<level>,<indent>,<numwidth>,<title>,<page>]
    \ifnum #1>\c@tocdepth \else
        \vskip \z@ \@plus.2\p@
        {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
        \parindent #2\relax\@afterindenttrue
        \interlinepenalty\@M
        \leavevmode \zihao{-4}\sffamily
        \@tempdima #3\relax
        \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
        {#4}\nobreak
        \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}\hfill
        \nobreak
        \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor #5}%
        \par\penalty\@highpenalty}%
    \fi
}
%- redefine l@part from article.cls to add dotted toc line
\renewcommand*{\l@part}[2]{% [<title>,<page>]
    \ifnum \c@tocdepth >-2\relax
        \addpenalty\@secpenalty
        \addvspace{2.25em \@plus\p@}%
        \setlength\@tempdima{3em}%
        \begingroup
            \parindent \z@ \rightskip \@pnumwidth
            \parfillskip -\@pnumwidth
            {\leavevmode
            \zihao{4}\sffamily #1
            \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}% add dotted toc line
            \hfil \hb@xt@\@pnumwidth{\hss #2}}\par
            \nobreak
            \if@compatibility
                \global\@nobreaktrue
                \everypar{\global\@nobreakfalse\everypar{}}%
            \fi
        \endgroup
    \fi
}
%- redefine l@section from article.cls to add dotted toc line
\renewcommand*\l@section[2]{% [<title>,<page>]
    \ifnum \c@tocdepth >\z@
        \addpenalty\@secpenalty
        \addvspace{\@sectionvspace \@plus\p@}%
        \setlength\@tempdima{1.5em}%
        \begingroup
            \parindent \z@ \rightskip \@pnumwidth
            \parfillskip -\@pnumwidth
            \leavevmode \zihao{4}\sffamily
            \advance\leftskip\@tempdima
            \hskip -\leftskip
            #1\nobreak
            \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}% add dotted toc line
            \hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
        \endgroup
    \fi
}
%- redefine indentation for others
%\renewcommand*\l@section{\@dottedtocline{1}{0em}{1em}}
\renewcommand*\l@subsection{\@dottedtocline{2}{1em}{2em}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{2em}{2em}}
\renewcommand*\l@paragraph{\@dottedtocline{4}{3em}{3em}}
\renewcommand*\l@subparagraph{\@dottedtocline{5}{4em}{3em}}
\renewcommand*\l@figure{\@dottedtocline{1}{0em}{1em}}
\renewcommand*\l@table{\@dottedtocline{1}{0em}{1em}}
%---------------------------------------------------------------------------%
\endinput

