%
% panduri-common.ly - common settings for scores that 
%                     use staff contexts with the 
%                     Panduri clef
%
% Defines Panduri clef and related settings for scores
% using that clef.
%
% Also defines \gamutStaff, which produces a line with 
% labeled notes within the gamut of the Panduri clef, 
% including tuning "hints".
%
% If the variable showGamut is true, produces the
% gamut staff. If variable unbarred is true, omits
% time signature, bar lines, and bar numbers.
%
% Requires unbarred, showGamut, gamutMusic, gamutText, 
% and middleCPosition to be defined. 
%
% If header property "engraved" is defined, it will
% be used in the tagline.
%
\version "2.19.15"


%
% Used to align gamutGloss below, but generally useful.
% Takes two arguments, the alignment amount (#LEFT = -1,
% #RIGHT = 1) and the markup text for the mark.
%

markAligned = 
#(define-music-function
  (parser location amount text)
  (number? markup?) 
  #{
    \once \override 
      Score.RehearsalMark.self-alignment-X = #amount
    \mark #text
  #}
)


%
% Functions for optionally including things.
%

%
% optMarkup include text
%
% If include is true, produces text as markup;
% otherwise produces empty markup.
%

#(define-markup-command 
  (optMarkup layout props include text)
  (boolean? markup?)
  (interpret-markup layout props
    (if include
      text
      #{ \markup {} #}
    )
  )
)

optScore = 
#(define-scheme-function 
  (parser location include score)
  (boolean? ly:score?)
  (if include
    score
    #{ \score { {} } #}
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


%
% Common paper values for Panduri clef scores.
%
% Forces letter size with non-standard margins 
% that might not be achievable with all printers.
%

\paper {
  top-margin                            = .75 \in
  bottom-margin 			= .75 \in
  line-width 				= 7 \in
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


%
% The Panduri clef itself. It's the Unicode x10E4 ("georgian
% letter phar") that matters here; the Georgia font in use
% is for fun. The sizing and Y-offset should scale with the
% staff size, but we haven't done any serious testing of this.
%
% The location of middle C has to be shifted to the bottom
% line *after* the clef is emitted. Not sure why.
%

\layout {
  \context {
    \Staff
    \override Clef.stencil = #ly:text-interface::print
    \override Clef.text = \markup \char ##x10E4
    \override Clef.font-name = #"Georgia"
    \override Clef.font-size = #7
    \override Clef.Y-offset = #(* -1 (magstep -3))
  }
  \context {
    \Voice
    middleCPosition = \middleCPosition
  }
}
  

%
% Basic settings for all Panduri clef staff contexts.
%

panduriSettings = \with {
  
  % Not sure if this is needed. Might belong in
  % the common settings for individual pieces.
  beamExceptions = #'()
  
  % Makes it OK to use accidentals in music; they will
  % not be displayed. But you don't *have* to use them.
  \remove Accidental_engraver

  % Any clef will do here, since we've overridden the
  % clef stencil, text, font, and size, and set the 
  % middle C position.
  \clef tenor

  % Because a "C" doesn't look nice with the Panduri clef.
  \numericTimeSignature
}


%
% Optionally use unbarred style.
%

commonSettings = \with {
  \panduriSettings
  
  \optMusic \unbarred { 
    % Unbarred music shows no time signature 
    % or bar numbers.
    \omit Staff.TimeSignature 
    \omit Score.BarNumber
    
    % Unbarred music has invisible bars.
    \set Timing.defaultBarType = "" 
  }
}

commonMusic = {
}


%
% Define gamut score. To insert gamut staff into piece,
% add \gamutStaff at top level. 
% 

gamutSettings = \with {
  % Slightly smaller staff for gamut. 7/8 ratio is a bit
  % arbitrary, but it corresponds to the fraction of an
  % equal-tempered step covered by each step of the gamut.
  \magnifyStaff #7/8
  
  \panduriSettings
  
  \omit Staff.TimeSignature
  \omit Staff.BarLine
}


gamutStaff = \score {
  <<
    \new Staff \with \gamutSettings
      \new Voice = "gamut" { 
        \markAligned #-0.75 \markup { 
            \small \italic 
            "tuning gamut: all steps ≈ 7/8 EQ step"
        }

        % Turns quarter notes (default duration) into
        % whole notes, so no durations are needed in 
        % the definition of gamutMusic.
        \shiftDurations #-2 #0 \gamutMusic
      }
    \new Lyrics \lyricsto "gamut" \gamutText
  >>

  \layout {
    indent = #0
    ragged-right = ##f
  }
}

%
% Optionally display the gamut. Use spacing whether
% or not gamut is displayed.
%

\markup { \vspace #1.2 } 

\optScore \showGamut \gamutStaff
