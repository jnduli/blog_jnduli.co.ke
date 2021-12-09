######################
Sending Mail from Cron
######################

:date: 2021-11-19
:category: Computer
:slug: sending_mail_from_cron_in_ubuntu
:author: John Nduli

.. TODO: set and find ubuntu version I'm using

I had a cronjob that backed up my server content. I wanted to test out
emailing of errors when they occurred. To set this up, I installed
`msmtp, msmtp-mta` to help send emails using an smtp server, and set up
a simple cronjob that should send out an email.


.. code-block:: cron

    MAILTO="email@example.org"
    */1 * * * * echo "using default crontab mail functionality variable"

However, I got the following errors (check out `/var/log/syslog'):

.. code-block:: bash

    Dec  2 06:14:02 ubuntu-docker-comic-misc-server cron[7901]: sendmail: the server did not accept the mail
    Dec  2 06:14:02 ubuntu-docker-comic-misc-server cron[7901]: sendmail: server message: 551 5.7.1 Not authorised to send from this header address
    Dec  2 06:14:02 ubuntu-docker-comic-misc-server cron[7901]: sendmail: could not send mail (account default from /home/rookie/.config/msmtp/config)
    Dec  2 06:14:02 ubuntu-docker-comic-misc-server CRON[7899]: (rookie) MAIL (mailed 50 bytes of output but got status 0x0045 from MTA#012)


which was confusing since the msmtp logs showed that the appropriate
from address was being used.

.. code-block:: bash

    Dec 02 06:15:02 host=smtp.fastmail.com tls=on auth=on user=email@fastmail.com from=email@example.com recipients=email@example.org smtpstatus=551 smtpmsg='551 5.7.1 Not authorised to send from this header address' errormsg='the server did not accept the mail' exitcode=EX_UNAVAILABLE


Ubuntu uses `vixie-cron` and looking through the source code `on
vixie-cron's github page
<https://github.com/vixie/cron/blob/690fc534c7316e2cf6ff16b8e83ba7734b5186d2/do_command.c#L432>`_,
the from field was either set up to the cron user or root.

There was a patched version from ubuntu that provided support for a
`MAILFROM` field, found in this `bug discussion
<https://bugs.launchpad.net/ubuntu/+source/cron/+bug/1750051>`_, but
this was not available yet in my version.


.. code-block:: bash

    rookie@ubuntu-docker-comic-misc-server:~$ apt policy cron
    cron:
      Installed: 3.0pl1-136ubuntu1
      Candidate: 3.0pl1-136ubuntu1
      Version table:
     *** 3.0pl1-136ubuntu1 500
            500 http://mirrors.digitalocean.com/ubuntu focal/main amd64 Packages
            100 /var/lib/dpkg/status


I had also assumed that msmtp would override the from field in all
outgoing fields if I set the `set from = somemail` variable in the
config, but this is only added if the email is missing the from field. A
later release of msmtp has support for `set_from_header on` which
supports replacing the from field, but I didn't have this from the
default ppas.

.. code-block:: bash

    rookie@ubuntu-docker-comic-misc-server:~$ apt policy msmtp
    msmtp:
      Installed: 1.8.6-1
      Candidate: 1.8.6-1
      Version table:
     *** 1.8.6-1 500
            500 http://mirrors.digitalocean.com/ubuntu focal/universe amd64 Packages
            100 /var/lib/dpkg/status


The easiest fix was to pipe the output to the mail command.

.. code-block:: cron

    */1 * * * * (echo "normal output" && cat asdfsfd) 2>&1 | mail -s "test" $MAILTO

This works because the mail command doesn't have a from field, so this
will be set to the one set up in the config. I also have to pipe stderr
to stdout so that it's passed to the mail command too. Only failing with
this method is that if the cron job doesn't output any error, I'll still
get a blank email. I don't have a problem with this though since the
cron job runs weekly.

I'll also be on the look out for when the updated versions of msmtp or
vixie-cron are out and update my jobs.

Here's a great resource for things you should do when setting up
`cronjobs <https://blog.sanctum.geek.nz/cron-best-practices/>`_



TODO:
- remove cron bash script
- set path to PATH=/home/you/.local/bin:/usr/local/bin:/usr/bin:/bin
  docs say PATH is set to "/usr/bin:/bin" si we append the others we
  want. man 5 crontab
- rerun the cronjob and see hot it'll work


docker-compos the input device is not a tty
https://ismailyenigul.medium.com/docker-error-in-crontab-the-input-device-is-not-a-tty-7280cc42cf19



MAILTO="rookie101@jnduli.co.ke"
MAILFROM="rookie101@jnduli.co.ke"
#Ansible: create comic_server backups
@weekly timeout kill-after=5m cron-comic-server-backup
# */1 * * * * timeout 5m cron-comic-server-backup 2>&1 | mail -s "cron comic server backup" $MAILTO
*/1 * * * * echo "using default crontab mail functionality variable"
# */1 * * * * echo "using mailto variable" 2>&1 >> /dev/stderr | mail -s "error temp" $MAILTO
~

debugging tips:
tail -f /var/logs/syslog
tail -f .msmtp.log

