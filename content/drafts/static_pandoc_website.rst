##########################
Static Website with Pandoc
##########################
:date: 2021-07-31
:category: Engineering
:slug: static_website_with_pandoc 
:author: John Nduli
:status: drafts

I needed to pull off a quick website that would have various mathematics
questions, and thought to try and use pandoc. Here are my learnings:

First install `pandoc-bin` so that you don't have to deal with a lot of
haskell dependencies.

.. code-block:: bash

    yay -S pandoc-bin


The first simple implementation would generate one index.html file with
all the contents and a table of contents. To do this, I have a
bashscript file that does:

.. code-block:: bash

    mkdir -p output
    pandoc --toc -f markdown -t html --mathjax -s -o ./output/index.html *.md
    rsync -rav -e "ssh -p PORT" output/ username@domain:/destination_folder


A sample file would look like this:
.. code-block:: markdown

    # Title that will be in table of contents

    Content body

If the files are named in a chronological order, then the markdown will
also include them in this order.

This works for the moment, but I needed some improvements:
1. Having each file in its separate html file
2. Having a table of contents to use.


TODO: Fix the following code
# Note: code is in the folder for purity questions.
# It seems to work, so I just need to clean it up and explain it
# Also think of other improvements to make



.. code-block:: bash

    gen_html () {
        mkdir -p test_compile
        file_name=$1
        name="${1%.*}"
        ext="${1##*.}"
        echo "[${name}](./${name}.html)" >> index.md
        echo "" >> index.md
        pandoc -f markdown -t html --mathjax --metadata title="questions" -s -o ./test_compile/${name}.html $file_name 
    }

    export -f gen_html 
    rm index.md
    touch index.md
    echo "%Index of Questions" >> index.md
    find . -maxdepth 1 -type f -name "*.md" -printf "%f\n" | sort | xargs -I % bash -c 'gen_html "$@"' _ %
    pandoc -f markdown -t html --mathjax -s -o ./test_compile/index.html index.md 
