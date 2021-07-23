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

I first installed `pandoc-bin` because I didn't to deal with a lot of
haskell dependencies.

.. code-block:: bash

    yay -S pandoc-bin


The first iteration I made generated an `index.html` file with
all the contents and a table of contents. The following bashscript shows
this:

.. code-block:: bash

    mkdir -p output
    pandoc --toc -f markdown -t html --mathjax -s -o ./output/index.html *.md
    rsync -rav -e "ssh -p PORT" output/ username@domain:/destination_folder


A sample file would look like this:
.. code-block:: markdown

    # Title that will be in table of contents

    Content body

The order in the table of contents is on the alphabetical ordering of
the files. In my case, the date prefixed all files, so they ended up in
the order I wanted them to.

The file however became too large after some time. I didn't want to get
a static site manager for this, so I tweaked the bashscript.

I can compile each file to a separate html file with pandoc, but I first
need to get a list of all files I want.

.. code-block:: bash

    # TODO test this out
    find . -maxdepth 1 -type f -name "*.md" -printf "%f\n" | sort | xargs -I % pandoc -f markdown -t html --mathjax --metadata title="questions" -x %

I need to ensure compile the files to a common directory so that its
easy to sync with my server. An index file that links up to all the
children files should also be generated dynamically, so that I can
easily find the links. I created a custom function `gen_html` that does
this:

.. code-block:: bash

    gen_html () {
        mkdir -p test_compile
        file_name=$1
        name="${1%.*}"
        echo "[${name}](./${name}.html)" >> index.md
        echo "" >> index.md
        pandoc -f markdown -t html --mathjax --metadata title="questions" -s -o ./test_compile/${name}.html $file_name 
    }


xargs runs in a different process, so the function `gen_html` will not
be available for that. To fix this, we first export it and then call it
with the xargs context. The `_` is a place holder for `argv[0]` and `%`
is the parameter defined by `-I`. See `this link <https://stackoverflow.com/a/11003457>`_
for more information.

.. code-block:: bash

    export gen_html
    find . -maxdepth 1 -type f -name "*.md" -printf "%f\n" | sort | xargs -I % bash -c 'gen_html "$@"' _ %

After which I generate the index with:

.. code-block:: bash

    pandoc -f markdown -t html --mathjax -s -o ./test_compile/index.html index.md 

You can find the full gist here:
TODO: add gist containing the full source code.
