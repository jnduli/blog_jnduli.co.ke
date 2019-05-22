#####################
My First Vim Function
#####################
:date: 2017-08-09 08:20
:category: Computer
:tags: vim, programming
:slug: my-first-vim-function
:author: John Nduli
:status: published


I finally got down to writing my first vim function. It was a
gruelling journey but I finally got through it. So I'll write down
the problem I had and the fix I finally came up with as my
solution.

Problem Statement
=================

I usually keep a to do list of things I should do during the day
and week. Over time, tasks get lost as I remove some lines and I
can't keep a track of my progress in terms of planning and
implementation.
So basically I wanted a means for later on in the year or in my
life, I could have a file that showed how much I planned and how
much I had achieved.

So I created the file. It had the following syntax. I use vimwiki,
so to generate the table I just type:

.. code-block:: vim

    :VimwikiTable 5 3

The file looks like this:

.. code-block:: vim

    | Week | Total | Achieved | %    | Comments                        |
    |------|-------|----------|------|---------------------------------|
    | 1    | 13    | 1        | 7.69 | setting up lap  took up time    |
    | 2    | 20    | 9        |      |                                 |


This table has a percentage column that I wanted to be
automatically calculated. This would provide a means of checking
whether I'm becoming better at goal setting and goal achievement
over time.

Implementation
==============

To get the percentage, I had to basically get the row value that
corresponded to total, and the row value that corresponded to
achieved.

To get the once corresponding to totaL, I did this in normal mode:
    ^3wviw

What this does is this:

    ^ goes to beginning of line
    3w goes 3 words ahead after going to beginning of line
    viw selects the current word, which happens to be the total

With this I had the number in total column selected, so I had to
find out how to store the number for later use. Thats when
registers came into play. So adding:

    "py

Will yank the selected word and store it in the named register p.
With this I can get the variable from the register. So to get the
number 13 in the first row, this was the function:

.. code-block:: lua

    function! TodoPercentage()
        normal ^3viw"py
        let total = str2float(getreg("p"))
    endfunction

The getreg() function just gets the values stored in a register,
and the str2float function converts a string to a float variable.

To get the achieved value, I also did the same.

.. code-block:: vim

    function! TodoPercentage()
        normal ^3wviw"py
        let total = str2float(getreg("p"))
        normal ^5wviw"py
        let achieved = str2float(getreg("p"))
    endfunction

Since I had these two variables, I could now do the arithmetic.

.. code-block:: vim

    let percentage = (achieved/total) * 100


And since I just wanted to display the number in maximum of 2
decimal places, I used printf command, which sets the variable to
2 decimal places and also saves it in the per variable as a
string.

.. code-block:: vim

    let per = printf("%.2f", percentage)


To display the number in the appropriate section, I decided to use
the execute command. This would execute the string, converting
special characters to vim commands e.g. \<esc> to actually
pressing escape. The "normal!" executes the commands in normal
mode, the ! eliminates the custom mappings made.

.. code-block:: vim

    execute "normal! ^6wa ".per."\<esc>"

After the "normal!" the following happens:
    ^6w : moves to the start of the line, then 6 words after
    a : appends characters, enter insert mode
    .per. : concatenates the percentage string. Thus it will be
    typed character by character
    "\<esc>" : initiates the esc sequence leaving insert mode. The
    \ is used to signify that the key ESC is what is meant and not
    the actual characters.

So at the end of it all this was my function:

.. code-block:: vim
  
    function! TodoPercentage()
        normal ^3wviw"py
        let total = str2float(getreg("p"))
        normal ^5wviw"py
        let achieved = str2float(getreg("p"))
        let percentage = (achieved / total) * 100
        let per = printf("%.2f", percentage)
        execute "normal! ^6wa ".per."\<esc>"
    endfunction


Now to run this function I decided to map it to <leader>cp meaning
calculate percentage.

.. code-block:: vim

    autocmd FileType vimwiki nnoremap <leader>cp :call TodoPercentage() <Cr>

You can find this function implemented in my .vimrc file `here <https://github.com/jnduli/dotfiles>`_
