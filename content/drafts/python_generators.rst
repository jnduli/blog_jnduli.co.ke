#################
Python Generators
#################

:date: 2019-04-20 14:30
:tags: programming
:category: Computer
:slug: python-generators
:author: John Nduli
:status: draft

Generators are functions that behave like iterators, thus can be used in
for loops. For example, a generator that produces even numbers will look
like:

.. code-block:: python

    def even_numbers(upperlimit):
        current = 0
        while current < upperlimit:
            yield current
            current += 2

Another method to create a generators is using a syntax similar to list
comprehension:

.. code-block:: python

    even_numbers = (n for n in range(0, 50, 2))

Generators are lazy loading, which means that a value is generated only
when it's needed. This can best be observed in the even_numbers function
above. It is used as shown below:

.. code-block:: python
    
    ev = even_numbers(10)
    next(ev) # Prints 0
    next(ev) # Prints 2

The computation for the next item only occurs when next is called. After
yield, the function pauses, waiting for the next command to be called.
The advantage of this is that it improves memory performance, since the
values are only generated when needed, versus having them in an list.
this can be shown in the example below, where the list is orders of
magnitude larger than the generator.

.. code-block:: python

    import sys
    a = [n for n in range(0, 1000000, 2)]
    print(sys.getsizeof(a)) # Outputs 4290016 bytes
    b = (n for n in range(0, 1000000, 2))
    print(sys.getsizeof(a)) # Outputs 120 bytes


Another advantage is that generators do not make an assumption on the
data structure one wants. For example:

.. code-block:: python
    
    s = set(even_numbers(10))
    b = list(even_numbers(10))

As seen above, it is really simple to get different data structures when
using generators.

Communication can be done with generators using `send`. For example:

.. code-block:: python

    def even_numbers(upper):
        current = 0
        while current < upper:
            if not (current % 2):
                new_max = (yield current)
                if new_max is not None:
                    upper = new_max
            current += 1

In the above example, the upper limit can be changed while iterating
through the generator. This is shown below:

.. code-block:: python

    even = even_numbers(20)
    for i in even:
        print(i)
        if i == 4:
            print(even.send(10))

The `generator.send()` command kinda calls next, so that is why in the
example I print it out (so as not to mix the even number after 4 i.e. 6)
