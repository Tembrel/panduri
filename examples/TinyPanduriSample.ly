\version "2.23.6"
\language "english"

unbarred = ##t
middleCPosition = #6 % 1st leger line above staff

\include "panduri-common.ily"

\header {
  tagline = ##f
}

music = \relative c { d1 e1 }

\score {
  <<
    \music
  >>

  \layout {
    \context {
      \Score
      \ScoreDefaults
    }
    \context {
      \Staff
      \StaffDefaults
    }
    indent = #0
  }
}


%{
convert-ly (GNU LilyPond) 2.23.6  convert-ly: Processing `'...
Applying conversion: 2.19.16, 2.19.22, 2.19.24, 2.19.28, 2.19.29,
2.19.32, 2.19.39, 2.19.40, 2.19.46, 2.19.49, 2.20.0, 2.21.0, 2.21.2,
2.23.1, 2.23.2, 2.23.3, 2.23.4, 2.23.5, 2.23.6
%}
