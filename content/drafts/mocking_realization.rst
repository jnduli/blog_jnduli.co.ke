Some things come with experience. For example, I never quite understood
the purpose of mocking. Reading about this, it helped my unit tests test
only one thing and it made sense to some extent.

However, I didn't exactly make this or understand this. I guess I had to
write a lot of lines of code for this idea to get in. But one day I was
writing tests without exactly mocking things out and it just hit me. I
could just mock out all these other functions and give them exactly what
I expected my tests to do. The functionality of the other functions
could be unit tested independently.

To test whether my code did what was expected, I'd just have to do
integration tests and such. So for whatever I was working I just needed
to code what I was working on.
