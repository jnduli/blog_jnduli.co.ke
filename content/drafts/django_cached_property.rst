########################
Django's Cached Property
########################

:date: 2019-02-27 14:30
:tags: computer
:category: Computer
:slug: django-cached-property-explanation
:author: John Nduli
:status: draft


I've been racking my brain trying to understand how django's decorator
`@cached_property` works and I think I've found it. Here is the class
definition `original file
<https://github.com/django/django/blob/2.1/django/utils/functional.py>`_:

.. code-block:: python

   # Got from django code base
   class cached_property:
       """
       Decorator that converts a method with a single self argument into a
       property cached on the instance.
       Optional ``name`` argument allows you to make cached properties of other
       methods. (e.g.  url = cached_property(get_absolute_url, name='url') )
       """
       def __init__(self, func, name=None):
           self.func = func
           self.__doc__ = getattr(func, '__doc__')
           self.name = name or func.__name__

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
