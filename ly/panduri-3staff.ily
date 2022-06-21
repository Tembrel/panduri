\version "2.23.4"
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


%{
convert-ly (GNU LilyPond) 2.23.4  convert-ly: Processing `'...
Applying conversion: 2.19.16, 2.19.22, 2.19.24, 2.19.28, 2.19.29,
2.19.32, 2.19.39, 2.19.40, 2.19.46, 2.19.49, 2.20.0, 2.21.0, 2.21.2,
2.23.1, 2.23.2, 2.23.3, 2.23.4
%}
