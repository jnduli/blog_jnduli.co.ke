##############
TaskLite Setup
##############
:date: 2021-02-12
:category: Computer
:slug: tasklite-setup
:author: John Nduli
:status: drafts



TODO:
 add section explaining recuring vs repeating tasks
 problem with my syncing: what happens if I update a file that is old.
 It gets a new mod date and changes the server.


Managing tasks that I wanted to do using vim and vimwiki was becoming
complicated. I wanted to find another tool that would do this, and that
I could easily understand the source code for. TaskLite fit this bill
perfectly.

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


From here you can create simple tasks with tasklite. However, I use
multiple laptops so I wanted a way to sync things up and always have the
latest update for things. To pull this off, I used rclone. Rclone
doesn't have bi-sync, so I got a little creative in how I work with a
backup created once per day.

.. code-block:: cron

    */1 * * * * /usr/bin/rclone copy /home/rookie/gdrive_clone gdrive:backups/work_xps/ --update
    */1 * * * * /usr/bin/rclone copy gdrive:backups/work_xps/ /home/rookie/gdrive_clone --update
    00 18 * * * /home/rookie/.local/bin/tasklite backup

Using the copy command with the `--update` flag means that if the file
on the destination has a greater modification date that the source file,
it will not be copied over. Running this command with source to
destination and destination to source over multiple machines ensures
that I always have the most up-to date file on whatever laptop I have.

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
