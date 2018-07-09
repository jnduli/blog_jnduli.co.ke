##############################
Document Scaning in Arch Linux
##############################
:date: 2018-07-08 15:00
:tags: computer, linux
:category: Computer
:slug: document-scaning-in-archgit-branches-basics
:author: John Nduli
:status: published

Using a scanner in arch is pretty perplexing at first, especially
if you want to try it from the command line. Here are my steps to
end up with something that works.

First install the sane package. Sane provides a command line tool
for using scanners.

.. code-block:: bash

    sudo pacman -S sane

If the scanner is a hp brand, setting up hp-lip also helps out.

.. code-block:: bash

    sudo pacman -S hplip

This gives features that help setting up the printer or scanner
easily like hp-setup. Using it and the various prompts, one can
set up the printer and scanner easily.

Assuming the device has already been set up, find a list of
devices using:

.. code-block:: bash

    scanimage -L

My output looks like this:

.. code-block:: bash

    device `v4l:/dev/video0' is a Noname USB2.0 HD UVC WebCam: USB2.0 HD virtual device
    device `hpaio:/net/HP_LaserJet_Pro_MFP_M127fw?ip=192.168.1.27' is a Hewlett-Packard HP_LaserJet_Pro_MFP_M127fw all-in-one

To determine options for my device I have to do:

.. code-block:: bash

    scanimage --device "device name" -A

Which in my case is:

.. code-block:: bash
    
    scanimage --device 'hpaio:/net/HP_LaserJet_Pro_MFP_M127fw?ip=192.168.1.27' -A


This in my case outputs:

.. code-block:: bash

    All options specific to device `hpaio:/net/HP_LaserJet_Pro_MFP_M127fw?ip=192.168.1.27':
      Scan mode:
        --mode Lineart|Gray|Color [Lineart]
            Selects the scan mode (e.g., lineart, monochrome, or color).
        --resolution 75|100|150|200|300|600|1200dpi [75]
            Sets the resolution of the scanned image.
        --source Flatbed|ADF [Flatbed]
            Selects the scan source (such as a document-feeder).
      Advanced:
        --brightness -1000..1000 [0]
            Controls the brightness of the acquired image.
        --contrast -1000..1000 [0]
            Controls the contrast of the acquired image.
        --compression None|JPEG [JPEG]
            Selects the scanner compression method for faster scans, possibly at
            the expense of image quality.
        --jpeg-quality 0..100 [inactive]
            Sets the scanner JPEG compression factor. Larger numbers mean better
            compression, and smaller numbers mean better image quality.
      Geometry:
        -l 0..215.9mm [0]
            Top-left x position of scan area.
        -t 0..296.926mm [0]
            Top-left y position of scan area.
        -x 0..215.9mm [215.9]
            Width of scan-area.
        -y 0..296.926mm [296.926]
            Height of scan-area.


And using this information I can scan the document. For example to
output to a tiff file, I'll do:

.. code-block:: bash

    scanimage --device 'hpaio:/net/HP_LaserJet_Pro_MFP_M127fw?ip=192.168.1.27' --format=tiff --mode=color  --resolution=75 > 24.tiff

This sets the mode to color and the resolution to 75. These
options are found from the previous output.

To get the output into a pdf file, I use tiff2pdf. If I have
multiple files that I scanned, I add them into a single file using
tiffcp.

.. code-block:: bash

    tiffcp 1.tiff 2.tiff 3.tiff output.tiff
    tiffpdf -j output.tiff -o output.pdf

A more advanced example is:

.. code-block:: bash

   tiff2pdf -p letter -j -q 75 -t "title" -f -o title.pdf doc.tiff

However using tiff2pdf occasionally fails because libtiff has set and
upper limit of memory to be used by libjpeg. So if I have really
large tiff files, I'll most likely get the following error:

.. code-block:: bash

    JPEGLib: Backing store not supported.
    tiff2pdf: Error writing encoded strip to output PDF sm.pdf.
    tiff2pdf: An error occurred creating output PDF file.

I could not find a fix for this. So I just made sure my tiff files
were less than 10MB. If a file became more than that size, I
reduced the resolution of scanning. Also while combining files
using tiffcp, if the eventual tiff file is too big, I convert the
individual tiff files into pdfs and combine the pdfs using the
following command:

.. code-block:: bash

    pdfunite 1.pdf 2.pdf output.pdf

And that is how I scan document in my arch setup.
