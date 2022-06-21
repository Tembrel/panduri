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

mainTitle = "Motsikuli Kristesagan"


\header {

  title = \markup \smallCaps \mainTitle

  subtitle = "მოციქული ქრისტესაგან"

%
% poet prints flush left.
%

%  poet    = \markup \tiny " " 		

%
% composer prints flush right. Or use this line blank as a kluge for spacing.
%

  composer = \markup \teeny "St. Nino’s Kontakion, Tone IV (West Georgia)"

%
% piece prints flush left. Use this if NOT printing a gamut.
%

%  piece   = \markup \teeny \italic "No fixed pitch reference. All steps ≈ 7/8 whole step." 

%
% opus prints flush right. But BEWARE -- opus tends to print again with the main score!
%

%  opus    = \markup \teeny " "
  
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
  system-system-spacing.basic-distance	= #13
  markup-system-spacing.basic-distance	= #3
  score-markup-spacing.basic-distance	= #9
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
    
    \clef tenor % Or treble or bass or whatever...
    
%
% The device for manually centering the score on the staff.
% The location of middle C has to be shifted AFTER the clef is emitted. Not sure why.
%

    \set Voice.middleCPosition = #(+ 6) % Shift the staff for this song.
    
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
  \halign #+0.9 { 	% "halign" positions the gloss relative to the first note.
    \teeny \smallCaps "Gamut:"
    \teeny \italic "No fixed pitch reference. All steps ≈ 7/8 whole step."
      }
  }
       
gamutMusic = \relative e, {
  
  d1^\gamutGloss e f g a b c d e f g a b c d	% The gloss is tied to the first note.
  
  }

gamutWords = \lyricmode {

% Different options for the gamut "lyrics" line.
%
% E♭ñ F↑ G A↓ B♭ñ C↑ D E↓ Fñ G↑ A B↓ Cñ D↑ E 	% Archive of inflection characters: ♭ ↓ ñ ↑ ♯
%
% GAN, DON, AN BAN GAN DON An Ban Gan Don an ban gan don an'

  "[3" " " " " " " "[2" "[1" " " "3]" " " " " " " "2]" " " " " "1]" % This is for each voice ambitus.

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
    
%
% The following sizes the gamut "lyrics" (if any). Zero is the default size.
%
       
     \context {
      \Lyrics
       \override LyricText #'font-size = #-3
       }
    }
  } % This bracket ends the gamut score. On to the piece itself!


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
  
  a2 b4( c) a8( g f4) g2 
  
  \bar "||"

  c2 c d c( b4) g a( b) c( a) b2( g8 f e4) e( f) g2 

  \bar "||" \break
  
  b2.b4 b b b( a) g( e f g) a2 a4( b a g) a b c2( b8 a g4) a8( g f4) g2
  
  \bar "||" \break
  
  c2. c4 c c c c c c a c c c d 
  
  \bar "" \break
  
  c2( b8 a g4) a4( b) c( a) b2( g8 f e4) e( f) g2 
  
  \bar "||"
  
  g2. g4 a g( f) g r 

  \bar "" \break
  
  b( a) b2( g8 f e4) e( f) g2 a4( b) c( d) c( b a b) \breathe

  \bar "||"
  
  c2. c4 c c c c d 
  
  \bar "" \break
  
  c2( b8 a g4) a( b) c( a) b2( g8 f) e4 e f g2 

  \bar "||" 
  
  b4 b a g e f( g) 
  
  \bar "" \break
  
  a2 a4( b a g) a( b) c2( b8 a g4) a8( g f4) g2

  \bar "||"
  
  b4 b b b b b2( a4 g) 
  
  \bar "" \break
  
  a2 a b( a8 g f4) g2 e f8( e d b c4 d) b2( c4 e) d1

  \bar "|."

  }

middleMusic = \relative d { \commonMusic
  
  d2 e4( f) d2 c 

  g'2 g g f( g4) g a( g) f( d) e2.( f4) d2 c 

  e2.e4 e e e( d) c( a b c) d2 d4( e f g) a g f2( e8 d c4) d2 c
  
  g'2. g4 g g g g g g e g g g g f2( g) a4( g) f( d) e2.( f4) d2 c 
  
  f2. f4 f e( d) c r 

  e2 e2.( f4) d2 c d4( e) f( g) f( e d e) \breathe

  f2. g4 g g g g g f2( g) a4( g) f( d) e2. f4 d d c2 

  e4 e d c a b( c) d2 d4( e f g) a( g) f2( e8 d c4) d2 c

  e4 e e e e e( f g2) g g8( a g f) e2( f) f f8( g f e) d2.(  c4) d4( e c2) d1

  }

