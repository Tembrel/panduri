\version "2.23.4"

%
% Used to align gamut marking below, but generally useful.
% Takes two arguments, the alignment amount (#LEFT = -1,
% #RIGHT = 1) and the markup text for the mark.
%

markAligned = 
#(define-music-function
  (amount text)
  (number? markup?) 
  #{
    \once \override 
      Score.RehearsalMark.self-alignment-X = #amount
    \mark #text
  #}
)


%
% Define gamut score. To insert gamut staff into piece,
% add \gamutStaff at top level. 
% 

gamutMusic = \relative c, {
  d1  e  f  g  a  b  c  d  e  f  g  a  b  c  d
}

gamutText = \lyricmode {
  D E F G A B C D E F G A B C D  
}

gamutSettings = \with {
  % Slightly smaller staff for gamut. 7/8 ratio is a bit
  % arbitrary, but it corresponds to the fraction of an
  % equal-tempered step covered by each step of the gamut.
  \magnifyStaff #7/8
  
  \omit Staff.TimeSignature
  \omit Staff.BarLine
  
  \override Clef.stencil = #ly:text-interface::print
  \override Clef.text = \markup \char ##x10E4
  \override Clef.font-name = #"Georgia"
  \override Clef.font-size = #7
  \override Clef.Y-offset = #(* -1 (magstep -3))

  % Adjust position of middle C. Both properties have
  % to be set for both the music and the ambitus to be
  % properly positioned vertically.
  
  middleCPosition = \middleCPosition
  middleCClefPosition = \middleCPosition
}

gamutStaff = \score {
  <<
    \new Staff \with \gamutSettings
      \new Voice = "gamut" { 
        \markAligned #-0.75 \markup { 
            \small \italic 
            "tuning gamut: all steps ≈ 7/8 EQ step"
        }
        \gamutMusic
      }
    \new Lyrics \lyricsto "gamut" \gamutText
  >>
  
  \header {
    piece = ""
  }

  \layout {
    indent = #0
    ragged-right = ##f
  }
}

\markup { \vspace #1.2 } 

\gamutStaff

\header {
  %{piece = \markup { 
    \fromproperty #'header:title 
  }%}
}


%{
convert-ly (GNU LilyPond) 2.23.4  convert-ly: Processing `'...
Applying conversion: 2.19.16, 2.19.22, 2.19.24, 2.19.28, 2.19.29,
2.19.32, 2.19.39, 2.19.40, 2.19.46, 2.19.49, 2.20.0, 2.21.0, 2.21.2,
2.23.1, 2.23.2, 2.23.3, 2.23.4
%}
