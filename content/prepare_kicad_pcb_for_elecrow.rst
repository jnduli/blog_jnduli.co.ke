########################################
Prepare Kicad PCB for Elecrow Production
########################################

:date: 2017-10-21 08:00
:category: Engineering
:slug: prepare-kicad-pcb-elecrow
:author: John Nduli
:status: draft


Before designing the PCB, set the following design rules:

*  Minimum PCB Track : greater than 0.2mm
*  Minimum Track /Vias space: greater than 0.2mm
*  Minimum pads space: greater than 0.2mm

The defaults provided by Kicad are OK, so no need to change them
unless you have some special requirements.

Once the pcb has been completed, go go:

.. code-block:: bash

   File>>Plot

Make sure the following options are checked in Layers section:

+ F.Cu
+ B.Cu
+ B.SilkS
+ F.SilkS
+ B.Mask
+ F.Mask
+ Edge.Cuts

Make sure the Plot format is set to Gerber.
It is also advisable to set an OutputDirectory for your gerber
files. This prevents mixing up the gerber with normal project
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
