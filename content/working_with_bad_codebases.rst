###########################
Working With A Bad Codebase
###########################

:date: 2019-06-10
:tags: random
:category: Computer
:slug: working-with-a-bad-code-base
:author: John Nduli
:status: published

I've worked with codebases that have made me frustrated. Some of the
`**features**` I've seen include:

- Naming the variables returned by a function `$this` and `$return`.
- Having different languages in the same project. For example, I got one
  which had `PHP`, `Python`, `Perl`, `JavaScript (node in the backend)`
  and `c#`. Each language did not solve a unique and niche problem in
  this case.
- Using 5 different ways to load JavaScript and CSS resources on the
  client on the same project.
- God functions. These are functions that do everything and are
  impossible to debug.

Fixing such a codebase needs a lot of thought put into it. I found that
the following process works best for me.

Forgetting your ego
-------------------
The first reaction I have tends to be my ego talking. This is because I
find better ways to fix the problems at hand. This is usually because I
don't have the context nor understand the problem.

What I do is take a break, walk around and look at the codebase again
once I've cooled down. This provides some fresh perspective and I
sometimes find that the code is pretty decent. This occurs when I had
started looking at the worst done sections of the codebase. I also get
to see the code organisation and styles used by doing this.

Discuss with Management
-----------------------
Have an honest discussion with management. If the code is bad, it means
that feature addition or bug fixes take a significant amount of time
even for simple things. This is worse still if you're new to the code
base but don't have someone to guide you through it (This has happened
once for me).

Also make it clear that things will occasionally break, especially if
the project did not have tests.

Try to come up with a good enough workflow that will prevent the same
thing happening again.

Documentation
-------------
Document everything. In my case, documentation means issues, code
comments and API docs.

Issues
^^^^^^
I have a policy of not working on anything if there isn't an issue for
it. This helps me keep track of all the problems discovered in the
system.

The basic requirements I have for issues are:

- Clear unambiguous title
- Prepend the title with the type of issue. I usually have Bug,
  Refactor, Feature, Documentation.
- The description of the issue should explain the problem
  comprehensively. If it is a bug, include a method of replication.
- An implementation plan: This is where I draft an initial solution to
  the problem. This doesn't need to be accurate, but at least the next
  time I look at this issue I won't start from scratch.

I create issues for every problem I encounter, no matter how simple it
seems. 

Comments
^^^^^^^^
If you spend more time than necessary figuring out what a function does,
take the time to comment this out. The next time you deal with the
function, the comments will help you out.

If the problem is in the function design, the comments can be a huge
time saver when refactoring it.

For God functions, I try to comment blocks that do one specific thing.
When refactoring, I'll try to make these blocks into individual
functions.

Coding Standard
---------------
Choose a coding standard and stick to it. Even better yet, you can look
for tools that ensure your code follows this standard. In my case, I use
pre-commit hooks to either block commits or lint my code before
committing anything. This prevents mistakes when I'm in a hurry or there
is a lot of pressure.

CI/CD
-----
I try to set up CI/CD for automatic testing and deployment of my
projects. This catches some problems like linting errors and failing
tests. It also reduces normal access to production/testing servers.
This reduces the likelihood of making changes live.

Testing
-------
Testing is the best thing I've found when improving codebases. This is
because it forces good coding practices by default. For example, if you
encounter a God function, trying to test this will force you to break it
down into manageable blocks.

Database Modification
---------------------
I tend to avoid changing the database at first. This is because there
are a lot of things that could have been done there that you might mess
up. Also, unless you're a database pro, it's safer to deal with the code
base first.

For example, I met a database with virtual tables, procedures and
triggers. I only knew of these features, but had never actively used
them. The problem at hand seemed fixable from the db side, but I had not
factored in that the affected table linked up with multiple virtual
tables and triggers. Trying to change the database led to a disaster
that took me days to fix (I didn't even fix this, but reverted the
database back to the original form).

Others
------
If removing or renaming something, try to use `grep` to make sure it
isn't referenced somewhere. This is especially true for tightly coupled
systems. I've found controller functions used in the weirdest of places
on some codebases.

Try to check code quality using `code climate`. Analyzing the json
provided, helps figure out the more problematic sections of code. Better
yet, you can use this as a step in your CI workflow.
