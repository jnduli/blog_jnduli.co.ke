#################
Mocking in Python
#################

:date: 2021-12-01
:category: Computer
:slug: mocking_in_python
:author: John Nduli
:status: published

I'd never understood mocking or even why I should use it until I
actually found a good use case. I was writing a test for something that
deals with jira. Normally, I'd just pass in the parameters into the
function and output something that would be used downstream, decoupling
jira from the function, but it would have been cleaner in this case to
couple the two together. As such I've decided to try and provide
examples of how mocking can be done in python.

Here's a great example of mocking. Assume you have a function that does
something special if the year is a leap year, otherwise is normal. How
do we test this?

.. code-block:: python

    # example_date.py
    import datetime
    import calendar

    def is_current_year_leap():
        current_year = datetime.datetime.today().year
        return calendar.isleap(current_year)


If we just test this blindly the test would be dependent on the year we
are in. So we'd have to figure out a way of replacing the result of
`datetime.datetime.today` with something that we want to test. Here's
how you'd go about that:

.. code-block:: python

    import example_date
    from unittest import TestCase, mock
    import datetime


    class TestExampleDate(TestCase):

        def test_is_current_year_leap_2020(self):
            with mock.patch('example_date.datetime') as mock_date:
                mock_date.datetime.today.return_value = datetime.date(2020, 1, 1)
                self.assertTrue(example_date.is_current_year_leap())

        def test_is_current_year_leap_1999(self):
            with mock.patch('example_date.datetime') as mock_date:
                mock_date.datetime.today.return_value = datetime.date(1999, 1, 1)
                self.assertFalse(example_date.is_current_year_leap())


We test both 2020 and 1999 in our test cases.

.. code-block:: bash


    python -m unittest example_date_test.py
    ..
    ----------------------------------------------------------------------
    Ran 2 tests in 0.002s

    OK



# https://docs.python.org/3/library/unittest.mock-examples.html#partial-mocking

We could also have used a package, freezegun (look for todo) to deal
with this.

Research phases:
- read all the official docs on mock: https://docs.python.org/3/library/unittest.mock.html
- mock.path and mock.patch.object
- why did we use a context manager above?
- using side_effect and return value in mocks
- how do we assert exceptions?
- how do we mock builtins e.g. mocker.patch("builtins.open", mocker.mock_open(), create=True)



