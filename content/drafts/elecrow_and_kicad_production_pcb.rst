################################
Elecrow and Kicad PCB Production
################################

I've been meaning to make a circuit that will be produced as a PCB
for a long while now. So some time in March I started to make what
would be an LED multiplexed circuit. I decided to use Kicad
because if FOSS.

So the circuit is basically a multiplexed LED circuit ( an array
of 5 by 10 LEDs). I used an atmega 8 as my controller and

Elecrow:

Before designing the PCB, set the following design rules:

Minimum PCB Track : greater than 0.2mm
Minimum Track /Vias space: greater than 0.2mm
Minimum pads space: greater than 0.2mm

The defaults provided by Kicad are OK, so no need to change them
unless you have really specific needs.

Outputting files:

Once the pcb file is completed, go to:

.. code-block:: bash

   File>>Plot

Make sure the following options are checked in Layers:

+ F.Cu
+ B.Cu
+ B.SilkS
+ F.SilkS
+ B.Mask
+ F.Mask
+ Edge.Cuts

Make sure the Plot format is set to Gerber.
It is also advisable to set an OutputDirectory for your gerber
files.

Make sure the following are checked in Options:


+ Plot footprint values
+ Plot footprint references
+ Exclude PCB edge layer from other layers

For Gerber options, make sure this is checked:

+ Use Protel filename extensions

Click on Plot to generate the gerber files.

To generate the drill files, click on "Generate Drill File". 
I set the Drill Units to Millimeters, Zeros Format to Decimal
Format and Dril Map File Format to Gerber. Also Drill Origin was
set to Absolute. Then click Drill File.




Kicad outputs files with a different naming convention as that
expected by elecrow. So you'll have to rename these files. For
examples:

+ pump-B.Cu.gbl becomes pump.gbl
+ pump-B.Mask.gbs becomes pump.gbs
+ pump-B.SilkS.gbo becomes pump.gbo
+ pump-Edge.Cuts.gm1 becomes pump.gml
+ pump-F.Cu.gtl becomes pump.gtl
+ pump-F.Mask.gts becomes pump.gts
+ pump-F.SilkS.gto becomes pump.gto
+ pump.drl becomes pump.txt

After renaming the files you can then compress all of them into a
zip file and make the order.
