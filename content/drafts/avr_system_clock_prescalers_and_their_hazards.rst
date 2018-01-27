#########################################
System Clock Prescalers and Their Hazards
#########################################

:date: 2018-01-28 15:00
:tags: projects
:category: Engineering
:slug: system_clock_prescalers_and_their_hazards
:author: John Nduli
:status: draft

One means of saving power or slowing down the attiny13A is by
slowing down the clock frequency of the microcontroller. To do
this, you can use a system clock prescaler. For example, for the
attiny13A, by default it runs with a clock of 9.6MHz with CKDIV8
fuse set (which provides a prescaler of 8). This then provides a
frequency of 1.2MHz by default from the attiny.

Supposing we want to slow it further, we can set up the CLKPR
(Clock Prescale Register) bits for the same. There is a special
write procedure provided for this to prevent unintentional
changes:

1. Write the Clock Prescaler Change Enable (CLKPCE) bit to one and all other bits in
CLKPR to zero.
2. Within four cycles, write the desired value to CLKPS while writing a zero to CLKPCE.

To follow this, our code will be:

.. code-block:: C

   // set CLKPCE to 1 and other bits to zero
   CLKPR = 0b10000000;
   // set prescaler to 256
   CLKPR = 0b00001000;

Furthermore, when compiling we have to use the optimization flags
-0s, otherwise the process might take more than four cycles. The
microcontroller will be running at a clock speed of 37.5KHz after
the operation.


Hazards
-------

If successful, however, programming the microcontroller will be
difficult. This is because of synching issues, whereby the
microcontroller is significantly slower than the programmer. To
fix this you can set the -B flag. However, the usbasp programmer I
am using does not have this functionality.

To fix this we have to analyze how the microcontroller sets the
new frequency. First, the microcontroller will boot up. At this
state CLKPR is still its default value. Then the two instructions
setting the prescaler are run. This therefore means that if we can
find a way to stop those two instructions from running, we can
program the microcontroller with another firmware.

To do this, we use the RESET pin. Connect Ground signal to the
RESET pin and then provide power to the programmer (usbasp). This
maintains the microcontroller in Reset mode, thus the instructions
changing the prescaler are not carried out. Then immediately flash
the attiny. If successful, the error will be done.




