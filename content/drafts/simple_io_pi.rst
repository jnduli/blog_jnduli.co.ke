#####################
Simple IO RaspberryPi
#####################

:date: 2019-03-04 15:00
:tags: projects
:category: Engineering
:slug: simple-io-raspberrypi
:author: John Nduli
:status: draft

Set up the pi using: 

.. code-block:: bash

   sudo apt update
   sudo apt install python3-gpiozero

Here is the code:

.. code-block:: python

   from gpiozero import Button
   from gpiozero import LED
   from signal import pause

   red = LED(26)
   red.blink(n=5, background=False)

   button = Button(20)

   button.when_pressed = red.on
   button.when_released = red.off

   pause()


To run the code, do:

.. code-block:: bash

   python3 gpio.py


Here is the reference for the gpio zero library: `gpiozero
<https://gpiozero.readthedocs.io/en/stable/index.html>`_
