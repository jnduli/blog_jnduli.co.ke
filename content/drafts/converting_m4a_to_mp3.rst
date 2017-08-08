##################################
Converting m4a to mp3 using ffmpeg
##################################

:date: 2017-06-28 15:00
:tags: ffmpeg
:category: Computer
:slug: converting-m4a-to-mp3-using-ffmpeg 
:author: John Nduli
:status: draft

I downloaded some podcasts from spark gap here. However, some
podcasts wer in m4a format. I needed them in mp3 format. So I
decided to use ffmpeg to do the conversion.

.. code-block:: bash

    ffmpeg -i episode18.m4a episode18.mp3

However, with this I got the following error:

.. code-block:: bash

    Stream mapping:
      Stream #0:1 -> #0:0 (png (native) -> png (native))
      Stream #0:0 -> #0:1 (aac (native) -> mp3 (libmp3lame))
    Press [q] to stop, [?] for help
    Too many packets buffered for output stream 0:1.
    [libmp3lame @ 0x2a4fc49c60] 4 frames left in the queue on closing
    Conversion failed!

I tried many fixes but this is what worked.

.. code-block:: bash

   ffmpeg -i episode18.m4a -map 0:0 ep_18.mp3

From the man pages this is what seems to be happening: I'm having
two streams

+ 0:0 the audio stream
+ 0:1 the png file









So I just ignore the png file and only select the audio stream to
go to the output file.

