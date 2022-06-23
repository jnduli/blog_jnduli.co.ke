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

e.g. You're given natural number n punchcards to run. Each card i musut be run
at some predetermined start time s_1 and stop running at some fininsh time f_i.
Only once punch card can run at a time, and each card has an associated value
v_i based on how important it is to your company. What is the optimal schedule
of punchcards that maximized the total value of all punchcards run?

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



