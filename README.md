# Georgian music notation

The traditional vocal and instrumental music of Georgia (*Sakartvelo*)
employs a tuning system or systems (scales, pitch sets) 
that &mdash; from a listener's perspective &mdash; are emphatically different from Western ideas of scale and tuning.
Various theories attempt to model this difference formally; see the __Georgian tuning__ section below.

Knowledge of Georgian music has been transmitted orally for
centuries and for the most part has not been written down
until recently, and then only through awkward and misleading
mapping to Western musical notation that treats the ancient
system essentially as a detuning of a Western scale.

Stuart Gelzer has been working on an approach to notating Georgian 
music that is free of such bias but close enough to 
Western notation to lower the barrier to entry for those 
familiar with the latter who wish to perform and study the former, 
yet still suitable for archival and musicological purposes.

This repository contains Lilypond templates and examples supporting
this work in progress. At the moment there is a steep barrier to entry,
requiring the user (i.e., the notater) to install the open source
[Lilypond](https://lilypond.org) package and the files provided by this repository. Some of the
barrier can be lowered by the use of [Frescobaldi](https://www.frescobaldi.org/) to add
a quasi-WYSIWYG aspect to the process, but one still has to know a fair amount about
Lilypond to get anywhere.

Ideally the code in this repository could wrapped by a service that either allows
true WYSIWYG editing of Georgian notation (a very hard proposition) or, failing that,
lets the notater work in a very simple subset of Lilypond markup, displaying frequent
updates of the resulting output notation.

To do:
- Explain use of term "panduri".
- Pointers to literature? (A few below, but need more.)
- Brief description of how to use post-fix templates (pointer to Lilypond satb.ly example).

## Georgian tuning ##

*This is adapted from an email from Stuart Gelzer on 2021-Sep-5.*

Here's an overview of where I think this whole Georgian tuning business now stands.

- It seems like a lot of people, inside and outside Georgia, have gradually converged on a cluster of scale models that disagree on cent values, and degree of strict neutrality vs chromatic coloring, and breadth of regional/stylistic applicability... but that mostly agree on narrow seconds, neutral-leaning thirds, wide fourths, neutral-leaning sixths and sevenths. (I leave out wide octaves and cycling at the fifth &mdash; though to me they seem logically inseparable from the model &mdash; because so far they are not part of the consensus.)
- Both [my 11:9 scale](https://en.xen.wiki/w/11/9) (scale with step equal to half of the ["undecimal" neutral third](https://en.wikipedia.org/wiki/Neutral_third)), and [the 7edo scale](https://en.xen.wiki/w/7edo) (equal division of octave into 7 steps) advocated by the most active and theorizing tuning mavens in Georgia (the Anchiskhati Choir), share a couple of "subset" features that are not part of the broader consensus: an inflexible single step size, and its corollary, a narrow fifth. 7edo (with a 171-cent step) gets you a perfect octave, of course; 11:9 (with a 174-cent step) gets you a wide octave but a slightly better fifth. I don't know anyone who can prove they are singing one rather than the other.
- Georgian music is folk music, and it's overwhelmingly vocal, and all but one of its handful of string instruments are unfretted. So historically there's been neither the pressure from professional fretted instrument makers (Renaissance guitar, lute, etc) nor the pressure from late-medieval pipe organ builders for exact, mathematical, buildable interval relationships that produced European scale theories.
- When you add to that more recent data, [Bob Hanshaw's](https://www.lopezhanshaw.com/) (unpublished) hard evidence that (no matter what they think and say they're doing) neither contemporary avant-garde-tuning performers nor non-tempered traditional world music performers are able to reproduce intervals reliably any closer than, say 20-30 cents (and often much worse &mdash; 100 cents or more!)... and that a fuzzy zone of plus or minus 20-30 cents or even more at every step is easily broad enough to include all of the competing Georgian tuning models...
- ... Then we're left having to concede that further scale accuracy is impossible: we're stuck at the familiar boundary between what is and what can be known. There is no flour-sifter mesh fine enough to let only the right tuning through while blocking all others.

So... More and more I lean away from campaigning for 11:9 as the one right way, and lean toward the tool which is ideally suited for almost all of the tuning models within the broader consensus &mdash; namely the Panduri clef score convention defined by this repository. The beauty of the idea is in the "instructions": *No fixed pitch reference. All steps ≈ 7/8 whole step.* That allows almost anyone to imagine their preferred scale to be modeled, and it allows for the vagaries of real performance. (And it's silent on the values of fifths and octaves.) But it eliminates all of the pesky accidentals that are not only irrelevant but actively impede real understanding of what's going on. 
