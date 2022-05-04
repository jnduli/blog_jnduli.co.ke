######################
Understanding my vimrc
######################

I've been struggling with vimscript for a while, so when I found out that
neovim had migrated to lua as its primary scripting language, I chose to give
this a jump. This would also provide a change to clean up my vim config because
I think there are a lot of stale configs there.

Some plugins use python, but neovim has python support as an extra plugin. I
installed pyn-nvim, but in virtual environments it's not found. To fix this, I
tell vim the python to use using:

.. code-block:: python

    vim.g.python3_host_prog = '/usr/bin/python'

Next in line are my editor options:

.. code-block:: lua

    -- editor options
    vim.g.mapleader = ";"
    vim.g.maplocalleader = ","

    vim.o.number = true -- show line number where cursor is
    vim.o.relativenumber = true -- other lines shown relative to current line
    vim.o.numberwidth = 2 -- min space set for line nos
    vim.o.tabstop = 4 -- <Tab> = 4 spaces
    vim.o.shiftwidth = 4 -- similar to tabstop
    vim.o.expandtab = true -- replace <Tab> with spaces when used
    vim.o.copyindent = true -- use same indentation as found in files
    vim.o.autoindent = true -- copies current indent to next line
    vim.o.spell = true -- spell checking
    vim.o.spelllang = 'en_us,en_gb,sw,en'


I'll have to rearrange things better so that my configs make sense for a blog
post.



