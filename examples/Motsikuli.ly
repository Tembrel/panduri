%
% Motsikuli.ly - example of using postfix template
%

\version "2.19.15"
\language "english" 


%
% Staff size for this piece. The gamut will use a
% smaller staff size. We set this here rather than
% in the template, because the ideal staff size often
% depends on the specific music and words.
%
% See http://lilypond.org/doc/v2.19/Documentation/notation/setting-the-staff-size
%

#(set-global-staff-size 18)


%
% Define the variables required by the template and
% then include the template at the end.
%


\header {
  % title is required
  title = \markup \smallCaps "Motsikuli Kristesagan"
  subtitle = "(St. Nino’s Kontakion)"
  engraved = "Tim Peierls"
}

%
% These are currently *all* required.
%

unbarred = ##t

showGamut = ##t

middleCPosition = #(+ 6) % 1st leger line above staff

gamutMusic = \relative c, {
  d  ef  f  g  a  bf  c  d  e  f  g  a  b  c  d
}

gamutText = \lyricmode {
  % inflection characters ♭ ↓ ñ ↑ ♯
  Dñ E♭↑ F G↓ Añ B♭↑ C D↓ Eñ F↑ G A↓ Bñ C↑ D  
}


topMusic = \relative c' {      
  
  a2 b4( c) a8( g f4) g2 \bar "||"

  c2 c d c( b4) g a( b) c( a) b2( g8 f e4) e( f) g2 

  \bar "||" \break
  
  b2.b4 b b b( a) g( e f g) a2 a4( b a g) a b c2( b8 a g4) a8( g f4) g2
  
  \bar "||" \break
  
  c2. c4 c c c c c c a c c c d 
  
  \bar "" \break
  
  c2( b8 a) g4 a4 b c( a) b2( g8 f e4) e( f) g2 
  
  \bar "||"
  
  g2. g4 a g( f) g r 

  \bar "" \break
  
  b( a) b2( g8 f e4) e( f) g2 a4( b) c( d) c( b a b2.) 

  \bar "||"
  
  c2. c4 c c c c d 
  
  \bar "" \break
  
  c2( b8 a g4) a( b) c( a) b2( g8 f e4) e f g2 

  \bar "||" 
  
  b2 a4 g e( f g) 
  
  \bar "" \break
  
  a2 a4( b a g) a( b) c2( b8 a g4) a8( g f4) g2

  \bar "||"
  
  b4 b b b b b2( a4 g) 
  
  \bar "" \break
  
  a2 a b( a8 g f4) g2 f8( g f e) d2( c8 e d c) d4( e8 d c4 e) d1

  \bar "|."

}

middleMusic = \relative c {
  
  d2 e4( f) d2 c 

  g'2 g g f( g4) g a( g) f( d) e2.( f4) d2 c 

  e2.e4 e e e( d) c( a b c) d2 d4( e d c) d e f2( e8 d c4) d2 c
  
  g'2. g4 g g g g g g e g g g g f2( g4) g a g f( d) e2.( f4) d2 c 
  
  f2. f4 d d2 c4 r 

  e2 e2.( f4) d2 c d4( e) f( g) f( e d e2.)

  f2. g4 g g g g g f2( g) a4( g) f( d) e2.( f4) d d c2 

  e2 d4 c a( b c) d2 d4( e f g) a( g) f2( f8 g f e) d( c d4) c2

  e4 e e e e e( f g2) g g8( a g f) e2( f) f f4( e) f8( e d4 c8 b a c) b2( c) d1

}

bassMusic = \relative c {
  
  g2 a a4( bf) c2 
  
  c2 c c b( c4) c4 d( c) b( g) a1 a4( b) c2  

  a2. a4 a a a( g) f( d e f) g2 g4( a g f) g a b( g2 a4) a( b) c2

  c2. c4 c c c c c c c c c c c b2( c4) c d c b( g) a1 a4( b) c2 
  
  c2. c4 b b2 c4 r

  a2 a2.( b4) a( b) c2 g4( a) b( c) b( a g a2.) 

  b2. c4 c c c c c b2( c) d4( c) b( g) a1 a4 b c2

  a2 g4 f d( e f) g2 g4( a b c) d2 b4( g2 a4) a( b) c2

  a4 a a a a a( b c2) d d8( c b g) a2( b) c a4( f) e( f g a) a( b2 c4) d1

}


topLyrics = \lyricmode {

  mo -- tsi -- ku -- li kris -- Te -- sa -- ga -- n^ ga -- mo -- rche -- u -- li
  ka -- da -- gi si -- Tqvi -- sa ghvti -- sa, ga -- n^ -- sTSa -- vlu -- li
  ma -- kha -- ro -- be -- li tskhov -- re -- bi -- sa, 
  Tsi -- na -- mdzghva -- ri ka -- r^ -- tve -- l^ -- ta e -- ri -- sa
  
  gza -- ta si -- ma -- rtli -- sa -- ta de -- di -- sa ghmrti -- sa
  sa -- Ku -- ta -- ri mo -- TSa -- pe ni -- no she -- va mKo -- t^ dghes
  qo -- ve -- l^ ta -- grdzno -- bi -- ta sa -- ghmrto -- ta
  me -- o -- khi mkhu -- rva -- le, mtsve -- li da -- u -- dzi -- ne -- be -- li
  
}

middleLyrics = \lyricmode {
  
  mo -- tsi -- ku -- li kris -- Te -- sa -- ga -- n^ ga -- mo -- rche -- u -- li
  ka -- da -- gi si -- Tqvi -- sa ghvti -- sa, ga -- n^ -- sTSa -- vlu -- li
  ma -- kha -- ro -- be -- li tskhov -- re -- bi -- sa, 
  Tsi -- na -- mdzghva -- ri ka -- r^ -- tve -- l^ -- ta e -- ri -- sa
  
  gza -- ta si -- ma -- rtli -- sa -- ta de -- di -- sa ghmrti -- sa
  sa -- Ku -- ta -- ri mo -- TSa -- pe ni -- no she -- va mKo -- t^ dghes
  qo -- ve -- l^ ta -- grdzno -- bi -- ta sa -- ghmrto -- ta
  me -- o -- khi mkhu -- rva -- le, mtsve -- li da -- u -- dzi -- ne -- be -- li

}

bassLyrics = \lyricmode {
  
  mo -- tsi -- ku -- li kris -- Te -- sa -- ga -- n^ ga -- mo -- rche -- u -- li
  ka -- da -- gi si -- Tqvi -- sa ghvti -- sa, ga -- n^ -- sTSa -- vlu -- li
  ma -- kha -- ro -- be -- li tskhov -- re -- bi -- sa, 
  Tsi -- na -- mdzghva -- ri ka -- r^ -- tve -- l^ -- ta e -- ri -- sa
  
  gza -- ta si -- ma -- rtli -- sa -- ta de -- di -- sa ghmrti -- sa
  sa -- Ku -- ta -- ri mo -- TSa -- pe ni -- no she -- va mKo -- t^ dghes
  qo -- ve -- l^ ta -- grdzno -- bi -- ta sa -- ghmrto -- ta
  me -- o -- khi mkhu -- rva -- le, mtsve -- li da -- u -- dzi -- ne -- be -- li

}


%
% Last thing is to include the template that produces
% the score.
%
\include "../ly/panduri-3staff.ily"
