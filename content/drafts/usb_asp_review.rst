##############
USB ASP review
##############

:date: 2018-03-04 15:00
:tags: avr, projects
:category: Engineering
:slug: usb-asp-review
:author: John Nduli
:status: draft


I recently got some USBasps to use in programming my avr
microcontrollers. I'd never used this before, so it a nice
experience with then. To learn more about it checkout 
`this link <http://www.fischl.de/usbasp/>`_

.. include image of usb asp

First I got it with the 10 pin connector, so I went online and
found its schematic.

.. include image of connector found online

I had some attiny13 and atmega8 chips around, so I experimented
with these. Note that the image above is an mirror image of how
you should wire the usb asp. To help me with this, I imagined I
was pluggin the connector into the screen and attached jumper
wires to the correct position.

I then wrote a simple program that I wanted to burn into both
chips. The program just blinks LEDs.

.. TODO include programs

To compile the source code, I did this from the terminal:

.. TODO research compiling from terminal

After compilation, to burn it into the chip, I did this from the
terminal

.. TODO research burning firmware to chip

For this to work with atmega8, I changed the two commands to run
as follows:

.. TODO include commands from atmega8

For this price, the product works really great, and I will be
using it for a lot of my hobby projects.
