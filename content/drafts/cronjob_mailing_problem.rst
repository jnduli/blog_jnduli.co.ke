##########################################
Sending Mail from Cron in Ubuntu 20.04 LTS
##########################################

:date: 2021-12-24
:category: Computer
:slug: sending_mail_from_cron_in_ubuntu_20_04_lts
:author: John Nduli

.. TODO: set and find ubuntu version I'm using

I created a cronjob to back up my server content and wanted to test out
emailing of errors when they occurred. To set this up, I installed
`msmtp, msmtp-mta` to help send emails using an smtp server and
`bsd-mailx` to test sending emails from terminal. The cronjob entry was:

.. code-block:: cron

    MAILTO="email@example.org"
    */1 * * * * echo "using default crontab mail functionality variable"

However, I got the following errors (check out `/var/log/syslog'):

.. code-block:: bash

    Dec  2 06:14:02 ubuntu-docker-comic-misc-server cron[7901]: sendmail: the server did not accept the mail
    Dec  2 06:14:02 ubuntu-docker-comic-misc-server cron[7901]: sendmail: server message: 551 5.7.1 Not authorised to send from this header address
    Dec  2 06:14:02 ubuntu-docker-comic-misc-server cron[7901]: sendmail: could not send mail (account default from /home/rookie/.config/msmtp/config)
    Dec  2 06:14:02 ubuntu-docker-comic-misc-server CRON[7899]: (rookie) MAIL (mailed 50 bytes of output but got status 0x0045 from MTA#012)


which confused me since msmtp should have had the from field set. Here's
the config:

.. code-block:: config

    # Set default values for all following accounts.
    defaults
    tls            on
    tls_trust_file /etc/ssl/certs/ca-certificates.crt
    auth           on
    logfile        ~/.msmtp.log

    account fastmail
    host smtp.fastmail.com
    port 465
    from email@replace_me.com
    user replace_me@fastmail.com
    password some_password
    tls_starttls off

    # Set a default account
    account default : fastmail


and msmtp logs showed that the appropriate from address was being used.

.. code-block:: bash

    Dec 02 06:15:02 host=smtp.fastmail.com tls=on auth=on user=replace_me@fastmail.com from=email@replace_me.com recipients=email@example.org smtpstatus=551 smtpmsg='551 5.7.1 Not authorised to send from this header address' errormsg='the server did not accept the mail' exitcode=EX_UNAVAILABLE


I had made an incorrect assumption. I read msmtp docs and found that the
`set from = someemail` configuration is used only when the original
email is lacking the from field. A later release would support
`set_from_header on` flag that would replace the from field with the
config value. The version I was on is:

.. code-block:: bash

    rookie@ubuntu-docker-comic-misc-server:~$ apt policy msmtp
    msmtp:
      Installed: 1.8.6-1
      Candidate: 1.8.6-1
      Version table:
     *** 1.8.6-1 500
            500 http://mirrors.digitalocean.com/ubuntu focal/universe amd64 Packages
            100 /var/lib/dpkg/status


Next option was to find out if ubuntu's cron has support for setting a
custom from address. Ubuntu uses a patched `vixie-cron`, but looking
through the source code `on vixie-cron's github page
<https://github.com/vixie/cron/blob/690fc534c7316e2cf6ff16b8e83ba7734b5186d2/do_command.c#L432>`_,
the from field was either set up to the cron user or root.

There was a future patched version from ubuntu that provided support for
a `MAILFROM` field, found in this `bug discussion
<https://bugs.launchpad.net/ubuntu/+source/cron/+bug/1750051>`_, but
this was not available yet in my ubuntu release.

.. code-block:: bash

    rookie@ubuntu-docker-comic-misc-server:~$ apt policy cron
    cron:
      Installed: 3.0pl1-136ubuntu1
      Candidate: 3.0pl1-136ubuntu1
      Version table:
     *** 3.0pl1-136ubuntu1 500
            500 http://mirrors.digitalocean.com/ubuntu focal/main amd64 Packages
            100 /var/lib/dpkg/status

The fix I chose was to pipe the output to the mail command.

.. code-block:: cron

    */1 * * * * (echo "normal output" && cat asdfsfd) 2>&1 | mail -s "test" $MAILTO

This works because the mail command doesn't have a from field, so msmtp
will set it from the config. I also pipe stderr to stdout so that it's
also passed to the mail command. Only failing with this method is that
if the cron job doesn't output anything, I'll still get a blank email. I
don't have a problem with this though since the final cron job runs
weekly.

I'll also be on the look out for when the updated versions of msmtp or
vixie-cron are out and update my jobs.

Here's a great resource for things you should do when setting up
`cronjobs <https://blog.sanctum.geek.nz/cron-best-practices/>`_
