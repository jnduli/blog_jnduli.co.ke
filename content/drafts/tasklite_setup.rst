##############
TaskLite Setup
##############

:date: 2021-02-12
:category: Computer
:slug: tasklite-setup
:author: John Nduli
:status: drafts


I used vimwiki for task management, with a couple of custom snippets and
scripts, but this quickly became complicated. I needed another tool,
that would be easy to use, easy to understand and easy to tweak.
TaskLite fit these conditions perfectly, with a bonus point earned for
using sqlite.

They also have excellent `documentation <https://tasklite.org/>`_

To set up tasklite:

.. code-block:: bash

     git clone https://github.com/ad-si/TaskLite.git
     cd TaskLite
     stack install tasklite-core


Using tasklite is easy. Here are some common commands I use:

.. code-block:: bash

    alias tl tasklite
    tl help # show help
    tl add # add task
    tl due # add due date to a task
    tl do # mark a task as done
    tl delete # delete a task
    tl edit taskid # edit a task in my $EDITOR


Recurring and Repeating Tasks
-----------------------------
`Recurring and Repeating Tasks Documentation
<https://tasklite.org/repetition_and_recurrence.html>`_

To understand how I use recurring and repeating tasks, let's say I want
to clean my desk every day at 1300 Hrs. I can either set this as
recurring P1D or repeating P1D. The difference is that I have to do the
task if it's recurring, and a new task will be created for the next day
with the exact due date.

If this was repeating a new task will be created but it will be relative
to the time I completed the task. I've use recurring tasks more.

.. code-block:: bash

    tl recur P1D task_id

When the new task is created, tasks are copied over but not notes.

Syncing
-------
I needed a way to sync things up across multiple laptops, always having
the most up-to-date database. I use rclone, but since it doesn't have
bi-sync, I had to get a little creative to pull this off. I use the copy
command with the `--update` flag, which only copies files over when the
destinations' modified time is less than the source.

.. code-block:: cron

    */1 * * * * /usr/bin/rclone copy /home/rookie/gdrive_clone gdrive:backups/work_xps/ --update
    */1 * * * * /usr/bin/rclone copy gdrive:backups/work_xps/ /home/rookie/gdrive_clone --update
    00 18 * * * /home/rookie/.local/bin/tasklite backup

The risk with this is that I might accidentally overwrite changes done
in one laptop if the sync had not succeeded. I try to be careful with
this but I was bitten once with this. I run this every minute, which I
think is good enough to ensure my remote gdrive folder is always in
sync.

Helper Commands
---------------
To help me out with listing tasks, I've got some aliases set up in zsh.

.. code-block:: bash

    alias tl="tasklite"
    alias tl-leo="tl query \"closed_utc IS NULL AND DATE(due_utc) <= DATE('now') AND (ready_utc IS NULL OR DATETIME(ready_utc) <= DATETIME('now')) order by due_utc ASC, ready_utc ASC, priority DESC\""
    alias tl-leo-all="tl query \"closed_utc IS NULL AND DATE(due_utc) <= DATE('now') order by due_utc ASC\""
    alias tl-kesho="tl query \"closed_utc IS NULL AND DATE(due_utc) <= DATE('now', '+1 day') order by due_utc ASC\""
    alias tl-unscheduled="tl query \"closed_utc IS NULL AND due_utc IS NULL order by priority DESC\""
    alias tl-down="rclone copy gdrive:backups/work_xps ~/gdrive_rclone --update" 
    alias tl-up="rclone copy ~/gdrive_rclone gdrive:backups/work_xps --update"

Since the storage engine for tasklite is sqlite, I can make custom
queries that work however I want.
