\version "2.19.15"
%
% Template to be included after defining these variables:
% - header variables title and (optionally) engraved
% - boolean variables unbarred, showGamut
% - gamutMusic, gamutText, middleCPosition
% - topMusic, middleMusic, bottomMusic
% - topLyrics, middleLyrics, bottomLyrics
%

% Common settings for all Panduri templates.
\include "panduri-common.ly"


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


pieceMarkup = \markup { 
  \fromproperty #'header:title 
}


\score {
  <<
    \new Staff \with { \commonSettings \topSettings }
      \new Voice = "top" { \commonMusic \topMusic }
    \new Lyrics \lyricsto "top" \topLyrics
     
    \new Staff \with { \commonSettings \middleSettings }
      \new Voice = "middle" { \commonMusic \middleMusic }
    \new Lyrics \lyricsto "middle" \middleLyrics
    
    \new Staff \with { \commonSettings \bassSettings }
      \new Voice = "bass" { \commonMusic \bassMusic }
    \new Lyrics \lyricsto "bass" \bassLyrics
  >>
  
  \header {
    % Redisplay title after gamut:
    piece = \markup \optMarkup \showGamut \pieceMarkup
  }
  
  \layout {
    indent = #0
  }

  \midi {
    \tempo 4 = 90
  }  
}
