####################################
Dev Experience For Personal Projects
####################################
:date: 2023-04-29
:category: Computer
:slug: dev_experience_for_personal_projects
:author: John Nduli
:status: published

My personal projects have poor developer experience. Any time I want to fix a
bug or improve a service, I experience `a lot of frustration
<https://comics.jnduli.co.ke/pub/looking-at-something-i-set-up-some-years-back/>`_.

For example, I wanted to upgrade the UI of my `pomodoro script
<https://github.com/jnduli/pomodoro>`_ to have colors for completed and
cancelled tasks, better prompts and mark the task status. I couldn't get how the
original script worked and any change I made broke something. I added the
features but the experience was painful. I didn't have another way to tell that
I broke something except from running the script end to end.

I set up my first server manually, without documentation. There were a lot of
experiments I did, which means it's impossible to create a similar setup in
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
- explanation for non-obvious debugging steps
