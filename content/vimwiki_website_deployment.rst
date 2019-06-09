##########################################
Vimwiki Website Deployment using Git Hooks
##########################################

:date: 2019-06-09
:tags: projects, vim
:category: Computer
:slug: vimwiki-website-deployment-using-git-hooks
:author: John Nduli
:status: published

I use vimwiki to keep a track of my notes. This includes book summaries,
linux commands, recipes and miscellanous content. It's an amazing vim
plugin that provides easy access and navigation to the content. This
however works well only within vim.

I occasionally need to access these notes outside vim and my laptop. One
of the solutions for this is to have the content online as html, thus I
can easily access this using any device that has a browser. Vimwiki
supports note to html conversion using `VimwikiAll2HTML` command.
Running that command in vim will generate a website on the specified
directory.

I configured vimwiki to generate the website at my preferred location using:

.. code-block:: bash

    let g:vimwiki_list = [{"path": "~/vimwiki", "path_html": "~/vimwiki/public_html"}]

I also needed a means of syncing the website with my notes. So anytime I
add a new note or change some content, the website would also get
updated with this. To solve this, I used `git hooks` (I version control my
notes). I added a `post-commit` hook, which would build the html content
using vim and upload it to the server.

To generate the html content:

.. code-block:: bash

    vim -R -c ':VimwikiIndex' -c ':VimwikiAll2HTML' -c 'qa!' < /dev/tty

The `-R` option ensures the file is open in `ReadOnly` mode. This is
because the `index wiki` file might be open on another vim instance
while this command runs.

The `VimwikiIndex` command opens up the first wiki file in the
`vimwiki_list` variable.

The `VimwikiAll2HTML` command will generate the html files.

`qa!` exits vim.

Running this command from `post-commit` hook raised a warning, resulting
in the output being mungled. To fix this, `< /dev/tty` is appended to
the command. This discussion can be found `here on stackoverflow
<https://stackoverflow.com/questions/16517568/vim-exec-command-in-command-line-and-vim-warning-input-is-not-from-a-terminal>`_

To upload the files to my server, I use `rsync`. Here's the command
used:

.. code-block:: bash

    rsync -rav -e "ssh -p 1233" public_html/ username@example.co.ke:/home/username/vimwiki

Combined, the `post-commit` file contains:

.. code-block:: bash

    #!/bin/sh

    vim -R -c ':VimwikiIndex' -c ':VimwikiAll2HTML' -c 'qa!' < /dev/tty
    rsync -rav -e "ssh -p 1233" public_html/ username@example.co.ke:/home/username/vimwiki

Now every time I commit to the repo, the online version of my wiki is
also updated automatically. Serving this directory is just a matter of
setting up nginx properly (or the webserver being used). For security, I
use `.htpasswd` files using the guide found `here
<https://www.digitalocean.com/community/tutorials/how-to-set-up-password-authentication-with-nginx-on-ubuntu-14-04>`_.
