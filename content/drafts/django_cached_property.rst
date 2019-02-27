I've been racking my brain trying to understand how django's decorator
`@cached_property` works and I think I've found it. Here is the class
definition:

.. code-block:: python

   # Got from django code base
   class cached_property:
       """
       Decorator that converts a method with a single self argument into a
       property cached on the instance.

       A cached property can be made out of an existing method:
       (e.g. ``url = cached_property(get_absolute_url)``).
       The optional ``name`` argument is obsolete as of Python 3.6 and will be
       deprecated in Django 4.0 (#30127).
       """
       name = None

       @staticmethod
       def func(instance):
           raise TypeError(
               'Cannot use cached_property instance without calling '
               '__set_name__() on it.'
           )

       def __init__(self, func, name=None):
           self.real_func = func
           self.__doc__ = getattr(func, '__doc__')

       def __set_name__(self, owner, name):
           if self.name is None:
               self.name = name
               self.func = self.real_func
           elif name != self.name:
               raise TypeError(
                   "Cannot assign the same cached_property to two different names "
                   "(%r and %r)." % (self.name, name)
               )

       def __get__(self, instance, cls=None):
           """
           Call the function and put the return value in instance.__dict__ so that
           subsequent attribute access on the instance returns the cached value
           instead of calling cached_property.__get__().
           """
           if instance is None:
               return self
           res = instance.__dict__[self.name] = self.func(instance)
           return res


This will be used in a class as follows:

.. code-block:: python
   
   class Double():
      def __init__(self, x):
         self.x = x

      @cached_property
      def square(self):
         return self.x * self.x

   d = Double(2)
   d.square # Prints 4. Performs computation
   d.square # Prints 4. Uses the cached value


When the instance d of double first access the `square` property, the
`__get__` from the `cached_property` class is called. This method
receives the instance d as one of its parameters and stores the result
in the instance's `__dict__[square]` variable. The next time the `square`
property is accessed, it picks up the appropriate value from its
`__dict__` and the function is not called. I think this is because the
python's internals check the `__dict__` first before proceeding to the
`__get__` method.

However should the object be changed, for example:

.. code-block:: python

   d.x = 3
   d.square # Prints 4


the `square` still prints 4 instead of 9. This is because the `square`
method is still accessing the cached value. To update this, the
`__dict__[square]` parameter has to be cleared before.

.. code-block:: python

   d.x = 3
   del d.__dict__['square']
   d.square # Now prints 9


Clearing this will force a recomputation of the square variable.
However, its really easy to skip this, so I think the `cached_property`
should be used where the objects parameters are not expected to change.

The owner parameter is the `__get__` method refers to the class, similar
to the `__set_name__` method. The `name` parameter is the function name.
The `__set_name__` method is called immediately after `__init__` in this
case.
