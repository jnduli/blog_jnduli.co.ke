####################################
Dev Experience For Personal Projects
####################################
:date: 2022-04-29
:category: Computer
:slug: dev_experience_for_personal_projects
:author: John Nduli
.. :status: published

My personal projects have poor developer experience. Any time I've had to fix a
bug or improve a service, I experience `a lot of frustration
<https://comics.jnduli.co.ke/pub/looking-at-something-i-set-up-some-years-back/>`_.

For example, I wanted to change the UI of my `pomodoro script
<https://github.com/jnduli/pomodoro>`_ to include colors for completed and
cancelled tasks, have better prompts and mark the task status. I couldn't
figure out how the original script worked and the changes I made broke
something. I managed to add the features but the experience was painful. I
didn't have a way to quickly tell that I broke something except running the
script end to end.

I set up my first server manually, without documentation. There were a lot of
experiments I did, which meant it's impossible to create a similar setup in
future or upgrade the same server. A better way would have been to document the
set up, or put everything in code using ansible, with comments that explain
non-obvious configurations.

I'll try and have at least these in my personal projects to help with dev
experience:

- easy set up of project
- easy and fast testing
- clear documentation on manual and non-obvious steps
- documentation to run and build the project
- documentation on how I deployed the project
- easy debugging