bassMusic = \relative g, { \commonMusic

  g2 a a4( b) c2 
  
  c2 c c b( c4) c4 d( c) b( g) a1 a4( b) c2  

  a2. a4 a a a( g) f( d e f) g2 g4( a b c) d c b( g2 a4) a( b) c2

  c2. c4 c c c c c c c c c c c b2( c) d4( c) b( g) a1 a4( b) c2 
  
  c2. c4 d c( b) c r

  a2 a2.( b4) a( b) c2 d4( c) b( c) b( a g a) \breathe

  b2. c4 c c c c c b2( c) d4( c) b( g) a2. a4 a b c2

  a4 a g f d e( f) g2 g4( a b c) d4( c) b( g2 a4) a( b) c2

  a4 a a a a a( b c2) d d8( c b g) a2( b) c a4( f) e( f g a) a( b2 c4) d1
  
  }


%
% Lyrics for each part
%

topLyrics = \lyricmode {
  
  mo -- tsi -- ku -- li kri -- sTe -- sa -- ga -- n^ ga -- mo -- rche -- u -- li,
  ka -- da -- gi si -- Tqvi -- sa ghvti -- sa, ga -- n^ -- sTSa -- vlu -- li,
  ma -- kha -- ro -- be -- li tskhov -- re -- bi -- sa, 
  TSi -- na -- mdzghva -- ri ka -- rtvel -- ta e -- ri -- sa
  
  gza -- ta si -- ma -- rtli -- sa -- ta, de -- di -- sa ghvti -- sa
  sa -- Ku -- ta -- ri mo -- TSa -- pe ni -- no she -- va -- m^ -- Ko -- t^ dghes
  qo -- ve -- l^ -- ta -- i -- a dzno -- bi -- ta sa -- ghvto -- ta.
  me -- o -- khi mkhu -- rva -- le, mtsve -- li da -- u -- dzi -- ne -- be -- li.
  
  }

middleLyrics = \lyricmode {
  
  mo -- tsi -- ku -- li kri -- sTe -- sa -- ga -- n^ ga -- mo -- rche -- u -- li,
  ka -- da -- gi si -- Tqvi -- sa ghvti -- sa, ga -- n^ -- sTSa -- vlu -- li,
  ma -- kha -- ro -- be -- li tskhov -- re -- bi -- sa, 
  TSi -- na -- mdzghva -- ri ka -- rtvel -- ta e -- ri -- sa
  
  gza -- ta si -- ma -- rtli -- sa -- ta, de -- di -- sa ghvti -- sa
  sa -- Ku -- ta -- ri mo -- TSa -- pe ni -- no she -- va -- m^ -- Ko -- t^ dghes
  qo -- ve -- l^ -- ta -- i -- a dzno -- bi -- ta sa -- ghvto -- ta.
  me -- o -- khi mkhu -- rva -- le, mtsve -- li da -- u -- dzi -- ne -- be -- li.

  }

bassLyrics = \lyricmode {
  
  mo -- tsi -- ku -- li kri -- sTe -- sa -- ga -- n^ ga -- mo -- rche -- u -- li,
  ka -- da -- gi si -- Tqvi -- sa ghvti -- sa, ga -- n^ -- sTSa -- vlu -- li,
  ma -- kha -- ro -- be -- li tskhov -- re -- bi -- sa, 
  TSi -- na -- mdzghva -- ri ka -- rtvel -- ta e -- ri -- sa
  
  gza -- ta si -- ma -- rtli -- sa -- ta, de -- di -- sa ghvti -- sa
  sa -- Ku -- ta -- ri mo -- TSa -- pe ni -- no she -- va -- m^ -- Ko -- t^ dghes
  qo -- ve -- l^ -- ta -- i -- a dzno -- bi -- ta sa -- ghvto -- ta.
  me -- o -- khi mkhu -- rva -- le, mtsve -- li da -- u -- dzi -- ne -- be -- li.

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
% The following tweaks the lyric size. Zero is the default size.
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

% Any text or boxes below the score would go here as \markup blocks.


%{
convert-ly (GNU LilyPond) 2.23.4  convert-ly: Processing `'...
Applying conversion: 2.19.16, 2.19.22, 2.19.24, 2.19.28, 2.19.29,
2.19.32, 2.19.39, 2.19.40, 2.19.46, 2.19.49, 2.20.0, 2.21.0, 2.21.2,
2.23.1, 2.23.2, 2.23.3, 2.23.4
%}
