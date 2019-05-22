######################
Keeping a Diary in Vim
######################

:date: 2017-11-05 09:00
:tags: vim
:category: Computer
:slug: keeping-diary-in-vim
:author: John Nduli
:status: published


A diary is a good way to write down one's thoughts and memories of
the day.

Being a vim fan, I had to find a way to easily help me write down
my diary. This is where vim wiki comes in. It is basically a means
of writing down wikis in vim, and has an awesome diary mode.

I use vundle as my vim plugin manager. So to install vimwiki, I
added to the following to my vimrc file:

.. code-block:: vim

   Plugin 'vimwiki/vimwiki'

And then ran the following from withing vim (while the vimrc file
is the current buffer):

.. code-block:: vim

    :source %
    :PluginInstall

To enter diary mode, I just type <leader>wi in any vim session and
it will direct me into the diary entries.

To add a diary on the day's happenings, I just type
<leader>w<leader>w and it will open a blank buffer. When this is
saved it will be a new day's entry.

To update the diary with the new entry, <leader>wi will take you
to the page containing the various entries. Then type
<leader>w<leader>i and this will update the list with the new
entry.

Since I use vim a lot, I find this really useful when collecting
my thoughts during a day.

So in summary these are the commands helpful for vimwiki diary
mode:

.. code-block:: vim

   <leader>w<leader>w " create new diary note for the day
   <leader>wi " show all diary entries
   <leader>w<leader>i " update entries


