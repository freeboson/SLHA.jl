```
                        ____  _     _   _    _       _ _
                       / ___|| |   | | | |  / \     (_) |
                       \___ \| |   | |_| | / _ \    | | |
                        ___) | |___|  _  |/ ___ \ _ | | |
                       |____/|_____|_| |_/_/   \_(_)/ |_|
                                                  |__/
```
[![Build Status](https://travis-ci.org/freeboson/xkpasswd.jl.svg?branch=master)](https://travis-ci.org/freeboson/xkpasswd.jl)
[![Coverage Status](https://coveralls.io/repos/freeboson/xkpasswd.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/freeboson/xkpasswd.jl?branch=master)
[![codecov.io](http://codecov.io/github/freeboson/xkpasswd.jl/coverage.svg?branch=master)](http://codecov.io/github/freeboson/xkpasswd.jl?branch=master)

This is a package written in [Julia](https://julialang.org) to parse, serialize,
and perform calculations with the Supersymmetry Les Houches Accord (SLHA) file
format, codified by [this paper](https://arxiv.org/abs/hep-ph/0311123) and
updated in [this paper](https://arxiv.org/abs/0801.0045). As the SLHA format is
pervasive in the particle physics, especially beyond the Standard Model (BSM)
physics, an agile and robust SLHA library for Julia should establish a
foundation for new tools to be developed in Julia, for high energy physics.

Installation
------------

You can get started very simply using Julia's package manager. Start Julia's CLI
and do the following:

```jlcon
julia> Pkg.add("SLHA")

julia> using SLHA
```

At this point, you have already downloaded and installed the `SLHA.jl` package
and have loaded its symbols.

Features
--------

One of the unique characteristics of this library is that different SLHA blocks,
identified by name have their own type. Using Julia's parametric types which can
be identified by a `Symbol`, it is easy to create a large number of subtypes.
The idea is that this might be useful if one wishes to dispatch on a block,
instead of using an associative map. (I'm not sure if this is a useful feature
yet :) .)

There is a large degree of arbitrariness in the types of block that can be
contained by `SLHA.jl`. You can have ordinary arrays of arbitrary dimensions,
which can be easily traversed thanks to Julia's
[`@generated`](http://docs.julialang.org/en/latest/manual/metaprogramming)
metaprogramming facilities. And, the multiple/external dispatch of Julia allows
you to easily extend the format to SLHA blocks as you wish. It is my hope that
the rich programming environment will lead to innovative BSM tool development
with clever meta-programming and staged programming techniques.


