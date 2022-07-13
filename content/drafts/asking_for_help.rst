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

Plan (Note: these don't need to happen sequentially):

- DONE: Start out with: http://www.catb.org/esr/faqs/smart-questions.html and
   summarize the contents here.
- DONE: Do summary 1 of content, goal being < 250 lines. This summary will help me
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
- Follow up with a brief note on the solution on original thread and other
  groups that showed interest in the problem. Have 'FIXED' or 'RESOLVED' in the
  subject line to help potential respondents know that its solved. If the
  problem had some technical depth, post summary of troubleshooting history, the
  final problem statement and what worked as a solution, and avoidable blind
  alleys plus attribution to those who helped. If possible, do a FAQ
  documentation patch.

How to Interpret answers:

- RTFM (Read thee Fucking Manual), STFW (Search The Fucking Web). The responder
  thinks the information is easy to find and you'll learn more if you search
  than have it spoon-fed to you.
- If you don't understand an answer, research the answer, and ask for
  clarification only if this still didn't help, but make sure to show what
  you've learned e.g. 'You got a stuck zentry', don't follow up with 'Ok, what's
  a zentry?', but raher, 'I read the man pages and zetries are only mentioned in
  .. neither says anything about clearing zentries, am I missing somthing?'
- Assume that what you perceive as rudeness isn't. Acting out hurts your chances
  of getting an answer.
- If you screw up in a forum, you'll be told. Instead of complaining about the
  experience, get over it since it's normal and healthy. The person telling you
  is acting out of concern for you and the community, and could have easily
  ignored you, so instead try to be grateful and don't expect to be treated like
  a baby.
- If someone legitimately attacks you for no reason, complaining is the way to
  screw up.

If you can't get an answer, no response doesn't mean you're being ignored.
Perhaps people don't know the answer. Don't repost the question though, and
consider going to other sources.

To answer questions in a helpful way:

- be gently, problem related stress can make people seem rude/stupid.
- reply to first offenders privately, no need for public humiliation.
- if you don't know, say so, a wrong authoritative answer is worse that no
  answer.
- If you can't help don't hinder e.g. don't make jokes about commands that can
  trash the user's set up.
- ask probing questions that can help turn a bad question into a good one.
- instead of RTFM, send a pointer to the documentation.
- if you answer a question, give good value. Don't suggest workarounds if
  someone is using the wrong tool/approach, but suggest good tools or even
  reframe the question.
- answer the actual question. If the user has been thorough and tried A, B, C,
  it's unhelpful to tell them to try A or B.
- if you did research to answer the question, show this rather than act as
  though you pulled the answer out of your head. Teach them to fish.

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
