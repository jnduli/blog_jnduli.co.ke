I wanted to set up a cronjob for backing up content on my server. I set
up msmtp, msmtp-mta for email sending, and hooked this up to my smtp
server. When testing emailing of errors I got a weird error from cron
(got by checking /var/log/syslog):

note: I'd set up the MAILTO variable in cron.

```
Dec  2 06:14:02 ubuntu-docker-comic-misc-server cron[7901]: sendmail: the server did not accept the mail
Dec  2 06:14:02 ubuntu-docker-comic-misc-server cron[7901]: sendmail: server message: 551 5.7.1 Not authorised to send from this header address
Dec  2 06:14:02 ubuntu-docker-comic-misc-server cron[7901]: sendmail: could not send mail (account default from /home/rookie/.config/msmtp/config)
Dec  2 06:14:02 ubuntu-docker-comic-misc-server CRON[7899]: (rookie) MAIL (mailed 50 bytes of output but got status 0x0045 from MTA#012)
```

which was confusing since looking at the msmtp logs, the from address
was being set up correctly:

```
Dec 02 06:15:02 host=smtp.fastmail.com tls=on auth=on user=jnduli@fastmail.com from=rookie101@jnduli.co.ke recipients=rookie101@jnduli.co.ke smtpstatus=551 smtpmsg='551 5.7.1 Not authorised to send from this header address' errormsg='the server did not accept the mail' exitcode=EX_UNAVAILABLE
```

I found out that cron was using vixie-cron and the cron job set's the
From field to the user running the job in emails here https://github.com/vixie/cron/blob/690fc534c7316e2cf6ff16b8e83ba7734b5186d2/do_command.c#L432

and that the fix done in ubuntu's version is to support a MAILFROM field
here: https://bugs.launchpad.net/ubuntu/+source/cron/+bug/1750051, but
this was not yet in the version I was using:

```
rookie@ubuntu-docker-comic-misc-server:~$ apt policy cron
cron:
  Installed: 3.0pl1-136ubuntu1
  Candidate: 3.0pl1-136ubuntu1
  Version table:
 *** 3.0pl1-136ubuntu1 500
        500 http://mirrors.digitalocean.com/ubuntu focal/main amd64 Packages
        100 /var/lib/dpkg/status
```

another fix was to use the `set_from_header on` in msmtp but this was
also released in a future version https://marlam.de/msmtp/news/msmtp-1-8-8/

```
rookie@ubuntu-docker-comic-misc-server:~$ apt policy msmtp
msmtp:
  Installed: 1.8.6-1
  Candidate: 1.8.6-1
  Version table:
 *** 1.8.6-1 500
        500 http://mirrors.digitalocean.com/ubuntu focal/universe amd64 Packages
        100 /var/lib/dpkg/status
```

The easiest fix was to pipe output to the mail command manually using
something like this:

```
*/1 * * * * (echo "normal output" && cat asdfsfd) 2>&1 | mail -s "test" $MAILTO
```

I'm on the lookout for when the above will be updated and I'll update my
cronjobs to use the MAILFROM field.

Another option would be to set up a user mail box and set a forwarding
rule to pass that into my email address, but I don't want to look into
this at the moment.


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

