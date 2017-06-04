############
Git Branches
############
:date: 2017-06-04 15:00
:tags: github, projects
:category: Computer
:slug: git-branches-basics
:author: John Nduli
:status: published

Lets say we have have a project A that works really well and
serves our purpose. Then there is this new killer feature that we
want to add to the project. Adding it directly to project A is not
a really good thing as it might break whats working.

So what happens. We create a branch on which we start implementing
this new feature. The branch is a copy of the code, that we can
work with safely. The branch can be experimental features or just
things we want to test to see if they are stable enough.

Branches are an important feature in git ahd here are the basic
commands I use:

.. code-block:: bash

    git branch #list all branches
    git branch <name> #creates branch called name
    git branch -m <name> #change branch name to name
    git branch -d <name> #deletes the branch. If changes havent been
                        #merged an error message is shown.
    git branch -D <name> #force delete branch even with unmerged conflicts
    git checkout <existing-branch> #switch to this branch
    git checkout -b <name> #create branch name and switch to it


Sometimes you create a branch but it cannot push to the server. To
fix this, you do:

.. code-block:: bash

    git push --set-upstream origin <branch_name>

And when you clone from a server, the git branch command will only
show the master branch. To view all the branches you do:

.. code-block:: bash

    git branch -a


These are the branch commands I interact with most of the time.
I'll add more over time as I get more familiar with branching.
