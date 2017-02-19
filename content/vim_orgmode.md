Title: Org Mode in Vim
Date: 2017-01-09 20:20
Category: Computer
Tags: computer, vim, org
Slug: org-mode-in-vim
Author: John Nduli
status: published
Summary: Emacs has org mode. It is a really great tool. This is how I use the same in vim.

So emacs has this awesome tool called orgmode that I recently
saw in use. It really impressed me, especially the versatility of
it. Problem is, its emacs and I'm already a vim fan boy.

So what's the next best option? Easy, look for a vim plugin, and
oh boy did I get one... vim-orgmode.

It isn't perfect, heck I'd even suggest that you use the original
orgmode if you really want it. But here's how I go about using
orgmode:

First install it. When using vundle( I use vundle as my plugin
manager), just place the line below in the .vimrc file.

    ::vim
    Plugin 'jceb/vim-orgmode'

Then here are a few commands that will make life a breeze:

    ::vim
    help vim-ormode "tutorial doc. You should really start here.
    /hh "create a title
    /cn "create a check list
    /sa "create a date
    /cc "mark check list as done
    tab "unfold/ fold trees

So here's how I work:
I create a daily document at ~/ that has the date of the current
day. Something like plan_sun_05_01_2016.org
Within that folder I create a tree of various plans I'd like to do
Something like

    ::vim
    * Plan for day 
    ** Morning tasks [/]
    ** Server setup [/]
    ** Research [/]
    ** Night tasks [/]

The [/] is just a way to keep a track of the subtasks on the major
tasks. 
I then write out the subtasks. This is accomplished by \cn just
below the subtask. The [/] will also be autofilled by vim.
I can end up with a document that looks like this:

    ::vim
    * Task for the day
    ** Morning Tasks [2/3]
       - [X] Exercise
       - [X] Eat breakfast
       - [ ] Read emails
    ** Server setup [0/3]
       - [ ] Buy account
       - [ ] Set up apache
       - [ ] Set up mysql
    ** Research [0/2]
       - [ ] How to use org mode
       - [ ] Wrtiing vim scripts
    ** Night tasks [0/2]
       - [ ] Read book
       - [ ] Write blog post

There are a couple of things happening above here.

The [2/3] is auto generated, and each time to add an item or mark
an item with /cc it is updated.

Once I got the hang of it all, I read the docs a bit more. I got a
means of adding orgmodes into the global something so that I can
access their details wherever I want.

    ::vi
    let g:org_agenda_files = ['~/org/index.org','~/org/projects.org']

Once that is set in my .vimrc, whenever I am in any org file, I
can just type "\caa" to list all items for the current week and
"\cat" to view all todos for the week. It just scans through the
files in the list shown above.
