### 2023-11-27

Began this project with the goal in mind, of getting exposure to various other languages,
outside of my native language of Ruby. In order to get the most out of it, I wanted to
pursue a project, that would be fairly trivial, yet complex enough to be enjoyable. So
I asked ChatGPT to provide me with various ideas, and while many were good, I settled on
it's suggestion of creating a task report generator. I love working with data, it's very
familiar to what I do on a day-to-day basis, in my work's Rails projects. We are consistently
looking for various ways to show data in a way that provides most value to the clients using
our system. I'm always surprised by all of the various stories that data can paint, for
better or worse. And with the idea of this simple task report generator, I foresaw many
oppurtunities to practice architectural design, as thoughts of opening up the system to
different UIs and data sources danced in my head. I would really get to flex many muscles
with a project like this. So, with all that said, I very much felt like this was my prime
project prospect.

Naturally, I started with my native language of Ruby. The good thing about
Ruby, is that the language is so eloquent, that getting thoughts on screen, takes no
time, and is very easy to change as nuance about the project is learned. It really is
probably the best language for prototyping, and I felt this when I subsequentally proceeded
onward to Javascript. Although, Javascript is quite different syntactically, than Ruby, I still
felt myself using the Ruby code as a template for how I would structure the Javascript
code. It basically became a matter of translating the ideas between the two languages.
I think this is a simple approach to playing with a new language.
I've noticed subtle differences, like explicit function returns and callback requirements,
which highlight unique aspects of Javascript. While efficient, this
approach made me ponder if I may have missed oppurtunities to learn language-specific concepts
organically. Regardless, I do feel that it builds a foundational knowledge that could facilitate
a more in-depth exploration later on.

My aim is to emerge from this endeavor as a more versatile developer, gaining
insights from different languages. I believe diverse language exposure provides
perspectives that a monolingual approach might miss. As I continue, I plan to
reflect more explicitly on language-specific concepts and deepen my understanding.

### 2023-11-28
Uhhhhhhh... Javascript dates are zero-indexed on the month, but only the month?! Year
and day are represented normally, starting from 1? WTF, dude?! Huuuuuge gotcha! That is
so confusing and I absolutely, without a doubt, hate that. I hate that. I hate it so much.
Why do that? That is so confusing. Still about halfway through the project rewrite in
Javascript, so there's still time for my opinions on the language to change, but so far,
I hate the atrocities that I've seen here today. Still gonna try and dig into some
language-specific concepts. Maybe I'll find a redeeming quality for javascript, but
I am not hopeful.

### 2024-02-05
Long time, no entry. I have finally come to a stopping point in my javascript expedition,
and although, I uncovered several shortcomings, things that I missed in my first pass using
ruby, I have at least produced a program of equal behavior in javascript and now feel I
am at a reasonable place, to push up code, and possibly document some things that I missed
as issues, so that I can come back later. Which does beg the question, should I take the
time, to do those issues now, or am I gonna be impatient and move on to the next iteration
in a new language? An even jucier question, what language is next...?

### 2024-02-11
"Enough with the suspense, Houston, what language did you go with?" Well, without further
ado, lets get a drum roll for... *drumroll noises* Python! I went with python for the
third language to learn and rewrite this application in. I figured it'd be a good language to
pick up. Syntactically similar to Ruby while having a similar "feel" to javascript, it seem to
make a lot of sense. If I didn't work so closely to javascript at work, I would have probably chosen
python to be the second language, I think that would have made more sense if I was solely basing
my next language off of what was the nearest "jump", but I digress, I think my path has made sense.
It's not like I'm jumping from Ruby straight to C or Rust, although I do have high hopes that I make it
to those languages, as I think that's probably where the real insights lie, but for now python
will do. So far, it's been interesting. I'm taking a very different approach to the javascript
iteration. I'm diving into the docs a little bit more, starting with the "Getting started", really
trying to get a feel for what the language has to offer. I still think that ultimately I end
structuring the project the same way that I have in the last two iterations. I don't know just
yet, that I would come across anything that would make me rethink the way that I designed the
system, although I do expect, when I come to a strictly functional language, that may change
but I don't know, with languages that have support for OOP, I just don't know that I stray
from my original design that much. I like that the OOP concepts that I introduced, should
ultimately support extensibility, and I also liked that I implemented those concepts without
the pitfalls of inheritance and state mutation. In some ways, I kinda felt like I wrote a very
functional-esque Object-Orientated application, kinda the best of both worlds, but maybe that's
just my bias, giving me rose colored glasses, and that's ultimately why I wanted to do this in
the first place. What are the ideas that I'm missing out on? How will these other languages
shape the way that I think about engineering? I've always wanted to take a stab at creating
my own programming language, maybe this endeavor drives that pursuit. Maybe I'll be able
to identify the things that I like in a language and the things that I don't like in a
language. Kinda hard to say when you've only had experience with one language. Anyway, all
that to say that I'm excited to start this next iteration! Off the jump, I've already identified
some interesting things in python that may or may not be built into Ruby. One of those things,
is the ability to define objects as falsy or truthy via the `__bool__` method. While I don't know what
use cases, I would have for something like that, I did find it interesting and I'm sure too,
that ruby has something similar, I just haven't discovered. Also I should mention, this
isn't my first exposure to python. I did Google's "secret" foobar program, and all the code
that I wrote for those challenges was in pyton, so I've had minimal exposure, but exposure nonetheless.
None of it was as deep a dive, as I'm hoping to get this time around. That being said, things that I
know I already don't like that much, strict indentation and the lack of some sort of ending
notation, which ultimately comes back to Python's adherence to this weird indentation rule.
I very much do not enjoy it.
