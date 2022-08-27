###############
Asking For Help
###############

:date: 2022-08-27
:category: Random
:slug: asking_for_help
:author: John Nduli
:status: published

I get and send bad questions. To avoid this, I write my questions in my editor,
review and then copy them to the platform e.g. slack, email. My questions are
better, which makes me wonder if there are other changes that could further
improve my questions.

A lot of great resources exist online, and here's a checklist I've made for my
questions.

Before I consider asking a question, ask:

1. What do I want? Avoid thinking that the solution in mind is the problem. I
   can tack on the failed solution to the question if need be. This prevents
   `the XY problem <https://xyproblem.info/>`_ when I'm making the question.
2. Am I forcing my experience, knowledge or the technology I know to the problem (i.e. `einstellung
   <https://en.wikipedia.org/wiki/Einstellung_effect>`_?
3. Spend time making the question before reaching out to someone. This prevents
   `sending a hello with no context <https://nohello.net/en/>`_, since I have
   the question to add after the greeting.
4. Do my research, and note down all the findings I've got. This helps when
   adding details to the question.

For example, I built an image on a server, but failed severally because the
server ran out of memory. I spent a lot of time trying to figure out how to
limit docker memory, but this wasn't the goal. Following the above process could
have helped.

1. What did I want? I wanted a custom image on the server.
2. Am I forcing the technology I know or the solution I've thought out? Yes I
   was. The server ran out of memory severally and I tried to find ways to
   limit the memory while building the image. I didn't even stop to consider
   that there would be another option to get this image in.
3. Spend time making the question before reaching out to someone. At this point
   I realized that I was solving the wrong problem, and decided to find other
   options for what I wanted.
4. Do my research and note down all findings. While researching the original
   problem, I found that I can load up a locally build image to a server by
   using docker load, which solve the problem, hence no need to ask.

Once I've done the above and the problem persists, I make and refine the question by:

1. Having meaningful subject headers.
2. Starting with the goal, then the steps I've taken, hence I ensure others will
   know if my steps were wrong or if there were other options I didn't consider.
3. Editing the question to be short but informative. I can include:
    - the environment this occurred (if relevant)
    - the symptoms in chronological order
    - the research done
    - a way to reproduce the error (if possible).
    - screenshots if its a UI bug
4. Trimming down code snippets and test cases to the smallest bug-demonstrating version.
5. Avoiding open-ended questions by being explicit in what I want. The less
   effort my request needs the likelier I'll get a response e.g. 'Can someone
   explain X?' forces someone to create a detailed explanation while 'Can
   someone provide a pointer to a good explanation of X' means they only send
   you to a relevant blog post.
6. Writing in clear, grammatical and well spelled language.
7. Avoiding yes or no questions.

Once you have the question, then:

1. Look for a relevant public channel. Avoid private ones or personal messages
   since public ones ensure more people see the question and learn from it.
2. Follow up with a brief note on the solution to the thread. Upvote helpful
   answers and accept any that solved the problem.
3. Don't ask questions in ongoing threads since those not following the thread
   will not see it.
4. Be courteous, use please and 'thanks for your attention', etc.

References
==========

- http://www.catb.org/esr/faqs/smart-questions.html
- https://en.wikipedia.org/wiki/Einstellung_effect
- https://xyproblem.info/
- https://nohello.net/en/
