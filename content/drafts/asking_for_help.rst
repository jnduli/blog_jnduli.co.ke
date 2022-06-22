###############
Asking For Help
###############

:date: 2022-05-06
:category: Computer
:slug: asking_for_help
:author: John Nduli
:status: draft


Resources for asking for help:
- no hello: https://nohello.net/en/
- xy problem: https://xyproblem.info/

  - https://www.perlmonks.org/?node=XY+Problem
  - https://en.wikipedia.org/wiki/XY_problem

- how to ask questions the smart way: http://www.catb.org/esr/faqs/smart-questions.html
- einstellug effect: https://en.wikipedia.org/wiki/Einstellung_effect

Others:
https://www.chiark.greenend.org.uk/~sgtatham/bugs.html

Plan:

1. Start out with: http://www.catb.org/esr/faqs/smart-questions.html and
   summarize the contents here, then do more summaries until I've got a good
   reflection of my understanding of the topic.
2. Then go with, einstellug effect: https://en.wikipedia.org/wiki/Einstellung_effect, and do the same.
3. Then go with: xy problem
4. Then lastly do: no-hello.
5. Then create a summary article with all the ideas I've collected.

Summary of Smart Questions
==========================
Introduction
------------
- hackers like hard problems that are good and thought-provoking since it helps
  them develop their understaning and reveals problems that werent considered.
- despite this, they seem to answer simple questions with hostility/arrogance,
  but they are actually hostile to people that seem to be unwilling to think or
  do their homework before asking, taking time from other better questions.
- many users use software as a tool, with no interest in learning technical
  details but hackers prefer active participants in solving problems, and this
  shouldn't change.
- its ok to be ignorant, its not ok to play stupid i.e. hackers love interacting
  with equals and welcoming people into their culture, but this requires effort
  from others, and it's' not efficient for them to help those that aren't
  willing to do this.

