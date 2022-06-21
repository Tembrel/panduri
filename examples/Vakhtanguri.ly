\version "2.23.4"

\header {
  title = \markup \smallCaps "Vakhtanguri"
  subtitle = " "
  tagline = \markup {
    Engraved by Stuart Gelzer
    \simple #(strftime "%Y-%m-%d" (localtime (current-time)))
    with LilyPond \simple #(lilypond-version)
  }
}

\paper {
  #(set-paper-size "letter")
  top-margin = .75 \in
  bottom-margin = .75 \in
  line-width = 7 \in
  system-system-spacing.basic-distance = #15
  markup-system-spacing.basic-distance = #5
}

clefPanduri = {
    \override Staff.Clef.stencil = #ly:text-interface::print
    \override Staff.Clef.text = \markup \char ##x10E4
    \override Staff.Clef.font-name = #"Georgia"
    \override Staff.Clef.font-size = #7 
    \override Staff.Clef.Y-offset = #-0.7
    \clef tenor
    \set Voice.middleCPosition = #(+ 1) % shift staff for this song
}

timeline = {
  \clefPanduri
  \numericTimeSignature
  \time 4/4
%  \hide Staff.TimeSignature
  \set Timing.beamExceptions = #'()
}

\markup { \italic "tuning gamut: all steps ≈ 7/8 EQ step"
}

gamutSettings = \with {
  \clefPanduri
  \omit Staff.BarLine
  \omit Staff.TimeSignature
  midiInstrument = "alto sax"
}

\score {

  \new Staff = "gamut" \with \gamutSettings \relative f {
      d1 e f g a b c d e f
  }
  
  \addlyrics { 
      D↑ E F♯↓ Gñ A↑ B C♯↓ Dñ E↑ F♯
  }
    
  \layout {
    indent = #0
    ragged-right = ##f
  }
}

% Vakhtanguri score

\markup { \smallCaps "Vakhtanguri" }
  
\score {

  \new Staff = "tenor" {
  
    <<
    \new Voice = "top" \relative b {
      \voiceOne
      \timeline
      \set Voice.midiInstrument = #"flute"
      
        b2. a8 g | a2. r4 | b2 c | d e~ e1~ e2 r |
        f2 e4 d | e2 d4 c | \break
        e8 e d c c4 c8( b) | c2 r | e8 e d c c4 c8( b) | c4 d e2 | 
        d4 c d8( c) b4 | c4.^\markup { ra } d8^\markup { ni } c2^\markup { na } | b1 \breathe | 
        e | d2 d4 r | d4 d c8 d e c | d2.r4 | \break
        e4 e e d | e8( d) c4 d r | e e f e | e8 f e d e2 | d1 \bar "|."
        }

     \new Lyrics \with { }
       \lyricsto "top" {
        Wo o o o wo o o o
        }
     
    \new Voice = "middle" \relative b {
      \voiceTwo
      \timeline
      \set Voice.midiInstrument = #"clarinet"
      
        r1 r r r | 
        b2 c | d e | d c4 b | c2 b4 a | 
        c8 c b a a4 a8( g) | a2 r | a8 a b b a4 g | a b c2 |
        b4 b b b | a8 b c b a2 | b1 | 
        d | c2 b4 r | b b a8 b c a | b2. r4 |
        d4 c b d | d c b d | d c b8 c d e | d d e d c2 | d1 
        }
    
    \new Lyrics \with { }
      \lyricsto "middle" {
        rai ni nav da de li o de li o 
        di da u do rai ni na di da u do rai ni a di lo 
        wo re ri a ra ni ne i da he 
        woi di la di lai a di le wo da 
        de li swo de li av da hoi wo de a ba de lo na ni ne i da he
        }
      
    \new Staff = "bass" \relative g {
      \timeline
      \set Staff.midiInstrument = #"oboe"
      
        r1 r r r | e2 f | g a | b a4 g | f4( e) d d |
        e8 e e e e4 e | f2 r2 | e8 e e e e4 e | f2_\markup { na } f8_\markup { a } e_\markup { di } d4_\markup { lo } |
        e4 f g8( f) e4 | f_\markup { ra } g8._\markup { a } g16_\markup { ni } g4(_\markup { na } a) | b1 \breathe |
        d, | d2 e4 r | f f f8 f f f | g2. r4 
        a f g g | a8( g) f4 g r | a8( g) f4 g g | a8 a b b b4( c) | c( d2.)
        }      
    >>
  }

  \layout {
    indent = #0
    }

  \midi {
  \tempo 4=90
    }  

}


%{
convert-ly (GNU LilyPond) 2.23.4  convert-ly: Processing `'...
Applying conversion: 2.19.2, 2.19.7, 2.19.11, 2.19.16, 2.19.22,
2.19.24, 2.19.28, 2.19.29, 2.19.32, 2.19.39, 2.19.40, 2.19.46,
2.19.49, 2.20.0, 2.21.0, 2.21.2, 2.23.1, 2.23.2, 2.23.3, 2.23.4
%}
