# Arcs for Crank

This is more or less a port of the "arcs" example in the PlaydateSDK (single file examples) to use the crank.

## Controls

* The Crank - turn the crank in either direction to make the arcs
* A button - start and stop auto-cranking
* B button and system menu "Reset" - resets arcs to the "default" start position and configuration
* D-pad up/down - increase/decrease the number of arcs in total
* D-pad right/left - increase/decrease the size of the arcs on the screen
* menu item "Invert" - swaps black and white drawing
* menu item "Randomize" - changes visualization to use random values for all variables, YMMV

## About

Arcs for Crank was put together by [Martin Grider](http://chesstris.com/), with inspiration and some original code fron the PlaydateSDK.

As soon as I saw that example, I wanted to make it work with the crank, and after working with the sdk for a week or so, I found that was a pretty easy change. Then I did add some bells and whistles. You can change the number of arcs and invert the drawing from the system menu. Toggle auto-draw with A, and reset the drawing with B.

## Changelog

* v1.1 - show arcs full screen by default, changed d-pad left/right to decrease/increase the radius of the arcs instead of stepping through crank rotation
* v1.0 - initial release
