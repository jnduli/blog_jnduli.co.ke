##########################
Working With Bad CodeBases
##########################

:date: 2019-06-10
:tags: random
:category: Computer
:slug: working-with-bad-code-bases
:author: John Nduli
:status: draft

I've worked with codebases that made me really frustrated. Some of the
`features` I've seen include:

- Naming the variables returned by a function `$this` and `$return`.
  These variables belong the great great grandparent of the current class, so
  before figuring out what they do, I ended up traversing some crazy
  tree. And what did I get, the `$return` was an error string when the
  call is not an ajax call.
- Having multiple different languages in the same program. For example,
  I got one which had `php`, `python`, `perl`, `javascript (node in the
  backend)` and `c#`. I remember asking what some of these scripts were
  doing there, only to be told no one had any idea.
- Using 5 different ways to load javascript resources on the client. And
  worst of this was that all these methods were being used in the same
  template files. Worse still, some one decided to duplicate resources
  using each method in the individual files.
- God functions. I found a couple of functions that are more than 150
  lines. These functions are so complicated that they have their own
  internal functions, do database calls, handle web requests and even
  authentication.


My default reactions is usually flight, but sometimes I decide to fight.
This entails getting my hands dirty before I can clean up things.
However, for this to work, there needs to a proper process (I've found
having good processes helps versus focussing on the product).

Before anything else, make sure your first reaction to the codebase was
the right one. This means going into the code base to have a rough idea
of how things are implemented. There might just be the chance that the
scary lines are scarcer than you initially thought. This also helps you
have a rough overview of the code organisation and whatever styles (if
any) have been used.

Have an honest discussion with management or your supervisor. If the
code is bad, it means that feature addition or bug fixes take a
significant amount of time even for simple things. I remember having to
fix a js problem that was within a 1500 line function. This took a lot
of patience and perseverance, and when I finally fixed this, another
problem occured. This is especially true if you're new to the code base
or if there is no one to help you understand what's going on (this has
happened to me a few times :<).

Documentation will save your life. This takes many forms but primarily,
it involves comments, issues and actual system docs.

I have a policy of not working on any thing if there isn't an issue for
it. Furthermore, how the issue is created is a huge time saver. In my
case, issues should have the following:

- Clear unambiguous title
- The title should be prepended with the class of issue. I usually have
  Bug, Refactor, Feature, Documentation.
- The description of the issue should explain the problem
  comprehensively. If it is a bug, include a method of replication.
- An implementation plan: This is where I write a draft of how I think
  the problem will be solved. It doesn't need to be accurate, but at
  least the next time I get this issue I won't start from scratch.

Lastly, create issues for each and every problem you encounter, no
matter how simple it seems. 

Anytime you analyze a God function, comment out what you've understood
to be happening. This prevents you from starting all over again the next
time you have to fix something related to this. Also when you eventually
get to refactoring out this, you comments can guide you to get what
should be made into its own functions, class, etc.

Choose a coding standard and stick to it. Even better yet, you can look
for tools that ensure your code follows this standard. In my case, I use pre-commit
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
