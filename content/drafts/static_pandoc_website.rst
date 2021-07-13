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
also include them in this order (in the table of contents and order in
the html).

Some improvements I can make include:
- having each file in a separate html file (especially when I have a lot of content)
- generating a table of contents linking to each html file


TO have each file in a separate html file, I can compile them separately
with pandoc into some outful folder. To get each file,I can run a filter
using find:

.. code-block:: bash

    # TODO test this out
    find . -maxdepth 1 -type f -name "*.md" -printf "%f\n" | sort | xargs -I % pandoc -f markdone -t html --mathjax --metadata title="questions" -x %

However, to make it robust, I need to ensure the output directory exists
and write it to a file similar to the markdown. I also need to add each
file to an index.md file that will be used as part of the table of
contents. To deal with this, I created a custon function `gen_html`:

.. code-block:: bash

    gen_html () {
        mkdir -p test_compile
        file_name=$1
        name="${1%.*}"
        echo "[${name}](./${name}.html)" >> index.md
        echo "" >> index.md
        pandoc -f markdown -t html --mathjax --metadata title="questions" -s -o ./test_compile/${name}.html $file_name 
    }


To call this function with xargs, I however had to do some special
things (TODO: add link to this):

.. code-block:: bash

    find . -maxdepth 1 -type f -name "*.md" -printf "%f\n" | sort | xargs -I % bash -c 'gen_html "$@"' _ %

After which I generate the index with:

.. code-block:: bash

    pandoc -f markdown -t html --mathjax -s -o ./test_compile/index.html index.md 

You can find the full gist here:
TODO: add gist containing the full source code.
