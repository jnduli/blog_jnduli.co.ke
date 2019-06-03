#########################################
Vimwiki Website Deployment with Git Hooks
#########################################


:date: 2019-06-03
:tags: projects, vim
:category: Computer
:slug: vimwiki-website-deployment-with-git-hooks
:author: John Nduli
:status: draft


Introduction: vimwiki and what I use it for

I use vimwikie to keep a track of my notes. These notes contains a lot
of things from book notes, linux commands and recipes. Its an amazing
tool that provides easy navigation to various notes and snippets I had
wriiten donw.

HOwever, I sometimes need to access these notes outside vim. This
necessitates having some sort of webiste. Luckily, vimwiki supports
conversion of the notes using 'VimwikiAll2HTML' command. Running that
command in vim will generate a website on the specified path. In my
case, I had to configure vimwiki properly to set up the website at my
preferred location using:

.. code-block:: bash

    let g:vimwiki_list = [{"path": "~/vimwiki", "path_html": "~/vimwiki/public_html"},
            \ {"path":"~/todo", "path_html": "~/todo/public_html"}]


I needed a means of updating the website automatically each time another
wiki page was added or content was changed. Luckily, my wiki is version
controlled using git, so I could fix this with git hooks. Git hooks work by performing the specified action when the commit is done. In my case, I tested this concept by showing the contents of the folder in the post-commit hook.

.. code-block:: bash

    touch .git/hooks/post-commit
    chmod +x .git/hooks/post-commit

And add the following contents:

.. code-block:: bash

    #!/bin/sh
    ls

After committing a file with `git commit`, the contents of the folder
will be shown.

The next step was figuring out how to generate the html from vimwiki.
The command shown is run within vim. Luckily vim has some commandline
options that help run the same from a bash script. For example, running

Look for example for this

In my case, I first passed the `-R` option which ensure vim opens
whatever file in readonly mode. This is because you might have the
index wiki file open, while the command is running. 

For vimwiki docs, the `VimwikiIndex` opens up the first wiki file. With
the wiki file open, I can then run `VimwikiAll2HTML` which compiles the
html files. I then close vim using `qa!`. 

However, running this raised a warning from vim, resulting in the
terminal output being mungled. A fix for this is to append ` < /dev/tty`
to the end of the command as discussed here :https://stackoverflow.com/questions/16517568/vim-exec-command-in-command-line-and-vim-warning-input-is-not-from-a-terminal

.. code-block:: bash

    vim -R -c ':VimwikiIndex' -c ':VimwikiAll2HTML' -c 'qa!' < /dev/tty

I also needed to upload the new files to my server. For that I use
rsync.

.. code-block:: bash

    rsync -rav -e "ssh -p 1233" public_html/ username@example.co.ke:/home/username/vimwiki


Combined, the post-commit file should contain:

.. code-block:: bash
    #!/bin/sh

    vim -R -c ':VimwikiIndex' -c ':VimwikiAll2HTML' -c 'qa!' < /dev/tty
    rsync -rav -e "ssh -p 1233" public_html/ username@example.co.ke:/home/username/vimwiki

Now every time I commit to the repo, the online version of my wiki is
also updated automatically. Serving this directory is just a matter of
setting up nginx properly (or the webserver being used). For security, I
use `.htpasswd` files using the guide found here: https://www.digitalocean.com/community/tutorials/how-to-set-up-password-authentication-with-nginx-on-ubuntu-14-04
