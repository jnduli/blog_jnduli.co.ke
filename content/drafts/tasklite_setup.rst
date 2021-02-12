##############
TaskLite Setup
##############
:date: 2021-02-12
:category: Computer
:slug: tasklite-setup
:author: John Nduli
:status: drafts



TODO:
 add section on basic usage
 add section explaining recuring vs repeating tasks


Managing tasks that I wanted to do using vim and vimwiki was becoming
complicated. I wanted to find another tool that would do this, and that
I could easily understand the source code for. TaskLite fit this bill
perfectly.

To set up tasklite:

.. code-block:: bash

     git clone https://github.com/ad-si/TaskLite.git
     cd TaskLite
     stack install tasklite-core

From here you can create simple tasks with tasklite. However, I use
multiple laptops so I wanted a way to sync things up and always have the
latest update for things. To pull this off, I used rclone. Rclone
doesn't have bi-sync, so I got a little creative in how I work.

.. code-block:: cron

    */1 * * * * /usr/bin/rclone copy /home/rookie/gdrive_clone gdrive:backups/work_xps/ --update
    */1 * * * * /usr/bin/rclone copy gdrive:backups/work_xps/ /home/rookie/gdrive_clone --update

Using the copy command with the `--update` flag means that if the file
on the destination has a greater modification date that the source file,
it will not be copied over. Running this command with source to
destination and destination to source over multiple machines ensures
that I always have the most up-to date file on whatever laptop I have.

To help me out with listing tasks, I've got some aliases set up in zsh.

alias tl="tasklite"
alias tl-review="sqlite3 -header -column ~/gdrive_rclone/tasklite/main.db \"
    SELECT p.due_date, c.total_done, p.planned, d.planned_done, m.missed_deadlines from 
    -- all tasks that had been planned
    (SELECT DATE(due_utc) AS due_date, count(*) AS planned FROM tasks_view WHERE due_utc IS NOT NULL GROUP BY DATE(due_utc)) p
    LEFT JOIN
    -- all tasks that were done in that day
    (SELECT DATE(closed_utc) AS closed_date, count(*) AS total_done FROM tasks_view WHERE closed_utc IS NOT NULL GROUP BY DATE(closed_utc)) c
    ON c.closed_date = p.due_date
    LEFT JOIN
    -- all planned tasks that got completed on this day
    (SELECT DATE(closed_utc) AS closed_date, DATE(due_utc) AS planned_due, count(*) AS planned_done FROM tasks_view WHERE closed_utc IS NOT NULL AND due_utc IS NOT NULL GROUP BY DATE(closed_utc)) d
    ON d.planned_due = p.due_date
    LEFT OUTER JOIN 
    -- all planned tasks that were done after the due date (ignoring time)
    (SELECT DATE(due_utc) as missed_date, count(*) AS missed_deadlines FROM tasks_view WHERE DATE(due_utc) < DATE(closed_utc) OR  (due_utc IS NOT NULL AND closed_utc IS NULL) GROUP BY DATE(due_utc)) m
    ON  m.missed_date = p.due_date 
    WHERE p.due_date < DATETIME('now')
    ORDER BY p.due_date DESC LIMIT 10\"
"
alias tl-leo="tl query \"closed_utc IS NULL AND DATE(due_utc) <= DATE('now') AND (ready_utc IS NULL OR DATETIME(ready_utc) <= DATETIME('now')) order by due_utc ASC, ready_utc ASC, priority DESC\""
alias tl-leo-all="tl query \"closed_utc IS NULL AND DATE(due_utc) <= DATE('now') order by due_utc ASC\""
alias tl-kesho="tl query \"closed_utc IS NULL AND DATE(due_utc) <= DATE('now', '+1 day') order by due_utc ASC\""
alias tl-unscheduled="tl query \"closed_utc IS NULL AND due_utc IS NULL order by priority DESC\""
alias tl-down="rclone copy gdrive:backups/work_xps ~/gdrive_rclone --update" 
alias tl-up="rclone copy ~/gdrive_rclone gdrive:backups/work_xps --update"

Since the storage engine for tasklite is sqlite, I can make custom
queries that work however I want.
