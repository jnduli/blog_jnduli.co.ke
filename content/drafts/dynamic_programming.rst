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
DP breaks down an optimization problem into simpler sub-problems and caches the
solution to each sub-problem so that each sub-problem is solved once.

A sub-problem is a smaller version of the original problem, and can build on
each other to get the solution to the original problem.

For example, with the fibonacci sequence, a naive implementation is:

.. code-block:: python

   def fib(n):
        if n < 2:
            return 1
        return fib(n-1) + fib(n-1)

We end up doing a lot of repeated work above, so we can memoize the solution by:

.. code-block:: python
    
    def fib(n):
        re = [0, 1]
        if n < 2:
            return 1
        for i in range(2, n):
            re[0], re[1] = re[1], re[0] + re[1]
        return re[-1]

Problem
-------
You're given natural number n punch cards to run. Each card i should run at some
predetermined start time s_1 and stop running at some finish time f_i. One punch
card can run at a time, and each card has an associated value v_i, the
importance to your company. What is the optimal schedule of punch cards that
maximized the total value of all punch cards run?

Step 1: Identify the sub-problem in words
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Figure out the information that you need to solve the problem and write it out
in words.

To get the max value schedule, I'd need to answer the following sub-problems:

- the max value schedule for punch cards n-1 to n such that they're sorted by
  start time
- the max value schedule for punch cards n-2 to n such that they're sorted by
  start time
- and so on.

The sub-problem becomes: "the max value schedule for punch cards i through n
such that the punch cards are sorted by start time", i.e. we'll solve the sub
problem n-1 to n, then n-2 to n, and so on until 1 to n.

Step 2: Write out the sub-problem as a recurring mathematical function
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The recurring decision will be what we code. If it's hard to get this from step
1, then I may have the wrong sub-problem.

To find the recurrence, I ask:

- what decision do I make at each step?
- If I am at step i, what information do I need to decide what to do in step
  i+1 or i-1?

For the example problem:

- what decision do I make at each step? Do I run or not run the punch card. I
  ensure the punch card in consideration is compatible with the schedule before
  making the decision.
- If I am at step i, what information do I need to decide what to do in step
  i+1? The next compatible punch card. For punch card p, this is the punch card
  q such that s_q (start time for q) happens after f_p (finish time of p) and
  the difference between s_q and f_p is minimized.
- If I am at step i, what information do I need to decide what to do in step
  i-1? Future decisions, i.e. the ones made for punch cards i through n, so that
  we can decide to run / not run punch card i-1.

The recurrence function is:

.. code-block:: lua

    OPT(i) = max(v_i + OPT(next[i]), OPT(i+1))

We consider 2 options:

- `v_1 + OPT(next[i])` is the decision to run punch card i, and adds the value
  gained from running i to the next compatible punch card. `OPT(next[i])` is the
  max value schedule for punch cards next[i] through n. Adding these 2 gives the
  max schedule for punch cards i through n such that the punch cards are sorted
  by start time if punch card i is run.
- `OPT(i+1)` is the decision not to run, and gives the max value schedule for
  punch cards i+1 through n.

Step 3: Solve the original problm using Steps 1 and 2
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Th solution is: `OPT(1)`

Step 4: Determine the dimensions of the memoization array and direction to fill
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
We note that `OPT(1) = max (v_1 + OPT(next[1]), OPT(2))` and that punch cards
`next[1]` and `2` have start times after punch card 1, thus we need to fill the
memoization table from `OPT(n)` to `OPT(1)`.

How do we determine the dimensions of the memoization table? The dimensions are
equal to the number and size of the variables on which `OPT(*)` relies. In the
punch card problem, we depend on `i`, the card number, so the table will be
1-dimensional with a size of n, the total number of punch cards.

Step 5: Code it
^^^^^^^^^^^^^^^
Figure out the base case, and code it.

The solution to above is:

.. code-block:: python
    
    def punch_card_schedule(n, values, next):
        memo = [0] * (n+1) # memoization table from step 4
        memo[n] = values[n] # base case, we use 1 indexing
        for i in range(n-1, 0, -1): # build memoization table from n to 1
            memo[i] = max(v_1 + memo[next[i]], memo[i+1])
        return memo[1] # solution to the original problem




Paradox of Choice: Multiple Options DP Example
----------------------------------------------
You're selling friendship bracelets to n customers and the value of the product
increases monotonically i.e. the product has prices {p_1, ..., p_n} such that
p_i <= p_j if customer j comes after customer i. These n customers have values
{v_1, ..., v_n}, and a given customer will buy a friendship bracelet at price
p_i if p_i <= v_i, otherwise the revenue obtained from that customer is 0.
Assume the prices are natural numbers.

Problem: Find the set of prices that ensure you the maximum possible revenue
from selling your friendship bracelets.

My solution
^^^^^^^^^^^
sub problem in words:

1. Find the price p_n such that I get max revenue from customer c_n
2. Find the prices {p_n-1, p_n}, st I get max revenue from customer {c_n-1, c_n}

Step 2: Write out the sub-problem as a recurring mathematical decision

- what decision do I make at each step? What prices should I set the items,
  based off the current item
- if algo is at step i, what info would it need to decide what to do in step
  i+1? The max revenue for i+1, the price set for i+1, the customer value for i+1
- if algo is at step i, what info would it need to decide what to do in step
  i-1? I don't know

.. code-block:: lua


    Recurrence = opt(i) = 
                    if c_i > c_i+1:
                        m1 = c_i + max(c_i+1) - (c_i - c_i+1)(n-1+1)
                    else:
                        m1 = c_1 + max(c_i + 1)
                    max(m1, max(c_1+1)






Authors solution
^^^^^^^^^^^^^^^^

step 1:
sub-problem: max revenue from customers i to n, s.t. the price for customer i-1
was set at q.

That was found by realizing that to determine the max revenue for cust i through
n, I would need to find the answer to the following sub-problems:

- the max revenue from customers n-1 to n s.t. the price for cust n-2 was q
- max revenue from cust n-2 to n s.t. price for cusut n-2 is q
- etc.

variable q is added because in order to solve each sub problem, I need to know
price set for customer before the sub-problem. q ensures monotonic nature of the
set prices, and i keeps track of the current customer.

Step 2:
What decision do I make at each step? decide the price to sell the bracelet.
Since prices must be natural nos, I should set the price for cust 1 in he range
of q to price_customer_i.

If my algo is at step i, what infor woul it need to decide what to do in step
i+1? soln needs to know price set for cust i and the value of customer i+1 in
order to decide the value.

So the recurrence soln is:

opt(i,q) = max~([Revenue(v_i, a) + opt(i+1, a)]) 

s.t. max~ finds the max over all a in the range q <= a <= v_i

to find total revenue, we add the revenue from cust i to the max revenue
obtained from customers I=1 throgh n s.t . the price for cust i was set at





TODO: practice DP and clean up above notes
List of things:
https://www.quora.com/What-are-the-top-10-most-popular-dynamic-programming-problems-among-interviewers
https://leetcode.com/tag/dynamic-programming/

Look at errichto's videos and compile notes.




