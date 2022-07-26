###############
Asking For Help
###############


:date: 2022-05-06
:category: Computer
:slug: asking_for_help
:author: John Nduli
:status: draft

Actual Blog
===========
Think of this as a skill that can be improved and how to do achieve this.

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

Notes
=====
Plan (Note: these don't need to happen sequentially):

- DONE: Start out with: http://www.catb.org/esr/faqs/smart-questions.html and
   summarize the contents here.
- DONE: Do summary 1 of content, goal being < 250 lines. This summary will help me
   understand the content better.
- DONE: Then go with, einstellug effect: https://en.wikipedia.org/wiki/Einstellung_effect, and do the same.
- DONE: Then go with: xy problem
- DONE: Then lastly do: no-hello.
- DONE: Clean up plan section to avoid confusing and misleading sections
- Summarize each section such that its easy to get the gist of the content in
  one skim:
    - DONE: smart questions: from 181 lines -> 80 lines
    - DONE: einstellug effect: from 11 lines -> 7 lines
    - DONE: xy problem: 30 lines -> 20 lines
    - DONE: no hello: 21 lines -> 15 lines
- Then create a summary article with all the ideas I've collected.

Others:
https://www.chiark.greenend.org.uk/~sgtatham/bugs.html
https://www.mit.edu/~jcb/tact.html

Summary of Smart Questions
==========================
It's okay to be ignorant, it's not okay to play stupid. 

Before you ask:

- do your homework. Search google, user forums, FAQs and read the manual,
  ensuring a quick web search doesn't answer the problem.

Formulating the Question:

- While refining the question, you may develop a fix/work around yourself.
- Write in clear, grammatical and well spelled language. Don't abuse smileys.
- Use meaningful subject headers, a good convention being `object-deviation`
  e.g. don't do "Help! Video doesn't work properly on my laptop" but do "X.org
  6.8.1 misshapen mouse cursor, Fooware MV1005 vid.chipset". This helps when
  thinking about the problem, and helps future users skim list of topics
  discussed in forum.
- If you want to do something (not a bug), describe the goal first then the
  steps taken. This helps others know if the steps were wrong or not.
- Be precise and informative about your problem:
    - describe environment in which it occurs
    - Describe the problem's symptoms in chronological order. You can also
      provide diagnostic options (e.g. -v for verbose).
    - research done. Add the phrases googled to provide a record of searches
      that didn't help and direct others with the same problems to the thread.
    - diagnostic steps taken and relevant changes made to configurations,
    - and if possible a way to reproduce the error.
- Volume is note precision e.g. trim down large test cases
- Describe the symptoms not your guesses. Label your guess in case you mention
  it. It's better to see raw evidence when debugging.
- Make it clear you're willing to help in finding a solution e.g. would someone
  provide a pointer? What other sites can I search?
- Be explicit in what you want, creating a limit on time and effort required
  e.g. 'would you give me a pointer to a good explanation of X?' is better than
  'Would you explain X, please?'. It's also better to have someone explain
  what's wrong with buggy code than have them fix it.
- When asking about code, provide a small bug demonstrating test case (sometimes
  its impossible, but its good to try) and give a hint to the problem e.g. after
  line 7 I expected x but got y.
- Avoid yes or no questions.

When you ask:

- Find the relevant forum/channel for the question.
- Prefer public to private forums or personal messages because you get a larger
  pool of helpers, adds value to the group and distributes the load of help.  
- Send questions in accessible formats e.g. use txt vs html, doc
- Upvote helpful answers and accept any that solved the problem
- Don't ask for private replies, public ones allow correction by others and
  helps respondents be seen as competent and knowledgeable.
- Follow up with a brief note on the solution to the original thread. If the
  problem had some technical depth, post summary of troubleshooting history, the
  final problem statement, the solution, avoidable blind alleys and attribution
  to helpers. If possible, do a FAQ documentation patch.
- Don't ask questions in replies since only those watching the thread will see
  it.
- Make it easy to reply e.g. emails should have 'Reply-To' header, but don't end
  your messages with 'Please send reply to...'.
- Don't tack unnecessary questions like 'can anyone help me?' or 'is there an answer'.
- Don't flag your question as urgent even if it is to you.
- Courtesy never hurts e.g. use 'please', 'thanks for your attention'

Bad/Good Questions
^^^^^^^^^^^^^^^^^^
Bad: How do I configure my shell prompt? Where can I find out about xyz?
Good: I used google to try and find xyz on the web, but I got not useful hits.
Can I get a pointer to programming information on this?

Bad: I'm having problems with my window machine, can you help? My program
doesn't work, I think system facility X is broken (back this statement up
first). I can't get the code to compile, why is it broken? (assumes someone else
screwed up).
Good: The code from project foo doesn't compile under Nuix v6.2. I've read the
FAQ but it doesn't have anything in it about Nuix related problems. Here's the
transcript of my compilation attempt, is it something I did?

Bad: I'm having problems with my motherboard, can anybody help me?
Smart: I tried X, Y and Z on the s2464 motherboard. When that didn't work, I
tried A, B and C. Note the curious symptom when I tried C. Obviously the
florbish is grommicking, but the results aren't what one might expect. What are
the usual causes of gromicking on Athlon MP Motherboards? ANybody got idesas for
more test I can run to pin down the problem?

Einstellug Effect
-----------------
Ref: https://en.wikipedia.org/wiki/Einstellung_effect

If I have experience solving problems using X, when I get something similar,
I'll try to force X to the problem, even though there might be a better way Y.
My experience hinders the problem-solving. This also happens to tools, where if
I'm used to using tool X for Y, I'll find it hard to discover a new use for X
(functional fixedness).

XY Problem
----------
ref: https://xyproblem.info/:

When someone asks about problems in their solution rather than the actual
problem, for example:

1. User wants to do X e.g. get the extension of a file
2. They don't know how to do X, but think a solution is to try Y e.g. get the
   last 3 characters of a filename
3. They don't know how to do Y too
4. They ask for help with Y e.g. how do I get the last 3 characters of a
   filename?
5. Someone gives the solution to Y, but Y feels odd problem to solve e.g.
   "filename[-3:]"
5. It later becomes clear that the user wanted X, and solving Y seems like
   wasted effort. e.g. not all files have extensions 3 characters long.

Including details about the broader picture and the attempted solutions and why
you ruled them out can help avoid this. Also give more information when asked.

No Hello
--------
REF: https://nohello.net/en/

Starting with 'hello?', 'hi, quick question?', etc. and waiting for the other
person to respond before I send the actual question leads to lost productivity.
For example, if I was away from my laptop, I'm now forced to respond before I
can get the question, whereas if you'd asked the question upfront I could have
answered it when I got back.

If you're uncomfortable being direct, preface the question with pleasantries
like 'hey, hope you're well. Any idea when the demo is due?'.


How to Interpret Answers and How to Answer
==========================================
REF: http://www.catb.org/esr/faqs/smart-questions.html


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
