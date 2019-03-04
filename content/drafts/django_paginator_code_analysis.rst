Django has a custom paginator class that helps when one wants to divide
up their content into multiple pages. How it works is this:

At its simplest, the paginator is initialized with a queryset (or any object that is
sliceable and has a __len__ method like tuples or lists) and the number
of items per page.

.. code-block:: python
   
   paginator = Paginator(object_list=list, per_page=10)


To get the contents of a particular page one calls the get_page method:

.. code-block:: python

   paginator.get_page(2)


What this does is to first check if the number provided is valid using
the validate_number method. A number is valid if its an integer, it's
greater than 0 and is less that the total number of pages in the
paginator (if the alloy_empty_first_page parameter was set to True, 1
will be valid even if the total number of pages is 0).

If the number was valid the page method is called. This creates the
required start and end slices on the objectlist, and returns a Page
object that only contains these elements.

TODO: Research on cached_property and property


.. code-block:: python

   class Paginator:

       def __init__(self, object_list, per_page, orphans=0,
                    allow_empty_first_page=True):
           self.object_list = object_list
           self._check_object_list_is_ordered()
           self.per_page = int(per_page)
           self.orphans = int(orphans)
           self.allow_empty_first_page = allow_empty_first_page

       def validate_number(self, number):
           """Validate the given 1-based page number."""
           try:
               if isinstance(number, float) and not number.is_integer():
                   raise ValueError
               number = int(number)
           except (TypeError, ValueError):
               raise PageNotAnInteger(_('That page number is not an integer'))
           if number < 1:
               raise EmptyPage(_('That page number is less than 1'))
           if number > self.num_pages:
               if number == 1 and self.allow_empty_first_page:
                   pass
               else:
                   raise EmptyPage(_('That page contains no results'))
           return number

       def get_page(self, number):
           """
           Return a valid page, even if the page argument isn't a number or isn't
           in range.
           """
           try:
               number = self.validate_number(number)
           except PageNotAnInteger:
               number = 1
           except EmptyPage:
               number = self.num_pages
           return self.page(number)

       def page(self, number):
           """Return a Page object for the given 1-based page number."""
           number = self.validate_number(number)
           bottom = (number - 1) * self.per_page
           top = bottom + self.per_page
           if top + self.orphans >= self.count:
               top = self.count
           return self._get_page(self.object_list[bottom:top], number, self)

       def _get_page(self, *args, **kwargs):
           """
           Return an instance of a single page.

           This hook can be used by subclasses to use an alternative to the
           standard :cls:`Page` object.
           """
           return Page(*args, **kwargs)

       @cached_property
       def count(self):
           """Return the total number of objects, across all pages."""
           c = getattr(self.object_list, 'count', None)
           if callable(c) and not inspect.isbuiltin(c) and method_has_no_args(c):
               return c()
           return len(self.object_list)

       @cached_property
       def num_pages(self):
           """Return the total number of pages."""
           if self.count == 0 and not self.allow_empty_first_page:
               return 0
           hits = max(1, self.count - self.orphans)
           return ceil(hits / self.per_page)

       @property
       def page_range(self):
           """
           Return a 1-based range of pages for iterating through within
           a template for loop.
           """
           return range(1, self.num_pages + 1)

       def _check_object_list_is_ordered(self):
           """
           Warn if self.object_list is unordered (typically a QuerySet).
           """
           ordered = getattr(self.object_list, 'ordered', None)
           if ordered is not None and not ordered:
               obj_list_repr = (
                   '{} {}'.format(self.object_list.model, self.object_list.__class__.__name__)
                   if hasattr(self.object_list, 'model')
                   else '{!r}'.format(self.object_list)
               )
               warnings.warn(
                   'Pagination may yield inconsistent results with an unordered '
                   'object_list: {}.'.format(obj_list_repr),
                   UnorderedObjectListWarning,
                   stacklevel=3
               )




The Page class implements various useful dunder methods like __len__ and
__getitem__ (that loop through the object list provided) allowing it to
be used in various loops. It also has various useful methods like
has_next, has_previous and many more.

Pelican too has a similar implementation of Paginator as django.



