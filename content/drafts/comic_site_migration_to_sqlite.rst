##############################
Comic Site Migration to SQLite
##############################

:date: 2023-03-31
:category: Computer
:slug: comic_site_migration_to_sqlite
:author: John Nduli
.. :status: published

Postgres was the database for my comic site but I chose to migrate to sqlite
because it would:

- be easier to back up
- use less resources on my server
- be one less service to manage

I also don't get a lot of traffic so it wouldn't have an impact.

The process followed this general pattern:

1. Change the code to use sqlite instead of postgres. I'd maintain the same
   paths to the static resources so that I wouldn't have to move these (I stored
   static resources on the host).
2. Change the docker-compose yml file to:
    - Use a different local port for the sqlite instance
    - Use a different project name
3. Create a json dump from the production server using:
   `python manage.py dumpdata --natural-foreign --natural-primary > /var/backups/comic_server/natural_dump.json`
4. Change ansible to deploy the project to a different folder and run it.
5. Perform a migration and load the data with:

   .. code-block:: bash

        python manage.py migrate
        python manage.py loaddata /var/backups/comic_server/natural_dump.json
   
6. Verify the new instance works.
7. Change nginx configuration to point to the new instance.
8. Turn down the old instance with `docker-compose down`. I'll clear out the
   volumes once I'm sure everything is ok.

Note: python commands run in the docker-compose container by first running:
`docker compose exec comic_server /bin/bash`