Before you ask
--------------
Try and find an answer by yourself. This can include google search, searching
user forums, reading manuals, FAQs, experimenting or even looking at the source
code. Display the fact that you've done this in your questions (which helps show
people that you did due diligence), and if possible display what you've learned
from this. Adding the exact phrases googled also provides records on what
searches don't help, and also directs people with similar problems to the
thread. Take your time with the research, don't expect to solve a complicated
problem with a few seconds of googling, and try to understand FAQs or manuals
before approaching the experts. Prepare your question, think it through, hasty
sounding questions get hasty answers or none. Be careful not to ask the wrong
questions based on faulty assumptions, don't assume you're entitled to an answer
(since you aren't paying for support), you earn your answer by asking
substantial interesting thought provoking questions. Make it clear that you're
willing to help in the process of developing a solution e.g. would someone
providie a pointer, what's my example missing, what other sites should I search?
are better than pleas give me the exact procedur to solve my problem.

When You Ask
------------
Choose Your Forum carefully
^^^^^^^^^^^^^^^^^^^^^^^^^^^
ensure the question is on-topic for the forum (check FAQ and see other
questions), don't post an elementary question in a forum where advanced
technical questions are expected or vice-versa, don't cross post to too many
different forums, don't send a personal email to someone that isn't your
acquaintance.

public forums are preferred to private ones since there is a larger pool of
people that the answer would help.

Stack Overflow
^^^^^^^^^^^^^^
search google (it indexes stack overflow and results are at the top). If not
successful, search the specific site where question is most on-topic, and use
tags to limit results. If not successful, post question on the one site most on
topic, use formatting tools for code and add tags, if commenter asks for more
information, edit main post to include it, and upvote helpful answers, and click
to accept any answer that solves your problem.

Web and IRC Forums
^^^^^^^^^^^^^^^^^^
advertised irc channel is an open invitation to ask questions and often get
answers in real time. It may be better to ask in distro's forum/list vs the
programs' one since they might just tell you to use their build. Search the web
forum before posting question, web search might not have indexed this. In IRC,
don't dump a long problem description on the channel, since this can be
interpreted as flooding but rather do a one line problem description as a way to
start the conversation on the channel.

Project mailing list
^^^^^^^^^^^^^^^^^^^^
write to the mailing list, not individual developers, because:
- a good question will also be of value to the whole group.
- distributes load among devs.
- mailing lists are archived and indexed by search engines.
- if some questions get asked often, devs can use these to improve docs.

If a project has a user and dev mailing list, use the user one. If sure your
question isn't trivial, then lurk around the dev one to understand the comms
used before posting. If no mailing list exists, email the dev but mention that
you didn't get one, and that you also dont object to your email being forwarded
to others.

Use meaningful specific subject headers
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
don't try to impress with depth of your anguish e.g. Please help me, but use
space for a super concise problem description. A good convention is
`object-deviation` object being the thing that has a problem, deviation
describing what is different from expected behaviour.

e.g. Stupid: Help! Video doesn't work properly on my laptop!
Smart: X.org 6.8.1 misshapen mouse cursor, Fooware MV1005 vid.chipset
Smarter: X.org 6.8.1 mouse cursor on Fooware MV1005 vid. chipset - is misshapen

Process of writing object-deviation helps organize thinking about the problem in
more detail.

Imagine looking at the index of an archive of questions with just the subject
lines showing, if the subjects are descriptive then someone can easiy skim it
and find relevant discussions.

If you ask a question in a reply, change the subject line to indicate that
you're asking a question. Trim quoatation of previous messages to the minimum
consistent with cluing in new readers.

Don't reply to a list message in order to start entirely new thread. This limits
your audience e.g. mull allows users to sort by thread and hide messages in a
thread by folding. Changing the subject isn't enough, there are other
information in email headers that mutt probably uses, so instead start an
entirely new email thread.

Don' ask questions in replies since it will only be seen by those watching the
thread.

Make it easy to reply
^^^^^^^^^^^^^^^^^^^^^
emails should have 'Reply-TO' header to make it easy to reply. Don't end you
message with `Please send repy to...`. You can also watch threads on forums to
get replies.

Write in clear, grammatical, correctly spelled language
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
careless sloppy writers are also careless and sloppy at thinking and coding, so
answering these questions isn't rewarding. Don't use IM shortcuts e.g. u instead
of you.

Send questions in accessible standard formats
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Your question shouldn't be artificially hard to read. Send plain text mail, not
html, mime attachments are ok if they're real content and not boilerplate from
the mail client, wrap messages to 80 chars, dont wrap data and send it as is
(e.g. file dumps), don't use proprietary document formats, don't abuse smileys
since this makes people think you're lame.

Be precise and informative about your problem
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
describe symptoms of problem carefully and clearly, describe env in which it
occurs (machine, OS, application), describe research done, describe diagnostic
steps taken to try to pin down the problem, describe relevant changes made
to comp and software configs, provide a way to reproduce the error if
possible.

Volume is not precision
^^^^^^^^^^^^^^^^^^^^^^^
Be precise and informative e.g. if you have a large test case that is breaking a
program, try to trim it and make it as small as possible. This is useful
because: one is seen as investing effort in smplifying the question thus makes
it easy to get answers; simplifying question makes it more likely you'll get an
answer; in the process of refining a bug report you may develop a fix/work
around yourself.

Don't rush to claim that you have found a bug
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Don't claim you've found a bug unless you are very, very sure i.e. unless you
can provide a source-code patch that fixes the problem or a regression test
against a previous version that demonstrates incorrect behaviour. Same applies
for doc bugs. People that write software work hard to make sure it works as well
as possible, so claiming you've found a bug might be impugning their competence,
and it's especially undiplomatic to yell bug in the subject line. Write as
though you are doing something wrong, even if you're privately sure you've found
an actual bug.

Grovelling is not a substitute for doing your homework
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
e.g. I know I'm just a pathetic newbie loser, but..., this is distracting,
unhelpful and annoying if its coupled with vagueness about the actual problem.

Describe the problem's symptoms not your guesses
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
If you want to state your guess, clearly label it as such and why that isn't
working for you. TO diagnose, it's better to see whatever is as close as
possible to the raw evidence that I see rather than my guesses and summaries.

Describe your problem's symptoms in chronological order
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
clues to figure out what went wrong usually lie in events immediately prior. Try
to describe precisely what you didi and what the software did leading to the
blow up. You can provide a session log and quote the relevant twenty or so
lines, and/or use program's diagnostic options (e.g. -v for verbose), and try to
select options thata will add useful info to the transcript but not drown the
reader in junk.

Describe the goal, not the step
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
If you're trying to find out how to do sth (not a bug), begin by describing the
goal, then the steps you've taken. People will have a high level goal in mind
but get stuck on the path they chose, and come for help on the path and don't
realize that the path is wrong.

Don't ask people to reply by private email
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Public answers allows correction of answers by knowledgeable people, and helps
respondents be seen as competent and knowledgeable. Don't ask for private
replies, it's the respondents choice if to reply by private.

Be explicit about your question
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Open ended questions are perceived as open ended time sinks, and avoided by
those that are most likely to be able to answer.

Be explicit about what you want (provide pointers, send code, check you patch,
etc.), which ensures there's a clear upper limit on effort and time.

The less of a time a commitment you implicitly ask for, the more likely you are
to get an answer from someone really good and busy.

Frame question to minimize time commitment e.g. 'Would you give me a pointer to a
good explanation of X?' is smarter than 'Would you explain X, please?', if you
have malfunctioning code, its usually smarter to ask someone to explain what's
wrong with it that to ask someone to fix it.

When asking about code
^^^^^^^^^^^^^^^^^^^^^^






.. TODO





























 how to ask questions:

- 



Asking for help can be structured, especially for code help when stuck, enabling
both the questioner and anwswerer to have the best bang for their time.


1. Clean up the code in your branch, assuming that someone will do some sort of
   review on it. This ensures it's easy for the helper to understand what you
   were going for.
2. Add an explanation or a code snippet on how to replicate this issue. This
   way, someone can run this and replicate the problem locally.
3. Screenshots and documentation on alternatives tried, etc.


This way, the helper easily gets context with one read, is able to think of
solutions and if they want to get their hands dirty, they can replicate the same
locally.

This should happen before any syncs on the same too.


TODO: read the following:
http://catb.org/~esr/faqs/smart-questions.html
xyproblem
nohello
