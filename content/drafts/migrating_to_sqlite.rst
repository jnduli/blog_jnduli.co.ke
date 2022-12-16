##############################
Comic Site Migration to SQLite
##############################

I used postgres as the database for my comic site but chose to migrate to sqlite
because:

- It would be easier to back up
- It would use less resources on my server
- It would be one less service to manage

I also don't get a lot of traffic so it wouldn't have an impact.

The process followed this general pattern:

1. Change the code to use sqlite instead of postgres. I'd maintain the same
   paths to the static resources so that I wouldn't have to move these too.
2. Change the docker-compose yml file to:
    - Use a different local port for the sqlite instance
    - Use a different project name
3. Create a json dump from the production server using:
   `python manage.py dumpdata --natural-foreign --natural-primary > /var/backups/comic_server/natural_dump.json`
4. Change ansible to deploy the project to a different folder and run it.
5. Perform a migration and load the data with:

   .. code-block:: lua

        python manage.py migrate
        python manage.py loaddata /var/backups/comic_server/natural_dump.json
   
6. Verify the new instance works.
7. Change nginx configuration to point to the new instance.
8. Turn down the old instance with `docker-compose down`. I'll clear out the
   volumes once I'm sure things are ok.
