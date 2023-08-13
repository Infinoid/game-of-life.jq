# Game of life

This is an implementation of [Conway's Game Of Life](https://en.wikipedia.org/wiki/Conway's_Game_of_Life) as a [`jq`](https://jqlang.github.io/jq/) filter.

Enjoy.

![pretty animation of the game of life playing.](gol.gif)

# Why?

Why not?

# How?

`jq` is a filter language for JSON data.  It takes JSON input, and produces
JSON output.  I wrote a filter program that takes in the previous board state,
and outputs the next board state.

Then I put it through some post-processing to produce the pretty picture
above (`runpretty.sh`).  Without that post-processing, it looks more like
this (`run.sh`):

![less pretty animation of the game of life playing.](gol-raw.gif)
