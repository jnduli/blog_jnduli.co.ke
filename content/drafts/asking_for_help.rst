###############
Asking For Help
###############


:date: 2022-05-06
:category: Computer
:slug: oasking_for_help

iiijojq
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

Plan (Note: these don't need to happen sequentially):

- Start out with: http://www.catb.org/esr/faqs/smart-questions.html and
   summarize the contents here.
- Do summary 1 of content, goal being < 250 lines. This summary will help me
   understand the content better.
- Do summary 2 of content, goal being < 100 lines. I want to distill this info
   more such that I can get a quick reference any time that I feel I've done
   something wrong / I need a refresher. I can always go to the original article
   if I need more details or the original perspective.
- Then go with, einstellug effect: https://en.wikipedia.org/wiki/Einstellung_effect, and do the same.
- Then go with: xy problem
- Then lastly do: no-hello.
- Then create a summary article with all the ideas I've collected.


Summary of Smart Questions
==========================
It's ok to be ignorant, it's not ok to play stupid. Before asking, do your
homework and take the time to think about the problem, and try to formulate the
question in a clear way. Simple questions that can be answered with a quick web
search will get a lot of hostility.

Before you ask, try and find the answer by yourself by using google, searching
user forums, reading manuals, FAQs, etc. Show this in your questions. Adding
exact phrases googled provides a record of searches that don't help and will
direct people with similar problems to the thread.

Prepare your question, you earn your answer by asking substantial, interesting
and thought-provoking questions, and make it clear you're willing to help in
finding a solution, like would someone provide a pointer? what's my example
missing? What other sites can I search?

When you ask:

- ensure the question is on-topic on the forum, and don't cross post to too many
  forums, and prefer public spaces to private ones since this will give you a
  larger pool of answerers.
- don't sent personal emails to someone that isn't you acquaintance.
- for stack overflow, search google, then search specific site, and use tags to
  limit results. Only post the question to the site most on topic if you don't
  find an answer, add tags and use formatting tools. Upvote helpful answers and
  accept any answer that solves your problem.
- You can get real time answers from irc. Don't dump long problem descriptions,
  but do a one line problem description as a way to engage the channel.
- Send questions to mailing lists rather than individual devs since the question
  might add value to the whole group; it distributes load of help; mailing lists
  are indexed by search engines and if some questions are asked often, devs can
  either improve docs or the tool. If no mailing list exists, you can email the
  dev but mention you didn't get one, and you're ok if the email is forwarded to
  others.
- Prefer user to dev mailing list unless you're sure the question isn't trivial.
  Before posting to dev mailing list, lurk around to understand their lingo
  before posting.
- Use meaningful subject headers, a good convention being `object-deviation`
  e.g. "Help! Video doesn't work properly on my laptop" doesn't help, but "X.org
  6.8.1 misshapen mouse cursor, Fooware MV1005 vid.chipset" is smart. This also
  helps organize thinking about the problem, and helps future users skim list of
  topics being discussed in forum.
- Don't ask questions in replies since it will only be seen by those watching
  the thread.
- Make it east to reply e.g. emails should have 'Reply-To' header, but don't end
  your messages with 'Please send reply to...'.
- Write in clear, grammatical, correctly spelled language, don't abuse smileys,
  wrap messages to 80 chars.
- Send questions in accessible formats e.g. use txt vs html, doc
- Be precise and informative about your problem, describe environment in which
  it occurs, research done, diagnostic steps taken and relevant changes made to
  configs, and if possible a way to reproduce the error.
- Volume is note precision e.g. if I have a targe test case, try to make it as
  small as possible.
- Sometimes in  the process of refining a bug report you may develop a fix/work
  around yourself.
- Don't claim you've found a bug unless you're sure i.e. provide source code
  patch that fixes the problem or regression test that demonstrates the
  incorrect behaviour. Claiming you've found a bug is impugning on their
  competence, so assume you're doing something wrong, even if you're sure you've
  found an actual bug.
- Don't grovel, do your homework. Its distracting, unhelpful and annoying if
  coupled with vague problems.
- Describe the symptoms not your guesses. Label your guess clearly if case you
  mention it. It's better to see raw evidence when debugging.
- Describe the problem's symptoms in chronological order, both what you did and
  what the software did. You can also provide diagnostic options (e.g. -v for
  verbose).
- If you want to do sth (not a bug), describe the goal first then the steps
  you've taken. This helps respondents know if the path you chose was wrong or
  not.
- Don't ask for private replies, public ones allow correction by others and
  helps respondents be seen as competent and knowledgeable.
- Be explicit in what you want (provide pointers, send code, check your patch
  etc.) which ensures a clear upper bound on time and effort. Someone really
  good and busy is more likely to answer a question with less implicity asked
  for time. Frame questions to minimize time commitment e.g. 'Would you give me
  a pointer to a good explanation of X?' is better than 'Would you explain X,
  please?'. If you have buggy code, its smarter to ask someone to explain what's
  wrong than to ask them to fix it.
- When asking about code: give a hint to the problem e.g. post dozen lines of
  code and say "after line 7 I expected x but got y" rather than posting few
  hundred lines while saying "it doesn't work"; provide minimal bug
  demonstrating test case (even if impossible sometimes, it's good discipline to
  try); mention you want a code review if you want it and note areas that might
  need more attention.
- It's ok to ask for hints on homework questions but not entire solutions.
- Don't tack questions like 'can anyone help me?' or 'is there an answer', since
  this is superfluous to a competent problem description.
- Avoid yes or no questions.
- Don't flag your question as urgent even if it is to you.
- Courtesy never hurts, and sometimes helps e.g. use 'please', 'thanks for your
  attention' or 'thanks for your consideration'.
  

When You Ask
------------
Follow up with a brief note on the solution
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Send a note after solution, letting those who helped know how it came out and
thanking them, if problem attracted interest in mailing list/newsgroup, post
follow up there too. Reply to thread for original question and have 'FIXED,
RESOLVED' or other obvious tag to the subject line, which helps potential
respondents not look at thread, unless they find the problem interesting. Prefer
short, sweet summaries to long dissertations unless the soln has real technical
depth, so say what action solved the problem, but don't replay the whole
troubleshooting experience.

With problems with some depth, post summary of troubleshooting history, describe
final problem statement, what worked as a soln, then avoidable blind alleys, and
name those who helped.

This also helps give everyone who helped a sense of closure.

Consider how you can prevent others from having the same problem in the future,
like a FAQ documentation patch.

How to Interpret Answers
------------------------
RTFM and STFW
^^^^^^^^^^^^^
RTFM: Read the Fucking Manual
STFW: Search The Fucking Web, "Google is your Friend" is a milder version.

Often, someone sending the above has the manual or web page with the soln open,
and thinks the information is easy to find, and you'll learn more if you seek
out the information than have it spoon-fed to you.

If you don't understand
^^^^^^^^^^^^^^^^^^^^^^^
If you don't understand, don't immediately bounce back a demand for
clarification. Use the same tools for research to try and understand the answer,
and only when completely unable, ask for clarification, but exhibit what you
learned.
e.g. If you're told: "It sounds like you've got a stuck zentry, you'll need to
clear it", then a bad follow up is "What's a zentry?", but a good follow up
would be, "Ok, I read the man pages and zentries are only mentioned under the -z
and -p switches. Neither says anything about clearing zentries. Is it one of
these or am I missing something here?"

Dealing with rudeness
^^^^^^^^^^^^^^^^^^^^^
What looks like rudeness isn't, its a preference for direct
cut-through-the-bullshit communication style that is natural to people that
prefer solving problems to making others feel good. Act calmly if your perceive
rudeness, acting out hurts your chances to getting an answer.

On Not Reacting Like A Loser
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
When you screw up in forums, you'll be told exactly how you screwed up, in
public, and you might end up whining about the experience, but instead you
should get over it, it's normal, healthy and appropriate.

Community standards don't maintain themselves, they're maintained by people
actively applying them, visibly in publich, so don't whine when the criticism is
not in private email, not is it useful if you claim you've been personally
insulted when someone differs with your views. Forums that have banned
participants from any fault-finding end up with clueful participants leaving to
elsewhere, leaving the forum into meaningless babble and useless as a techincal
forum.

When someone tells you you've screwed up, he's acting out of concern for you and
his community. He could have easily ignored you, so if you can't manage to be
grateful, don't whine, don't expect to be treated like a fragile doll.

If someone legitimately attacks you with no apparent reason, complaining is the
way to really screw up. 

Questions Not to Ask
^^^^^^^^^^^^^^^^^^^^

- where can I find program or resource X? STFW
- how can I use X to do Y? (x-y problem)
- how can I configure my shell prompt? RTFM
- can I convert the acmecorp doc into a tex file using bass-o-matic converter?
  Try it and see, you'll learn the answer and stop wasting my time
- my {program, config, sql} doesn't work. Not a question
- i'm having problems with my windows machine, can you help?
- My program doesn't work. I think system facility X is broken. Try and back up
  this statement with clear and exhaustive documentation of the failure case.
- I'm having problems installing linux or X, can you help? No, I'd need
  hands-on-access to your machine to troubleshoot this, go ask your local linux
  user group.
- How can I crack/root/steal channel-ops privileges/read someone's email? You're
  a lowlife for wanting to do such things and a moron for asking for help on
  this.

Good and Bad Questions
^^^^^^^^^^^^^^^^^^^^^^
Stupid: Where can I find out stuff about xyx?
Smart: I used google to try and find xyx on the web, but I got no useful hits.
Can I get a pointer to programming information on this?

Stupid: I can't get the code from project foo to compile. Why is it broken?
(Assumes someone else screwed up)
Smart: The code from project foo doesn't compile under Nuiix version 6.2. I've
read the FAQ but it doesn't have anything in it about Nuiix related problems.
Here's the transcript of my compilation attempt, it is something I did?

Stupid: I'm having problems with my motherboard, can anybody help me? 
Smart: I tried X, Y and Z on the s2464 motherboard. When that didn't work, I
tried A, B and C. Note the curious symptom when I tried C. Obviously the
florbish is grommicking, but the results aren't what one might expect. What are
the usual causes of gromicking on Athlon MP Motherboards? ANybody got idesas for
more test I can run to pin down the problem?

If you Can't Get an Answer
^^^^^^^^^^^^^^^^^^^^^^^^^^
If you cant get an answer, don't take it personally. Sometimes people don't know
the answer, and no response is not the same as being ignored. Don't repost your
question when this happens though, as it will be seen as pointlessly annotying,
and consider going to other sources better adapted to novice's needs. These can
include enthusiast user groups, commercial companies that providier help.

e.g. consider linux, where there are atleast 10000 users for each dev, it's not
possible for one person to handle the ssupport from all these.

How To Answer Questions in a Helpful Way
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Be gentle, problem related cstress can make people seen rude or stupid.
Reply to a first offender offline: no need for public humiliation for someone
that may have made an honest mistake.
If you don't know for sure, say so: a wrong authoritative answer is worse than
none at all.
If you can't help, dont hinder e.g. dont make jokes about procedures that could
trash the user's setup, they might interpret this as instructions.
Ask probing questions to elicit more details, this can help turn the bad
question into a good one.
RTFM might be justified, but a pointer to documentation is better.
If you're going to answer the question at all, give good value. Don't suggest
kludgy workarounds when somebody is using the wrong tool/approach, suggest good
tools, even reframe the question.
Answer the actual question, if the user has been really thorough in their
question and has included that X Y Z A B C have already been tried but
unsuccessful, it is unhelpful to respond with try A or B, or with a link that
only says try X Y Z A B or C.
If you did research to answer the question, demonstrate your skills rather than
writing as though you pulled the answer out of your butt. Answering one good
question is like feeding a hungry person one meal, but teaching them research
skills by example is showing them how to grow food for a lifetime.








.. TODO

https://www.mit.edu/~jcb/tact.html


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
