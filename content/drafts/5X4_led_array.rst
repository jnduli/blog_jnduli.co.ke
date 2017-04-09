#################################
Scrolling Text With 5X4 LED Array
#################################

:date: 2017-03-26 10:20
:tags: avr, led, projects
:category: Electronics
:slug: 5X4-led-array-scrolling-text
:author: John Nduli
:status: draft

.. TODO: Introduction -wehre is it used ..

I usually see lights in Nairobi scrolling text from right to left.
It is an interesting thing to see, and if done right is usually
beautiful. I wanted to make one, and so this is how I went about
it.

.. TODO: basic principle ..

Multiplexing LEDs
-----------------
To light and LED one needs 5V supplied to cathode and GND supplied
to anode. This means if we have 2 leds, both receiving 5V and only
one receiving GND, only one LED will light. The same occurs when
both receive GND and only one receives 5V. This is the basic
building block of an LED matrix.

So how does one keep this so. Well, one option is using a
microcontroller. The microcontroller's pins can be set to output a
HIGH (5V) or a LOW(GND/0V). So having a microcontroller will help
us out in choosing which LED to use.

The following is the schematic I then came up with:

.. image:: {filename}/images/5X4_led_array.png
    :alt: 5X4 led array image

To do scroling effect, I then wrote the following code: ling to
github

And here is the result


.. Picture of accomplished text
