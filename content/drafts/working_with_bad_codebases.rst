##########################
Working With Bad CodeBases
##########################

:date: 2019-06-10
:tags: random
:category: Computer
:slug: working-with-bad-code-bases
:author: John Nduli
:status: draft

I've worked with codebases that made me really frustrated over time.
Ideally, when you get such a codebase, the first instinct should be
flight. However, when you fight the flight response, you need to get
your hands dirty and clean up things. So here are some of the tips I use
when this occurs:

First, go through the code base just to confirm it isn't your ego
speaking. Sometimes, it might just be some of the sections that are bad
and this is easily fixable. This also helps you have a rough overview of
the organisation of the code and whatever styles (if any) have been
used.

Have an honest discussion with management or your supervisor. If the
code is bad, it means that feature addition or bug fixes take
significant amount of time even for simple things. Have them understand
this especially if you're new to the code base or if there is no one to
help you understand what's going on (this has happened to me a few times
:<).

The next biggest thing that will help you in this wasteland is
documentation. Documentation can take a lot of facets, but here I'm
primarily concerned with comments, issues and actual system docs. 

I have a policy of not working on any thing if there isn't an issue for
it.  Furthermore, how the issue is created is a huge time saver. In my
case, issues should have the following:

- Clear unambiguous title
- The title should be prepended with the class of issue. I usually have
  Bug, Refactor, Feature, Documentation.
- The description of the issue should explain the problem
  comprehensively. If it is a bug, include a method of replication.
- An implementation plan: This is where I write a draft of how I think
  the problem will be solved. It doesn't need to be accurate, but at
  least the next time I get this issue I won't start from scratch.

Lastly, create issues for each and every problem you encounter. If you
do this long enough, it becomes significantly easy to create something
that will help you out.

Choose a coding standard and stick to it. Even better yet, you can look
for tools that ensure your code works well. In my case, I use pre-commit
hooks to either block commits or lint my code before committing
anything. This also has the added advantage of preventing mistakes when
you're in a hurry or there is a lot of pressure for something.

If possible, use CI/CD pipelines to prevent problems that can occur.
This includes merging things that breaks tests (that is if the system
has tests).

Next comes testing. This ends up being one of the best things on
improving a code base. This is because it forces you to follow good
coding practices just by the intent to test. For example, if you want to
test a really large function with lambda functions within it, you'll be
forced to break this up into small components that can be individually
tested. If the same function has database calls, you'll be forced to
test the returns of the database, thus removing this from the function.

I tend to avoid changing the database at first. This is because there
are a lot of things that could have been done there that you might mess
up. Also, unless you're a database pro, its safer to deal with the code
base first. FOr example, I met a database with virtual tables,
procedures, triggers that seemed to be fixable from the code side.
Trying to change any of this led to a disaster that took me days to fix
(I didn't even fix this, but reverted the database back to the original
form). There are a lot of hidden things in databases that cannot be
easilty found out.

If removing something, try to use 'grep' to make sure it isn't reference
somewhere. I've found controller functions used in the weirdest of
places on some codebases.
