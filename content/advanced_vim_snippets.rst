######################
Custom snippets in vim
######################

:date: 2020-08-30
:tags: programming
:category: Computer
:slug: custom-snippets-in-vim
:author: John Nduli
:status: published

Set up
======
I use `ultisnips <https://github.com/SirVer/ultisnips>`_ for my
snippets. To set this up, I have this in `vimrc`:

.. code-block:: vim

    call plug#begin('~/.vim/plugged')

    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' " Snippet support
    call plug#end()


    let g:UltiSnipsExpandTrigger="<c-e>" " Default is <tab>
    let g:UltiSnipsEditSplit="vertical"
    let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]

This setups `ultisnips` and `vimsnippets` using `plug`. Whenever I have
a snippet I want to use, I press `ctrl-e` and its expanded. I place
custom snippets in `~/.vim/mysnippets`, so having `UltiSnips` in the
`UltiSnipsSnippetDirectories` parameters enables me to use both the
custom snippets and those provided by `ultisnips/vimsnippets`.

Simple snippet
==============
I like to pre-plan my day, with most days having similar and unique
tasks. A snippet is a good use case for the similar tasks.

Here's an example:

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
in any file to expand this. This does not cover tasks that are similar,
but with small differences e.g. for clean up, it needs to be clean up
something. I then update the snippet to include this by having `{$1:
utensils, desk, room}`. `utensils, desk, room` in this case is the
default string.

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
the points with this marking.
    
Advanced snippets
=================
The simple snippet has some disadvantages like:

+ I can't specify unique tasks for a particular day e.g. I take out
  trash on Thursdays
+ I can't specify different conditions for tasks e.g. I need to switch
  out some tasks with my house mate

`Context aware snippets
<https://github.com/SirVer/ultisnips/blob/7dc30c55e5c41c98a8c7421bb01fec1d559256fd/doc/UltiSnips.txt#L1411>`_
help with this. A context (in UltiSnips) is a python function that
returns true. For example, I want to do some tasks depending on if its
the weekend or not.

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

This works but creates a lot of repeated tasks between the weekday and
weekend. To avoid this, python code can be used directly within the
snippets, for example:

.. code-block:: python

    global !p
    import datetime 
    endglobal

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


To prevent the repetition of datetime methods, you can define a global
variable and use that instead.

.. code-block:: python

    global !p
    import datetime 

    day = datetime.date.today().isoweekday()
    endglobal

    ## in snippet have this
    `!p snip.rv = "- [ ] Weekly email\n" if day > 5 else ""`

Ultisnips provides a powerful tool to customize repeated texts depending
on the situation. Described in this article is one of the use cases I
have, and various options I use to make my snippets manageable.
