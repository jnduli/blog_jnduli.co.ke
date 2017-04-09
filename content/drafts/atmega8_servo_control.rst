#################
Why To Use Github
#################
:date: 2017-02-12 10:20
:tags: avr, servo, projects
:category: Mechatronics
:slug: serco-control-with-atmega8
:author: John Nduli
:status: draft

A servo motor is a really neat motor that is very useful. It is
used for precision control i.e. if I want something to rotate 5
degrees I can use it.

So I got a servo motor, the SG90, and tried to control its
rotations using the atmega 8.

First things first, this servo motor to rotate expects to get a
signal every 20ms. This means the signal has to have a period of
20ms. To go to the zero position, the signal has to be high for
1ms during this period. To go 90 degrees, it has to be high for
1.5ms, and for 180 degrees it has to be high for 2ms.

To use this, I used PWM of Atmega 8.

.. TODO provide link to atmega 8 datasheet

To achieve this, I used the 16 bit Timer/Counter 1 of the Atmega
8 and used Fast PWM.

Overview of How it Works
^^^^^^^^^^^^^^^^^^^^^^^^
There is a clock that operates at some frequency, lets say 1 Mhz.
This means we get a pulse every 0.001 ms. To get a signal that
occurs every 20ms, that means we can count the clock until 20000,
and that is one cycle. So we make sure whatever we want to happen
occurs within the 20000 ticks.

For i ms to be high during this period, we count until 1000 ticks
ie. from o to 1000 ticks, it should be high, and then make our
output false. After 20000 ticks, set output high again, counting
to 1000 then set it low again.

How its implemented
^^^^^^^^^^^^^^^^^^^

To implement this, we first set our microcontroller to Fast PWM
mode. In this mode, the counter will count for BOTTOM to TOP, and
then immediately from BOTTOM again. BOTTOM can be taken to mean 0.
So in this case it will count the ticks for zero to whatever
number we set as TOP, then restart again. This will make our
frequency.

.. TODO change this to be moretrue

We then set it up to be in noninverting mode. This means that when
counting from 0 to TOP, the output will be HIGH, and once TOP is
reached output goes LOW. The inverting mode, is the opposite of
the same.

We then tell the microcontroller that ICR1 will hold our TOP
value.




I set up noninverting mode of the PWM. This means the
OutputCompare is cleared on the Compare Match between TCNT1 and
OCR1x, and set at BOTTOM.

Set ICR1 as our TOP.
Set Fast PWM mode.

.. code-block:: C

    int main(){
        //set up non inverting mode in fast PWM
        TCCR1A |= (1<<COM1A1) |(1<<COM1B1);
        //set up ICR1 as TOP and PWM
        TCCR1A |= (1<<WGM11);
        TCCR1B |= (1<<WGM13) | (1<<WGM12);
        //set prescaler of 256
        //changes to prescaler of 1
        TCCR1B |= (1<<CS10);
        //set value for ICR1
        //to get clock of 50Hz
        //internal clock has frequncy of 1Hz
        ICR1 = 20000;

        DDRB = (1<<PB1)|(1<<PB2);

        //OCR1A = 10000;
        while(1){
            OCR1A = 1000;
            wait();
            OCR1A = 1500;
            wait();
            OCR1A = 2000;
            wait();
            OCR1A =1500;
            wait();
        }

    }
        code






