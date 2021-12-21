%
% A template for a three-staff score using Panduri clef, 
% preceded by an optional Panduri clef gamut, 
% WITHOUT use of a separate common file.
%

\version "2.23.4"

\language "english" 


%
% Header values for the piece, including a main title
% defined for later re-use as the piece name in the score header.
%

mainTitle = "Ga / UNCORRECTED TEXT"


\header {

  title = \markup \smallCaps \mainTitle

  subtitle = "გა"

%
% poet prints flush left.
%

%  poet    = \markup \tiny " " 		

%
% composer prints flush right. Or use this line blank as a kluge for spacing.
%

  composer = \markup \tiny "Svaneti"

%
% piece prints flush left. Use this if NOT printing a gamut.
%

%  piece   = \markup \teeny \italic "No fixed pitch reference. All steps ≈ 7/8 whole step." 

%
% opus prints flush right.
%

  opus     = \markup \teeny "Ensemble Shgarida (Dmanisi) 2010"
  
  }


%
% Common header values for Panduri clef scores.
%

\header {
  tagline = \markup \teeny \italic {
    Engraved by Stuart Gelzer		% Insert the actual author's name if another.
    \simple #(strftime 
              "%Y-%m-%d" 
              (localtime (current-time)))
    with LilyPond 
%    \simple #(lilypond-version)	% Comment out to skip citing the version.
    }
  }	


%
% Common paper values for Panduri clef scores. Possibly redundant to specify. [TWP]
%

\paper {

% "letter" is default for \language english #(set-paper-size "letter")
  
  top-margin                            = .75 \in
  bottom-margin 			= .75 \in
  line-width 				=   7 \in
  system-system-spacing.basic-distance	= #15
  markup-system-spacing.basic-distance	= #6
  score-markup-spacing.basic-distance	= #12
  
  }


%
% Building the Panduri clef sign itself. 
% It's the Unicode x10E4 ("Georgian letter phar") that matters here; 
% the "Georgia" font in use is for fun. 
% The sizing and Y-offset should scale with the staff size, 
% but we haven't done any serious testing of this.
%

clefPanduri = {
    \override Staff.Clef.stencil   = #ly:text-interface::print
    \override Staff.Clef.text      = \markup \char ##x10E4
    \override Staff.Clef.font-name = #"Georgia"
    \override Staff.Clef.font-size = #7 
    \override Staff.Clef.Y-offset  = #-0.8
    
    \clef treble % Or treble or bass or whatever...
    
%
% The device for manually centering the score on the staff.
% The location of middle C has to be shifted AFTER the clef is emitted. Not sure why.
%

    \set Voice.middleCPosition = #(+ 1) % Shift the staff for this song.
    
  }


%
% Basic settings for all Panduri clef staff contexts.
%

panduriSettings = \with {
  
% Tweak this as needed for space and layout. Fix lyrics size to match down in "layout."

  \magnifyStaff #3/4

% This beams eighth notes in pairs. Comment out for sets of four.
% For flagged stems, use \autoBeamOff and \autoBeamOn 
% around the desired notes in the score itself.

  beamExceptions = #'()

%
% Hiding the time signature reserves empty space, which looks better. 
%

  \hide Staff.TimeSignature

%
% Use the clef, Luke.
%

  \clefPanduri

  }

%
% This defines the gamut score. 
% 

gamutSettings = \with {

  \panduriSettings
  
% Slightly smaller sized staff for the gamut. Comment out to override.

  \magnifyStaff #5/8
  
  \omit Staff.BarLine

  }

gamutGloss = \markup { 
  \halign #+0.9 {	% "halign" positions the gloss relative to the first note.
    \teeny \smallCaps "Gamut:"
    \teeny \italic "No fixed pitch reference. All steps ≈ 7/8 whole step."
      }
  }
       
gamutMusic = \relative e {
  
  e1^\gamutGloss f g a b c d e		% The gloss is tied to the first note.
  
  }

