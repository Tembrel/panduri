\version "2.23.6"
\language "english"

%unbarred = ##t
%middleCPosition = #6 % 1st leger line above staff

%\include "panduri-common.ily"

\header {
  tagline = ##f
}

music = \relative c { d1 e1 }

\score {
  <<
    \new Staff {
      \clef bass
      \music
    }
  >>

  \layout {
    \context {
      \Score
      measureBarType = ""
    }

    \context {
      \Staff
      \omit Staff.TimeSignature
      \omit Score.BarNumber
    }
    indent = #0
  }
}
