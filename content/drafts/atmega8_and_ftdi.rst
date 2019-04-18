#################
Atmega8 with FTDI
#################

:date: 2018-03-04 15:00
:tags: avr, projects
:category: Engineering
:slug: atmega8-with-ftdi
:author: John Nduli
:status: draft

Connect the atmega8 to the ftdi breakout board using UART pins as
follows:

The following code is burnt onto the atmega8:

.. code-block:: C

    #include <avr/io.h>
    #include <util/delay.h>

    #define F_CPU 1000000UL
    #define BAUD 4800

    void UART_init(void);
    void UART_transmit(char data);
    int main(void){
        PORTB = _BV(PB0);
        UART_init();
        while(1){
            UART_transmit('c');
            UART_transmit('h');
            UART_transmit('a');
            PORTB ^= _BV(PB0);
            _delay_ms(500);
        }
        return 0;
    }

    void UART_init(void){
        unsigned long ubrr = F_CPU/16/BAUD - 1;
        UBRRH = (ubrr>>8);
        UBRRL = ubrr;
        // enable receiver and transmitter
        UCSRB = _BV(RXEN) | _BV(TXEN);
    }

    void UART_transmit(char data){
        loop_until_bit_is_set(UCSRA, UDRE);
        UDR = data;
    }




The following python code will then read the output from the avr:

.. code-block:: python

    import serial

    port = "/dev/ttyUSB1"
    baud = 4800

    serialport = serial.Serial(port, baud, timeout=0.5);
    while True:
        command = serialport.read();
        print(str(command))


For better flow control, we can use the RTS and CTS signals. 

As a thought, RTS can be set as an interrupt, and CTS a normal
pin. When the interrupt is activated, the CTS output is set to low
and data got. After the interrupt, CTS is cleared. RTS is an input
while CTS is an output in this state.

When the microcontroller wants to send data, RTS is an output,
setting its value to low. CTS is an input.

Another alternative I got for this was PL2303HX

http://forum.arduino.cc/index.php?topic=23894.0