gamutWords = \lyricmode {

% Different options for the gamut "lyrics" line, none currently in use.
%
% E♭ñ F↑ G A↓ B♭ñ C↑ D E↓ Fñ G↑ A B↓ Cñ D↑ E 	% Archive of inflection characters: ♭ ↓ ñ ↑ ♯
%
% GAN, DON, AN BAN GAN DON An Ban Gan Don an ban gan don an'
%
% "⌊3" " " " " " " "⌊2" "⌊1" " " "3⌉" " " " " " " "2⌉" " " " " "1⌉" % This is for each voice ambitus.
%

  }

%
% Calling the gamut score. You should not need to change anthing here.
%

gamutStaff = \score {
  <<
    \new Staff \with \gamutSettings
     \new Voice = "gamut" \gamutMusic
     \new Lyrics \lyricsto "gamut" \gamutWords
  >>

  \layout {
    indent = #0
    ragged-right = ##f
    }
    
  } % This bracket ends the whole gamut section. On to the piece itself!


%
% Main score
%


commonSettings = \with {

  \panduriSettings
  
%
% Other settings common to the staff contexts of this piece go here.
%

  }


commonMusic = {

  \time 4/4

%
% Use the following if you want irregular manual bar lines, like in chant.
% Comment out for normal bar lines that follow the time signature above.
%
  
  \set Timing.defaultBarType = ""

% (Bar numbering is controlled down in "layout.")

%
% Other initial music expressions common to the voice contexts of this piece would go here.
%

  }


%
% Individual settings for each part
%

topSettings = \with {
  \commonSettings
  midiInstrument = "flute"
  }

middleSettings = \with {
  \commonSettings
  midiInstrument = "clarinet"
  }

bassSettings = \with {
  \commonSettings	
  midiInstrument = "oboe"
  }


%
% Music for each part
%

topMusic = \relative a { \commonMusic
  
  s4 r\breve \breathe c4 d2. d2 \breathe c2 e e4( d) c1 b2( s4) 
  
  r1 d2. d d1 c \breathe e2 d1( d8) d c b( b1) \breathe a2( s4) 
  
  r1 d4 d2. d2 \breathe d4 d2. d2 \breathe c2 e e4( d) c1 b2( s4) 
  
  
  r1 d \breathe e2 d1( d8) e c b( b1) \breathe a2 d d( s4) 
  
  r1. \breathe e2. d \breathe e4 e 2. d \breathe d2.( c4) c1 \breathe 
  
  d4 d2. d4 \breathe d4 d2. d4 \breathe 
  
  e2 e d e1( e8) c c b( b1) \breathe a2 c4 a2 g2( s4) 
  
  r1. \breathe e'2. d \breathe e4 e2. d2. \breathe d2.( c4) c1 \breathe 
  
  d2. e4 d8 c d4. e8 c b( b1) \breathe a2 c4 a2 g1 
  
  }

middleMusic = \relative a { \commonMusic
  
  d2 d8 a4. d8 d c b a g( g2) \breathe
  
  a4 a2. a2 \breathe a2 c c4( b) a1 g2 s4
  
  \bar "" \break
    
  d'4 c2. b2. c b1 a \breathe 
  
  c2 b1( b8) b a g( g1) \breathe a2 s4
  
  \bar "" \break
    
  c4 b2. a4 a2. a2 \breathe 
  
  a4 a2. a2 \breathe a2 c c4( b) a1 g2 s4
  
  \bar "" \break
    
  d'4 c2. c4( g2.) \breathe c2 b1( b8) c a g( g1) \breathe a2 a a s4
  
  \bar "" \break
    
  c4. d8 c a( a2.) \breathe c2. b \breathe c4 c2. b \breathe 
  
  b2.( a4) a1 \breathe 
  
  \bar "" \break
    
  b4 c2. b4 \breathe 
  
  b4 c2. b4 \breathe 
  
  c2 c c b1( b8) b a g( g1) \breathe a2 f2. g2 s4
  
  \bar "" \break
    
  c4. d8 c a( a2.) \breathe c2. b \breathe c4 
  
  c2. b \breathe b2.( a4) a1 \breathe
  
  \bar "" \break
    
  b2. c4 b8 a b4. c8 a g( g1) \breathe a2 f2. g1 \bar "|."

 }

