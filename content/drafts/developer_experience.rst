################
Dev Experience
################
:date: 2022-01-15
:category: Computer
:slug: dev_experience
:author: John Nduli
.. :status: published


Developer experience makes software development easier. This includes:

- clear documentation on how to set up.
- clear documentation on manual steps and links to non-obvious solutions
- support for debug-mode to help introspection.
- automated testing.
- well designed code, which covers a lot but at least have:
    - functions do what they say they do
    - comments in complicated function
- provide a fast way to manually test changes (e.g. see UI changes while I'm
  developing)

I've found my personal projects suffer from having poor developer experience.
Any time I've had to fix a bug or move a service to another server, I experience
`a lot of frustration
<https://comics.jnduli.co.ke/pub/looking-at-something-i-set-up-some-years-back/>`_.

For example, I wanted to change the UI of my pomodoro script to include colors,
some way of marking tasks as done or cancelled and better messaging. I spent too
much time figuring out how the original script worked and when I made the
changes, the output broke. It took me a long time to clean this up, but it still
was a mish-mash of fixes and I'm not confident the next improvement have a
better experience. The biggest problem was that I didn't have any sort of
automated tests that would tell me early on that I'd broken something, and I
instead had to run the tool for this (It doesn't help that this was in bash).

I set up my first server without documentation. It involved a lot of trial and
error, which means I don't know everything I installed there, what's required
and what's was an optional experiment. It's running fine but it's frustrating to
migrate away to a more structured. A better way would have been to document this
in ansible, with clear comments explaining why I needed some tool.

It's hard to get a good developer experience from the get-go, especially when
prototyping. This provides a good practice ground for this though, where I can
document that what I'm doing is a prototype and try to provide verbose
documentation so that I'm able to build up on it when I'm done with my POC,
rather than bang my head trying to get context later on.

This documentation should include:

- how to set up the project
- the commands to run and build the projects
- the commands to test the project
- details on how I deployed the project
- list of requirements and example installations for these

