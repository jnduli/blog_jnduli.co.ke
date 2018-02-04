#########################################
System Clock Prescalers and Their Hazards
#########################################

:date: 2018-02-04 15:00
:tags: projects
:category: Engineering
:slug: system_clock_prescalers_and_their_hazards
:author: John Nduli
:status: published

One means of saving power with the attiny13A is by slowing down
the clock frequency of the microcontroller. One option of doing
this is by using the system clock prescaler. The attiny13A is
shipped with running on a 9.6MHz internal RC Oscillator. It has
the CKDIV8 fuse set (which provides a system clock prescaler of
8), thus it runs on a frequency of 1.2MHz.

Supposing we want to slow it further, we can set up the CLKPR
(Clock Prescale Register) bits for the same. If we set this to a
prescaler of 16 for example, the attiny will run at a frequency of
600KHz. However, there is a special write procedure provided for
this to prevent unintentional changes:

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
difficult. This is because of syncing issues, whereby the
microcontroller is significantly slower than the programmer. To
fix this you can set the -B flag using avrdude. However, the
usbasp programmer I am using does not have this functionality.

To fix this we have to analyze how the microcontroller sets the
new frequency. First, the microcontroller will boot up. At this
state CLKPR is still its default value. Then the two instructions
setting the prescaler are run. This therefore means that if we can
find a way to stop those two instructions from running, we can
program the microcontroller with another firmware.

IF we activate the RESET pin, before the clock prescaler is set,
the chip can be reprogrammed. Connect Ground signal to the RESET
pin and then provide power to the programmer (usbasp). This
maintains the microcontroller in Reset mode, thus the instructions
changing the prescaler are not carried out. Then immediately flash
the attiny. If successful, the error will be gone.

Another way to prevent this is to have a considerable delay before
the CLKPCE bits are set. This delay allows for reprogramming if
necessary.


