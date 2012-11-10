Space Generation
================

This is a quick example of procedural space generation using perlin noise,
written in ruby with the gosu and chingu libraries.

There's not much to it - WSAD to fly around. When you get near to the
boundaries of generated space, the game with generate more. The generation
code is synchronous and as such will pause the game while it works.

The random data is cached to data.json - json isn't a format you'd use for
this in a serious setting, but it's easy to read and tweak so it works for me
here.
