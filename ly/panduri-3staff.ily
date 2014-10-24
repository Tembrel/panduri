\version "2.19.15"
%
% Template to be included after defining these variables:
% - header variables title and (optionally) engraved
% - variables unbarred and middleCPosition
% - topMusic, middleMusic, bottomMusic
% - topLyrics, middleLyrics, bottomLyrics
%


%
% Include common Panduri template settings, 
% in the same directory as this template.
%

#(ly:set-option 'relative-includes #t)

\include "panduri-common.ily"


%
% Settings for the main score
%

topSettings = \with {
  midiInstrument = "flute"
}

middleSettings = \with {
  midiInstrument = "clarinet"
}

bassSettings = \with {
  midiInstrument = "oboe"
}



\score {
  <<
    \new Staff \with \topSettings
      \new Voice = "top" \topMusic
    \new Lyrics \lyricsto "top" \topLyrics
     
    \new Staff \with \middleSettings
      \new Voice = "middle" \middleMusic
    \new Lyrics \lyricsto "middle" \middleLyrics
    
    \new Staff \with \bassSettings
      \new Voice = "bass" \bassMusic
    \new Lyrics \lyricsto "bass" \bassLyrics
  >>
  
  
  \layout {
    indent = #0
  }
}