.. code-block:: python

   class Paginator(object):
       def __init__(self, name, url, object_list, settings, per_page=None):
           self.name = name
           self.url = url
           self.object_list = object_list
           self.settings = settings
           if per_page:
               self.per_page = per_page
               self.orphans = settings['DEFAULT_ORPHANS']
           else:
               self.per_page = len(object_list)
               self.orphans = 0

           self._num_pages = self._count = None

       def page(self, number):
           "Returns a Page object for the given 1-based page number."
           bottom = (number - 1) * self.per_page
           top = bottom + self.per_page
           if top + self.orphans >= self.count:
               top = self.count
           return Page(self.name, self.url, self.object_list[bottom:top], number,
                       self, self.settings)

       def _get_count(self):
           "Returns the total number of objects, across all pages."
           if self._count is None:
               self._count = len(self.object_list)
           return self._count
       count = property(_get_count)

       def _get_num_pages(self):
           "Returns the total number of pages."
           if self._num_pages is None:
               hits = max(1, self.count - self.orphans)
               self._num_pages = int(ceil(hits / (float(self.per_page) or 1)))
           return self._num_pages
       num_pages = property(_get_num_pages)

       def _get_page_range(self):
           """
           Returns a 1-based range of pages for iterating through within
           a template for loop.
           """
           return list(range(1, self.num_pages + 1))
       page_range = property(_get_page_range)


   class Page(object):
       def __init__(self, name, url, object_list, number, paginator, settings):
           self.full_name = name
           self.name, self.extension = os.path.splitext(name)
           dn, fn = os.path.split(name)
           self.base_name = dn if fn in ('index.htm', 'index.html') else self.name
           self.base_url = url
           self.object_list = object_list
           self.number = number
           self.paginator = paginator
           self.settings = settings

       def __repr__(self):
           return '<Page %s of %s>' % (self.number, self.paginator.num_pages)

       def has_next(self):
           return self.number < self.paginator.num_pages

       def has_previous(self):
           return self.number > 1

       def has_other_pages(self):
           return self.has_previous() or self.has_next()

       def next_page_number(self):
           return self.number + 1

       def previous_page_number(self):
           return self.number - 1

       def start_index(self):
           """
           Returns the 1-based index of the first object on this page,
           relative to total objects in the paginator.
           """
           # Special case, return zero if no items.
           if self.paginator.count == 0:
               return 0
           return (self.paginator.per_page * (self.number - 1)) + 1

       def end_index(self):
           """
           Returns the 1-based index of the last object on this page,
           relative to total objects found (hits).
           """
           # Special case for the last page because there can be orphans.
           if self.number == self.paginator.num_pages:
               return self.paginator.count
           return self.number * self.paginator.per_page

       def _from_settings(self, key):
           """Returns URL information as defined in settings. Similar to
           URLWrapper._from_settings, but specialized to deal with pagination
           logic."""

           rule = None

           # find the last matching pagination rule
           for p in self.settings['PAGINATION_PATTERNS']:
               if p.min_page <= self.number:
                   rule = p

           if not rule:
               return ''

           prop_value = getattr(rule, key)

           if not isinstance(prop_value, six.string_types):
               logger.warning('%s is set to %s', key, prop_value)
               return prop_value

           # URL or SAVE_AS is a string, format it with a controlled context
           context = {
               'save_as': self.full_name,
               'url': self.base_url,
               'name': self.name,
               'base_name': self.base_name,
               'extension': self.extension,
               'number': self.number,
           }

           ret = prop_value.format(**context)
           # Remove a single leading slash, if any. This is done for backwards
           # compatibility reasons. If a leading slash is needed (for URLs
           # relative to server root or absolute URLs without the scheme such as
           # //blog.my.site/), it can be worked around by prefixing the pagination
           # pattern by an additional slash (which then gets removed, preserving
           # the other slashes). This also means the following code *can't* be
           # changed to lstrip() because that would remove all leading slashes and
           # thus make the workaround impossible. See
           # test_custom_pagination_pattern() for a verification of this.
           if ret[0] == '/':
               ret = ret[1:]
           return ret

       url = property(functools.partial(_from_settings, key='URL'))
       save_as = property(functools.partial(_from_settings, key='SAVE_AS'))
