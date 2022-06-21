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

mainTitle = "Vakhtanguri"


\header {

  title = \markup \smallCaps \mainTitle

  subtitle = "ვახტანგური"

%
% poet prints flush left.
%

%  poet    = \markup \tiny " " 		

%
% composer prints flush right. Or use this line blank as a kluge for spacing.
%

  composer = \markup \tiny "Samegrelo" % Or use this line as a kluge for spacing.

%
% piece prints flush left. Use this if NOT printing a gamut.
%

%  piece   = \markup \teeny \italic "No fixed pitch reference. All steps ≈ 7/8 whole step." 

%
% opus prints flush right.
%

% opus    = \markup \teeny " "
  
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
%    \simple #(lilypond-version)	% Comment out to skip citing the software version.
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
  system-system-spacing.basic-distance	= #12
  markup-system-spacing.basic-distance	= #3
  score-markup-spacing.basic-distance	= #6
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

  \halign #+0.9 { 	% "halign" positions the gloss relative to the first note.
   \teeny \smallCaps "Gamut:"
   \teeny \italic "No fixed pitch reference. All steps ≈ 7/8 whole step."
    }
    
  }

gamutMusic = \relative e {
  
  d1^\gamutGloss e f g a b c d e f	% The gamutGloss is tied to the first note.
  
  }

gamutWords = \lyricmode {

% Different options for the gamut "lyrics" line.
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
  
% \set Timing.defaultBarType = ""

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
  
  b2. a8 g | a2. r4 | b2 c | d e~ e1~ e2 r |
  
  f2 e4 d | e2 d4 c | \break
  
  e8 e d c c4 c8( b) | c2 r | e8 e d c c4 c8( b) | c4 d e2 | 
  
  d4 c d8( c) b4 | c4.d8 c2 | b1 \breathe | 
  
  e | d2 d4 r | d4 d c8 d e c | d2.r4 | \break
  
  e4 e e d | e8( d) c4 d r | e e f e | e8 f e d e2 | d1 \bar "|."
    
  }

middleMusic = \relative a { \commonMusic
  
  r1 r r r | 

  b2 c | d e | d c4 b | c2 b4 a | 

  c8 c b a a4 a8( g) | a2 r | a8 a b b a4 g | a b c2 |
  
  b4 b b b | a8 b c b a2 | b1 \breathe | 
  
  d | c2 b4 r | b b a8 b c a | b2. r4 |
  
  d4 c b d | d c b d | d c b8 c d e | d d e d c2 | d1 
  
  }

bassMusic = \relative a { \commonMusic

  r1 r r r | e2 f | g a | b a4 g | f4( e) d d |
  
  e8 e e e e4 e | f2 r2 | e8 e e e e4 e | f2 f8 e d4 |
  
  e4 f g8( f) e4 | f g8. g16 g4( a) | b1 \breathe |
  
  d, | d2 e4 r | f f f8 f f f | g2. r4 
  
  a f g g | a8( g) f4 g r | a8( g) f4 g g | a8 a b b b4( c) | c( d2.)
  
  }


%
% Lyrics for each part
%

topLyrics = \lyricmode {
  
  wo o o o wo o o o de li o de li o 
  
  di da u do rai ni na di da u do rai ni a di lo 
  
  wo re ri a ra ni na he 
  
  woi di la di lai a di le wo da 
  
  de li swo de li av da wo de li a na ni ne i da he
 
  }

middleLyrics = \lyricmode {
  
  rai ni nav da de li o de li o 
  
  di da u do rai ni na di da u do rai ni a di lo 
  
  wo re ri a ra ni ne i da he 
  
  woi di la di lai a di le wo da 
  
  de li swo de li av da hoi wo de a ba de lo na ni ne i da he
 
  }

bassLyrics = \lyricmode {
  
  rai ni nav da de li o de li o 
  
  di da u do rai ni na di da u do rai ni na a di lo 
  
  wo re ri a wa ha i da he 
  
  woi di la di lai a di le wo da 
  
  de li swo de li av da wo de li a na ni ne i da he

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
% The following tweaks the lyric size to match the staff/note size. Zero is default.
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
