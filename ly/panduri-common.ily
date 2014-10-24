%
% panduri-common.ily
%
% Defines Panduri clef and related settings for scores
% using that clef.
%
% If \unbarred is true, omits time signature, bar 
% lines, and bar numbers.
%
% Requires unbarred and middleCPosition to be defined. 
%
% If header property "engraved" is defined, it will
% be used in the tagline.
%
\version "2.19.15"


ifElseString = 
#(define-scheme-function 
  (parser location include text alt-text)
  (boolean? string? string?)
  (if include
    text
    alt-text
  )
)

optMusic = 
#(define-music-function 
  (parser location include music)
  (boolean? ly:music?)
  (if include
    music
    #{ #}
  )
)


ScoreDefaults = \with {
  defaultBarType = \ifElseString \unbarred "" "|"
}
  
StaffDefaults = \with {

  \optMusic \unbarred { 
    % Unbarred music shows no time signature 
    % or bar numbers.
    \omit Staff.TimeSignature 
    \omit Score.BarNumber
  }
  % Note: For some reason bar numbers don't show
  % even when \unbarred is false.

  % Makes it OK to use accidentals in music; they will
  % not be displayed. But you don't *have* to use them.
  
  \remove Accidental_engraver
  
  % Add an ambitus at the beginning of each staff.
  
  \consists Ambitus_engraver

  % The Panduri clef itself. It's the Unicode x10E4 ("georgian
  % letter phar") that matters here; the Georgia font in use
  % is for fun. The sizing and Y-offset should scale with the
  % staff size, but we haven't done any serious testing of this.
  
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

  % Because a "C" doesn't look nice with the Panduri clef.
  % Irrelevant but harmless in unbarred scores.
  
  \numericTimeSignature
}


\layout {
  \context {
    \Score
    \ScoreDefaults
  }
  \context {
    \Staff
    \StaffDefaults
  }
}
  

%
% Spacing under titles whether or not gamut is displayed.
%

\markup { \vspace #1.2 } 


%
% Common paper values for Panduri clef scores.
%
% Forces letter size with non-standard margins 
% that might not be achievable with all printers.
%

\paper {
  top-margin                            = .75\in
  bottom-margin 			= .75\in
  line-width 				= 7.0\in
  system-system-spacing.basic-distance 	= #15
  markup-system-spacing.basic-distance	= #5
}


%
% Common header values for Panduri clef scores.
% For now, just provides a tagline with engraver
% name, time of engraving, and Lilypond version.
%

\header {
  tagline = \markup \small \italic {
    Engraved 
    \simple #(strftime 
              "%Y-%m-%d" 
              (localtime (current-time)))
    \fromproperty #'header:engraved
    with LilyPond 
    \simple #(lilypond-version)
  }
}

