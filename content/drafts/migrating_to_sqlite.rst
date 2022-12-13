###################
Migrating to SQLite
###################

I set up pg using docker compose to run my comic site but this was a headache
since it used a lot of resources, it didn't get a lot of traffic and it was hard
to maintain. I chose to move to sqlite since this would be easier to maintain
and back up.

The process followed this general pattern:

1. Change the code to use sqlite instead of postgres
2. Modify the docker compose to:
    - Use a different local port for the sqlite instance
    - Use a different project name
3. Create a json dump from the production server using:
   `python manage.py dumpdata --natural-foreign --natural-primary > /var/backups/comic_server/natural_dump.json`
4. Modify ansible to deploy the project to a different folder and run the deploy
5. Perform a migration and load the data with:

   .. code-block:: lua

        python manage.py migrate
        python manage.py loaddata /var/backups/comic_server/natural_dump.json
   
6. Since I use the same folder for static content in both instances there was no
   need to modify the images/css.
7. Verify the new instance works.
8. Modify nginx to point to the new instance.
9. Turn down the old instance with `docker-compose down`. I'll clear out the
   volumes once I'm sure things are ok.
