#################################
Scrolling Text With 5*4 LED Array
#################################

:date: 2017-10-29 10:20
:tags: avr, projects
:category: Engineering
:slug: 5-by-4-led-array-scrolling-text
:author: John Nduli
:status: published

I usually see lights in Nairobi scrolling text from right to left.
It is an interesting thing to see, and if done right is usually
beautiful. I wanted to make one, and so this is how I went about
it.


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

.. image:: {static}/images/5_by_4_led_array.png
    :alt: 5_by_4 led array image

To have the scrolling effect, I then wrote code that turns on and
off LEDs at a particular pattern. Making this faster will result
in less flickering of light. I used an atmega 8 for this and added
the respective current limiting resistors. The circuit and code
for this can be found `here:githublink <https://github.com/jnduli/led_array_atmega8>`_.

Here is the image of the final fabricated circuit:

.. image:: {static}/images/5_by_4_led_physical_circuit.jpg
    :alt: 5_by_4 led array image

You can find the video of the working circuit here. The text being
shown is "HAPPY EASTER" in case it is the video is not clear
enough.

.. raw:: html

   <iframe width="560" height="315" src="https://www.youtube.com/embed/Zk5a-tJbTKo" frameborder="0" gesture="media" allowfullscreen></iframe>