bassMusic = \relative a { \commonMusic

  s4 r\breve \breathe a4 a2. a2 \breathe f2 f f f1 g2( s4) 
  
  r1 g2. g e1 f \breathe g2 g1( g8) g f g( g1) \breathe a2( s4) 
  
  r1 a4 a2. a2 \breathe a4 a2. a2 \breathe f2 f f f1 g2( s4) 
  
  r1 g \breathe g2 g1( g8) g f g( g1) \breathe a2 a a( s4) 
  
  r1. \breathe a2. g \breathe a4 a2. g \breathe f\breve \breathe 
  
  g4 g2. g4 \breathe g4 g2. g4 \breathe 
  
  g2 g g e1( e8) f f g( g1) \breathe a2 f2. g2( s4) 
  
  r1. \breathe a2. g \breathe a4 a2. g \breathe f\breve \breathe 
  
  g2. g4 g8 f g4. g8 f g( g1) \breathe a2 f2. g1 
  
  }


%
% Lyrics for each part
%

topLyrics = \lyricmode {
  
  ri ho yi sa u tsi a wo
  ga yi ho a shi ho yi e he wo
  ri ho yi ri ho yi sa u tsi a wo
  ga yi ho yi e he he yi wo
  ga ha yi ha yi wo da 
  su ha ya yi ha ya 
  ga u tsi ho yi e he wo wo ho ha
  ga ha yi ha yi wo da 
  wo yi wo yi ha yi e he wo wo ho ha
  
  }

middleLyrics = \lyricmode {
  
  wo do a yi a wo di wo yi
  ri ho yi sa u tsi a wo
  u a ga yi ho a shi ho yi e he wo
  e he ri ho yi ri ho yi sa u tsi a wo
  u a ga yi ho yi e he he yi wo
  wo yi e ha ga ha yi ha yi 
  wo da su ha ya yi ha ya 
  ga u tsi ho yi e he wo ha ha
  wo yi e ha ga ha yi ha yi wo da 
  wo yi wo yi ha yi e he wo ha ha

  }

bassLyrics = \lyricmode {
  
  ri ho yi sa u tsi a wo
  ga yi ho a shi ho yi e he wo
  ri ho yi ri ho yi sa u tsi a wo
  ga yi ho yi e he he yi wo
  ga ha yi ha yi wo 
  su ha ya yi ha ya 
  ga u tsi ho yi e he wo ha ha
  ga ha yi ha yi wo 
  wo yi wo yi ha yi e he wo ha ha

  }

%
% Calling the gamut (optional). If you comment this out, you should also 
% comment out the "piece" definition below, which restates the song title.
%

  \gamutStaff

%
% Calling the main score. You should not need to change anthing here.
%

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

%
% The following repeats the title, but smaller and left-aligned.
% You only want this if the gamut staff is included.
%

  \header {
    piece = \markup \smallCaps \mainTitle
    opus = " "	% This kluge overrides the main header opus definition .
  }


  \layout {

   indent = #0
%
% Comment out the following if you DO want bar numbers.
%
    \context {
     \Score
      \omit BarNumber
       }

%
% The following tweaks the lyric size. Zero is default size.
%
       
     \context {
      \Lyrics
       \override LyricText #'font-size = #-1
       }

  } % This is the end bracket of the layout section.

%
% The following just controls the tempo of MIDI playback. It engraves nothing.
%

  \midi {
    \tempo 4 = 90
  }  

} % This is the end bracket of the main score. There is no end-of-file marker.

\markup
    {
    \fill-line \lower #5 {
    \line \override #'(line-width . 60) { \rounded-box 
    \small \wordwrap-string "Here would go lyrics text, possibly in Georgian, like this: სტიუარტჲ"
    }
    \line \override #'(line-width . 32) { \rounded-box
    \teeny \wordwrap-string "Relative note durations are approximate. No subdividing pulse is implied."
    }
  }
}


%{
convert-ly (GNU LilyPond) 2.23.4  convert-ly: Processing `'...
Applying conversion: 2.19.16, 2.19.22, 2.19.24, 2.19.28, 2.19.29,
2.19.32, 2.19.39, 2.19.40, 2.19.46, 2.19.49, 2.20.0, 2.21.0, 2.21.2,
2.23.1, 2.23.2, 2.23.3, 2.23.4
%}
