###################
Dynamic Programming
###################


:date: 2022-05-06
:category: Computer
:slug: dynamic_programming
:author: John Nduli
:status: draft


I'm having a hard time grokking dynamic programming, so I'll work on a blog post
and read multiple resources to see if this will help.


Freecode camp Dynamic Programming Notes
=======================================
ref: https://www.freecodecamp.org/news/demystifying-dynamic-programming-3efafb8d4296/

Defined
-------
DP is breaking down an optimization problem into simpler sub-problems and
storing the solution to each sub-problem so that each sub-problem is only solved
once.

It's useful for optimization problems e.g. max or min given some constraint.

Sub-problems on Sub-problems on Sub-problems
--------------------------------------------
sub-problem: a smaller version of the original problem. If reworded correctly
sub-problems build on each other in order to obtain the soln to the original
problem.

e.g. You're given natural number n punch cards to run. Each card i must be run
at some predetermined start time s_1 and stop running at some finish time f_i.
Only once punch card can run at a time, and each card has an associated value
v_i based on how important it is to your company. What is the optimal schedule
of punch cards that maximized the total value of all punch cards run?

subproblem: the maximum value schedule for punch cards i through n such that the
punch cards are sorted by start time?? I don't understand this yet.
i.e. we do subproblem n-1 to n, n-2 to n, and so on until 1 to n. We memoize
each subproblem / store the solution.

fibonnaci, non memoized:

.. code-block:: python

   def fib(n):
     if n < 2:
       return n
      return fib(n-1) + fib(n-2)

fibonnaci, memized:

.. code-block:: python

   def fib(n)
     arr = [0, 1]
     for i in range(2, n+1):
        soln = arr[i-1] + arr[i-2]
        arr.append(soln)
      return arr[n]

My DP Process
^^^^^^^^^^^^^
Step 1: Identify the sub-problem in words

Grab a piece of paper and think about the information that you need to solve the
problem. Write out the sub-problem in words.

e.g. In above stated problem,
In order to determine the maximum value schedule for punchcards 1 through n such
that the punchcards are sorted by start time, I would need to find the answer to
the following sub-problem:

- the max value schedule for punchcards n-1 through n such that the punchcards
  are sorted by start time
- the max value schedule for punchcards n-2 through n such that the punchcards
  are sorted by start time
- the max value schedule for punchcards n-2 through n such that the punchards
  are sorted by start time
- and so on,

so the problem, 'the max value schedule for punch cards i through n such that
the punch cards are sorted by start time' becomes the sub problem.


Step 2: Write out the sub-problem as a recurring mathematical decision

The mathematical recurrence or repeated decision will eventually be what you
code. If it's difficult to encode your sub-problem from Step 1 in math, then it
may be the wrong sub-problem.

In order to find a recurrence, ask:

- what decision do I make at every step?
- If my algorithm is at step i, what information would it need to decide what to
  do in step i+1? (And sometimes: If my algorithm is at step i, what information
  did it need to decide what to do in step i-1?)

So what decision do I make at every step? The punch cards are sorted by start
time. For each punch card that is compatible with the schedule so far (its start
time is after the finish time of the punch card that is currently running), the
algorithm must choose between two options, to run or not to run the punch card.

If my algorithm is at step i, what information would it need to decide what to
do in step i+1? It needs to know the next compatible punch card in the order.
The next compatible punch card for a given punch card p is the punch card q such
that s_q(start time of q) happens after f_p(finish time of p) and the difference
between s_q and f_p is minimized.

If my algorithm is at step i, what information would it need to decide what to
do in step i-1? It needs to know about future decisions, the ones made for
punch cards i through n in order to decide to run or not run punch card i-1.


Recurrence: `OPT(i) = max(v_i + OPT(next[i]), OPT(i+1))`, where `OPT(i)` is the
max value schedule for punch cards i through n such that the punch cards are
sorted by start time. In order to determine the value of `OPT(i)` we consider
two options, and we want the max of these options. Once we choose the option
that gives us the max result at step i, we memoize its value as `OPT(i)`.

The two options are: `v_i + OPT(next[i])` which is the decision to run punch
card i. It adds the value gained from running i to `OPT(next[i])` where
`next[i]` is the next compatible punch card following punch card i.
`OPT(next[i])` gives the max value schedule for punchcards next[i] through n
such that the punch cards are sorted by start time. Adding these two values
together gives the max value schedule for punch cards i through n s.t. the punch
cards are sorted by start time if punch card i is run.

`OPT(i+1)` represents the decision not to run. It gives the max value schedule
for punch cards i+1 through n.

Solve the original problem using Steps 1 and 2
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. TODO



