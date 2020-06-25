Custom snippets in ultisnips

Set up
======
I use ultisnips for my snippets in vim. To set this up, I have the
following in my vimrc:

.. code-block:: lua

    call plug#begin('~/.vim/plugged')

    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' " Snippet support
    call plug#end()


    let g:UltiSnipsExpandTrigger="<c-e>" " Default is <tab>
    let g:UltiSnipsEditSplit="vertical"
    let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]

This setups ultisnips and vimsnippets using plug. Whenever I have a
snippet I want to use, I just press `ctrl-e` and its expanded. I place
custom snippets in `~/.vim/mysnippets` but still want to use the
snippets provided by Ultisnips.

Simple snippet
=============

I plan my day on the previous night. My plans tend to be similar with
small changes here and there, so this is a good use case for snippets.

Here's a sample snippet for use:

.. code-block:: python

    snippet bd "Basic Day" b
    = Tasks =
    - [ ] Exercise
    - [ ] Clean up
    - [ ] Bathe + brush teeth
    - [ ] Write story
    - [ ] Book read
    - [ ] Exercise
    - [ ] Emails cleanup
    - [ ] Weekly email
    endsnippet

You can place this file in `~/vim/mysnippets/all.snippet` and type `bd`
in any file to expand this. That is the simplest form of a snippet I've
found. I use this for some time and soon find out that I need to have
specific tasks e.g. for clean up, it needs to be clean up something. I
then update the snippet to include this by having `{$1: utensils, desk,
room}`. `utensils, desk, room` in this case is the default string.

.. code-block:: python

    snippet bd "Basic Day" b
    = Tasks =
    - [ ] Exercise
    - [ ] Clean up: ${1:utensils, desk, room}
    - [ ] Meditation
    - [ ] Write story: ${2:content}
    - [ ] ${3:Book} read
    - [ ] Exercise
    - [ ] Emails cleanup
    - [ ] Weekly email
    endsnippet


Now typing `Ctrl-j` after the snippet has been expanded takes me to all
the points with the marking.
    
Advanced snippets
=================
However, I quickly realized that the simple plan doesn't work daily.
This is because some days have special circumstances that are easy to
miss e.g. I take out trash on Thursdays.

That is where context aware snippets come in. A context is a python
function that returns true. For example, I want to do some tasks
depending on if its the weekend or not.


.. code-block:: python

    global !p
    import datetime 
    endglobal

    # weekday basic day
    context "datetime.date.today().isoweekday()<=5"
    snippet bd "Basic Day" b
    = Tasks =
    - [ ] Exercise
    - [ ] Clean up: ${1:utensils, desk, room}
    - [ ] Meditation
    - [ ] Write story: ${2:content}
    - [ ] ${3:Book} read
    - [ ] Exercise
    - [ ] Emails cleanup
    - [ ] Retrospection
    endsnippet

    # weekend basic day
    context "datetime.date.today().isoweekday()>5"
    snippet bd "Weekend" b
    = Tasks =
    - [ ] Exercise
    - [ ] Clean up: ${1:utensils, desk, room}
    - [ ] Wash house and clothes
    - [ ] Meditation
    - [ ] Write story: ${2:content}
    - [ ] ${3:Book} read
    - [ ] Exercise
    - [ ] Emails cleanup
    - [ ] Weekly email
    endsnippet

However, a problem is that a lot of the content is repeated between the
weekday and weekend snippets. A way of avoiding this is to use python
code internally within the snippets, for example:

.. code-block:: python

    global !p
    import datetime 
    endglobal

    # weekday basic day
    context "datetime.date.today().isoweekday()<=5"
    snippet bd "Basic Day" b
    = Tasks =
    - [ ] Exercise
    - [ ] Clean up: ${1:utensils, desk, room}
    `!p snip.rv = "- [ ] Wash house and clothes\n" if datetime.date.today().isoweekday() > 5 else ""`- [ ] Meditation
    - [ ] Write story: ${2:content}
    - [ ] ${3:Book} read
    - [ ] Exercise
    - [ ] Emails cleanup
    `!p snip.rv = "- [ ] Retrospection\n" if datetime.date.today().isoweekday() <= 5 else ""`- [ ] Emails cleanup
    `!p snip.rv = "- [ ] Weekly email\n" if datetime.date.today().isoweekday() > 5 else ""`
    endsnippet


And there we have a better implementation. To prevent the repetition of
datetime methods, you can define a global variable and use that instead
e.g.

.. code-block:: python

    global !p
    import datetime 

    day = datetime.date.today().isoweekday()
    endglobal

    ## in snipeet have this
    `!p snip.rv = "- [ ] Weekly email\n" if day > 5 else ""`
