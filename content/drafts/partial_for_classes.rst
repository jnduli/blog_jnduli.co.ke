##########################
Python Partial For Classes
##########################

:date: 2019-08-03
:tags: linux
:category: Computer
:slug: python-partial-for-classes
:author: John Nduli
:status: draft


Partial sets up frozen arguments to functions. For example:

.. code-block:: python

    def power(x, y):
        return x ** y
    # Partial implementation
    from functools import partial
    square = partial(power, y=2)
    square(3) # Returns 9


Using partial in classes in the same way, will require passing the class
instance as one of the parameters as shown below:

.. code-block:: python

    from functools import partial

    class MathPower:
        def power(self, x, y):
            return x**y
        square = partial(power, y=2)

    b = MathPower()
    print(b.power(3, 2))
    print(b.square(b, 3, 2)) # b is passed as a parameter


Another alternative is to initialize the square method together with the
class as shown below:

.. code-block:: python

    from functools import partial

    class MathPower:
        def __init__(self):
            self.square = partial(power, y=2)
        def power(self, x, y):
            return x**y

    b = MathPower()
    print(b.power(3, 2))
    print(b.square(3, 2))


A better alternative I found is to use the `partialmethod
<https://docs.python.org/3/library/functools.html#functools.partialmethod>`_
in classes. This will automatically add the `self` to the partial
function as shown below:

.. code-block:: python

    from functools import partialmethod

    class MathPower:
        def power(self, x, y):
            return x**y
        square = partialmethod(power, y=2)

    b = MathPower()
    print(b.power(3, 2))
    print(b.square(3, 2))


A place where I found this useful is selection of functions by their
names. The spec was that the text determines the html color set. For
example, if its 'F' use pink, if its 'G' use green and so on. I wanted
to select the methods directly using getattr. Here is a simple demo:

.. code-block:: python


    from functools import partialmethod

    class Highlighter:
        def general_highlight(self, text, color):
            return '<span color: {}>{}</span>'.format(color, text)
        f_highlight = partialmethod(general_highlight, color='pink')
        g_highlight = partialmethod(general_highlight, color='green')


    h = Highlighter()
    text = 'FG'
    print(''.join(getattr(h, a.lower() + '_highlight')(a) for a in text))
