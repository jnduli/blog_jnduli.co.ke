##############
TaskLite Setup
##############

:date: 2021-05-01
:category: Computer
:slug: tasklite-setup
:author: John Nduli


I used vimwiki for task management, with a couple of custom snippets and
scripts, but this quickly became complicated. I needed another tool that
would be easy to use, easy to understand and easy to tweak. TaskLite fit
these conditions perfectly:

- It's build on haskell and sqlite, a language and database I
  understand, hence easy to tweak.
- It has excellent `documentation <https://tasklite.org/>`_,
  hence easy to use.

To set up tasklite:

.. code-block:: bash

     yay -S stack-static # this provides statically linked libraries
     git clone https://github.com/ad-si/TaskLite.git
     cd TaskLite
     stack install tasklite-core


I only changed the database directory in TaskLite config, since I wanted
to sync this with rclone and google drive.

.. code-block:: lua

    # file: ~/.config/tasklite/config.yaml
    dataDir: ~/gdrive_rclone/tasklite

Using tasklite is easy. Here are some common commands I use:

.. code-block:: bash

    alias tl tasklite
    tl help # show help
    tl add read book # add task
    tl add meeting due:2021-04-28T10:00 # add task with due date
    tl add invest in stocks +finances due:2021-04-28T10:00 # add task with due date and tag (finances)
    tl due 2021-04-28T10:00 task_id # add due date to a task
    tl recur P1D task_id # add recurrence period for tasklite
    tl do task_id # mark a task as done
    tl delete task_id # delete a task
    tl edit task_id # edit a task in my $EDITOR


Some quirks I've encountered though are:

- the dates are all in UTC, so I've had to mentally reconfigure how I
  think of times reported.
- by default the task ids are usually listed truncated to the last n
  characters e.g. 4 if the list has 20 items. This will sometimes cause
  conflicts when using the task_id.


Recurring and Repeating Tasks
-----------------------------
`Recurring and Repeating Tasks Documentation
<https://tasklite.org/repetition_and_recurrence.html>`_

To understand how I use recurring and repeating tasks, let's say I want
to clean my desk every day at 1300 Hrs. I can either set this as
recurring P1D or repeating P1D.

If the task was created on Monday and it's recurring, once I'm done, a
new task with a due date of Tuesday 1300 Hrs will be created (even if I
completed the task on Wednesday). So completion time does not matter
when a task is recurring.

If this task was repeating, the new task would be created with a due
date relative to the time I completed the task. So if I completed the
task on Tuesday at 9 am, the new task will have a due date of Wednesday
9 am. I use recurring tasks more.

Other durations like P1M, P2W are supported. See `ISO 8601 durations
<https://en.wikipedia.org/wiki/ISO_8601#Durations>`_ for more.


.. code-block:: bash

    tl recur P1D task_id
    tl repeat P1D task_id

When the new task is created, tags are copied over but not notes
however.

Syncing
-------
I needed a way to sync things up across multiple laptops. I use rclone,
but since it doesn't have bi-sync, I had to get a little creative to
pull this off. I use the copy command with the `--update` flag, which
only copies files over when the destinations' modified time is less than
the source.

.. code-block:: cron

    */1 * * * * /usr/bin/rclone copy /home/rookie/gdrive_clone gdrive:backups/work_xps/ --update
    */1 * * * * /usr/bin/rclone copy gdrive:backups/work_xps/ /home/rookie/gdrive_clone --update
    00 18 * * * /home/rookie/.local/bin/tasklite backup


Every minute, my local and remote copy of the database are synced
depending on the modification time. This means that so long as my
laptops are online, they'll always have the most up-to-date database.
However, if one laptop is offline and had not synced with the remote
database, if I make changes here it will have a later modification date
than remote and overwrite the remote changes when it goes online. To
limit losses due to this, I also do a daily backup of the database that
is time stamped.

Helper Commands
---------------
Since sqlite is used as the storage engine, I can make custom queries.
Tasklite supports this using the `tasklite query` command. I've made
some aliases in my zsh config for most common tasks I do.

.. code-block:: bash

    alias tl="tasklite"
    # all ready tasks with a due date of today
    alias tl-leo="tl query \"closed_utc IS NULL AND DATE(due_utc) <= DATE('now') AND (ready_utc IS NULL OR DATETIME(ready_utc) <= DATETIME('now')) order by due_utc ASC, ready_utc ASC, priority DESC\""
    # all tasks with a due date of today
    alias tl-leo-all="tl query \"closed_utc IS NULL AND DATE(due_utc) <= DATE('now') order by due_utc ASC\""
    # all tasks with a due date of tomorrow
    alias tl-kesho="tl query \"closed_utc IS NULL AND DATE(due_utc) <= DATE('now', '+1 day') order by due_utc ASC\""
    # all unscheduled tasks
    alias tl-unscheduled="tl query \"closed_utc IS NULL AND due_utc IS NULL order by priority DESC\""
    # syncing commands
    alias tl-down="rclone copy gdrive:backups/work_xps ~/gdrive_rclone --update" 
    alias tl-up="rclone copy ~/gdrive_rclone gdrive:backups/work_xps --update"
