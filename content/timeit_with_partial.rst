##########################
Python Timeit with Partial
##########################
:date: 2019-07-20
:tags: projects
:category: Computer
:slug: python-timeit-with-partial
:author: John Nduli
:status: published


The `timeit module <https://docs.python.org/3.7/library/timeit.html>`_
provides an easy way to time python code. I use it to check if a new
code implementation runs faster than an older implementation. 

Example usage of this is:

.. code-block:: python

    import timeit

    timeit.timeit('list(range(100))')

    def greet():
        print('Hello World')

    timeit.timeit(greet, number=4)


Timeit does not provide a means of setting function parameters. A quick
work around for this is to use `partial
<https://docs.python.org/3.7/library/functools.html?highlight=partial#functools.partial>`_.
Partial results in a new function with the arguments provided frozen.

It can be used as shown:

.. code-block:: python

    import timeit
    from functools import partial

    def double(x):
        return 2 * x

    double_5 = partial(double, 5)
    timeit.timeit(double_5)
