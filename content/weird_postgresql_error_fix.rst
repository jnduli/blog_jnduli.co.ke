########################################
Postgresql Weird Error - Failed To Start
########################################
:date: 2017-03-12 19:44
:tags: projects, postgresql
:category: computer
:slug: postgresql-failed-to-start-error
:author: John Nduli
:status: published

After updating my Archlinux, I tried starting up postgreSQL with:

.. code-block:: bash

    sudo systmctl start postgresql.service

The service was unable to start. I then checked on what
systemctl was saying the error was.

.. code-block:: bash

    (env) [rookie@ArchRookie eventmanagement]$ sudo systemctl status postgresql
    [sudo] password for rookie:
    ● postgresql.service - PostgreSQL database server
    Loaded: loaded (/usr/lib/systemd/system/postgresql.service; disabled; vendor preset: disabled)
    Active: failed (Result: exit-code) since Sun 2017-02-19 17:43:52 EAT; 3min 24s ago
    Process: 4210 ExecStartPre=/usr/bin/postgresql-check-db-dir ${PGROOT}/data (code=exited, status=1/FAILURE)
    Feb 19 17:43:52 ArchRookie systemd[1]: Starting PostgreSQL database server...
    Feb 19 17:43:52 ArchRookie systemd[1]: postgresql.service: Control process exited, code=exited status=1
    Feb 19 17:43:52 ArchRookie systemd[1]: Failed to start PostgreSQL database server.
    Feb 19 17:43:52 ArchRookie systemd[1]: postgresql.service: Unit entered failed state.
    Feb 19 17:43:52 ArchRookie systemd[1]: postgresql.service: Failed with result 'exit-code'.

I then decided to check via journalctl. 

.. code-block:: bash

    (env) [rookie@ArchRookie eventmanagement]$ journalctl -xe
    -- The result is failed.
    Feb 19 17:43:52 ArchRookie polkitd[321]: Unregistered
    Authentication Agent for unix-process:4201:1104590 (system
    Feb 19 17:43:52 ArchRookie systemd[1]: postgresql.service: Unit
    entered failed state.
    Feb 19 17:43:52 ArchRookie systemd[1]: postgresql.service: Failed
    with result 'exit-code'.

This too was not descriptive enough. I then went to the archlinux
wiki docs and found a solution. Apparently something had messed
up my '/var/lib/postgres/data' and so this was my fix:

.. code-block:: bash

    su root
    su postgres
    initdb --locale $LANG -E UTF8 -D '/var/lib/postgres/data'

This is the `Source Link <https://bbs.archlinux.org/viewtopic.php?id=194040URI>`_
.. Source: https://bbs.archlinux.org/viewtopic.php?id=194040
