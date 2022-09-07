###############################
Summary of How to Do PR Reviews
###############################

:date: 2022-05-06
:category: Computer
:slug: summary_of_ho_to_do_pr_reviews

Plan
====
- DONE: Summarize code review guidelines for humans
- ONGOING: Summarize google code eng review guide
- DONE: Summarize reddit review summary: 100 words
- DONE: Summarize swarma review summary: 200 words -> reached 301
- DONE: Summarize stackoverflow review summary: 200 words -> reached 680
- DONE: Summarize code guidelines for humans summary: now 800 words -> 652 words
- Summarize google code eng review guide


Summaries
=========

Reddit
------
https://www.reddit.com/r/ExperiencedDevs/comments/u6fxbm/do_people_think_your_pr_comments_sound_arrogant/

- Use we instead of I/me/you which makes comments less judgemental, removes
  blame implication and feeling that my way is right e.g. could we change this
  function to do it this way?
- Limit character count of each comment to 300, otherwise it looks like a wall
  of complaints. You can keep the long comments in another document and
  summarize it. Follow up with the dev if they want the details.
- Use emojis, which helps communicate the intent behind your words.
- Use questions instead of statements, but don't shy from being direct if
  there's a clear answer. This assumes the author knows more than you do e.g:

    - I find this confusing becomes 'Could you elaborate on how this works?'
    - This is unmaintainable becomes 'What was your vision on maintaining this?'
    - This is broken, it will lose the db connection becomes 'What happens if we
      lose the db connection here?'

- Include positive feedback. If you're only complaining about the code in PRs
  then you're doing it wrong, you need to celebrate the small victories 


A complete guide to code reviews
--------------------------------
https://www.swarmia.com/blog/a-complete-guide-to-code-reviews/

The goals for code reviews are:

- sharing knowledge
- spreading ownership
- unifying development practices
- quality control

Best practices:

- focus on important aspects like functionality, software design, complexity,
  tests, naming, documentation and comments, and automate trivial checks.
- discuss high level approaches before implementation, which prevents
  PR-rewrites. If I require a POC to spark the discussion, start a draft PR of
  the approach and have the conversation.
- Foster a positive feedback culture:

    - provide feedback on code, not the author
    - accept that there are several correct solutions to a problem and you all
      are in the same boat.
    - PR authors are humans with feelings.
    - Use the "Yes, and ..." technique to keep an innovative atmosphere. It's
      ungracious to dismiss fresh and fragile ideas in a draft PR stage.
    - Keep feedback balanced with positive comments.
    - pick your battles
- Keep discussions public
- Be explicit about the action you want from the author.
- Optimize for the team. Fast reviews are great and set a max time to respond to
  a PR. We minimize response lag between the author and reviewer, avoid
  interrupting focus times and have reviews done when there's a fitting gap e.g.
  after lunch.
- Have a bias for action, preventing stalled work e.g. approve a PR even if
  there's some input left to consider. Quick decisions are sometimes better than
  slow "ideal" solutions, so reserve time for technical decisions but move on
  before you reach analysis paralysis. Incline more to merge code rather than
  punching holes in implementation.
- Clear Pr descriptions e.g. test set up, surprising implementation details,
  visual demos etc.
- Document discussions in code i.e. if you receive comments/suggestions,
  document this discussion in code, so that future devs have context without
  having to look for PRs.


== Stackoverflow blog on good code reviews ==
https://stackoverflow.blog/2019/09/30/how-to-make-good-code-reviews-better/

Areas Covered by code review:
- good: covers correctness, test coverage, functionality changes and best
  practices. Points out obvious improvements like hard to understand code,
  unclear names, commented out code, untested code, unhandled edge cases and
  when too many changes are crammed into one review.
- better: looks at change in context of larger system, and makes sure the changes are
  easy to maintain. Asks if change is necessary or how it impacts other parts of
  the system. Notes maintenance problems like complex logic that could be
  simplified, improves test structure and removes duplication.

Tone of Review:
Having a harsh tone makes others hostile, and opinionated language makes them
defensive. Prefer professional and positive tones.
- good: open ended questions instead of strong opinionated statements. Offer
  alternatives and possible workarounds but don't insist these are the best/only
  way to process. Assume reviewer might be missing something and ask for
  clarification instead of correction.
- better: empathetic, know that coder spent a lot of time and effort on change.
  Kind and unassuming, applaud nice solutions and all-round positive.

Approving vs Requesting Changes:
After a review, the changes are either approved, blocked with change requests
or without a specific status.
- good: don't approve changes with open-ended questions, but make it clear which
  questions/comments are non-blocking/unimportant marking them distinctly. Are
  explicit when approving a change or when requesting a follow up.
- Better: firm on principle but flexible on practice. Allow some comments to be
  addressed in follow-up PRs. Reviewers are available for urgent changes.

From Code Reviews to talking to Each Other:
Code reviews are async, but sometimes it's necessary to have a face to face.
- good: leave as many comments and questions as needed, but when the
  conversations has many back-and-forths, try to switch to in-person discussion
  instead of using the code review tool.
- better: proactively reach out to coder after they do a first pass on the code
  and they have a lot of comments and questions. Having many comments means
  there's some misunderstanding on either side, and these are easier identified
  and resolved by talking.

Nitpicks:
unimportant comments that the code can be merged without addressing.
- good: make it clear when changes are unimportant nitpicks e.g. prefixing
  "nit". Many nits are frustrating and distract from the more important parts.
- better: realize that too many nitpicks are a sign of lack of tooling and a
  lack of standards. Try to solve these outside the code review process e.g.
  with automated linting.

Code Reviews for New Joiners:
- good: use same quality bar and approach for everyone regardless of job title,
  level or when they joined the company.
- better: pay attention to make the first few reviews for new joiners a great
  experience. They are empathetic to ignorance of new joiner to coding
  guidelines and unfamiliarity with the code. Explain alternative approaches and
  point to guides. Positive in tone, and celebrate the first few changes to the
  codebase the author suggests.

Cross-office, cross-time Zone Reviews:
- good: account for time zone differences when they can. Aim to review code in
  overlapping working hours btn offices, and try to chat/video call through
  PRs with many comments.
- better: notice when PRs run into timezone issues and look for systemic
  solutions outside code review framework.

Organizational Support:
How companies and their eng organizations approach code reviews. If reviews are
unimportant and trivial, it might be tempting to do away with them.
- good: ensure all eng take part in review process, encourage raising the
  quality bar, and teams facilitate healthy discussions on code review
  approaches both at team and org level.
- better: have hard rules around no code making it to prod without a code
  review. Cutting corners isn't worth it, and there are  processes for urgent
  cases. Invest in dev productivity, including working continually to develop
  more efficient code reviews and tooling improvements. When people find reviews
  that feel hostile, they can speak up and have support all-round to resolve the
  issue. Seniors/Managers consider code reviews that are not up to bar just as
  much of an issue as sloppy code or poor behaviour.

== Code Review Guidelines for Humans ==
https://phauer.com/2018/code-review-guidelines/
Guidelines for author:
- be humble and accept that you'll makes mistakes. This reduces the fear of
  mistakes and creates an atmosphere where they're accepted and its desired to
  admit them, which allows criticism and opportunities to learn in PRs.
- You are not your code, so someone criticizing your code doesn't mean they're
  criticizing you.
- You are on the same side 
- Don't place more value in code you've written since it'll be hard to accept
  suggestions and remove the code (IKEA effect)
- Reviews reveal new perspectives/implicit knowledge that isn't expressed in
  code, that the author can't see e.g. `if article.state == state.inactive` is
  implicit because I might not know when that happens but `bool
  article_is_out_of_stock = article.state == state.inactive` makes it less so.
- exchange of best practices and experiences

Guidelines for the Reviewer:
How we phrase feedback determines if its accepted.
- Use I-messages i.e. I suggest/think/believe/would, It's hard for me, For me it
  seems e.g. you are writing cryptic code -> It's hard for me to grasp what's
  going on in this code. These make the message subjective, but you-messages
  sound like an insinuation or an absolute statement, an attack to the author,
  and they get defensive.
- talk about the code, not the coder e.g. You're requesting the service multiple
  times which is inefficient -> This code is requesting the service ... 
- ask questions e.g. this variable should be called userId -> What do you
  think about the name userId for this variable? Questions feel less like
  criticism and can trigger a thought process that leads to accepted feedback or
  a better solution. They also reveal intention behind some design decisions
  without passing judgement.
- Mind the OIR-Rule of giving feedback:
    - Observation e.g. this method has 100 lines. Described in an objective
      neutral way, and use I messages.
    - Impact e.g. this makes it hard for me to grasp the essential logic of this
      method. Explain impact that the observation has on you. Use I-messages.
    - Request e.g. I suggest extracting the low-level-details into subroutines
      and give them expressive names. Use an I-message to express wish/proposal
- Accept that there are different solutions: distinguish between common best
  practices and your personal taste, make compromises and be pragmatic.
- Don't criticize every single line of code but instead choose the battles to
  fight. Focus on flaws and code smells that are most important to you.
- Praise: appreciate good code. It should be specific, concrete and separated
  from criticism. Use different sentences and avoid sandwiching e.g. Most of
  your code looks good, but the method calc is too big -> I really like the
  class ProductController, Tim. It has a clear single responsibility, is
  coherent and contains nicely named methods good Job.\n Despite this, I spotted
  the method calc which is too big for me. It's okay to say "Everything is
  good".

Three Filters For Feedback:
Is it true? Is it necessary? Is it kind?

- Is it true? `You should use getter and setter. This code is wrong`, assumes an
  absolute truth, which rarely exists. Avoid right, wrong, should and often
  refer to your opinion e.g. `in this case I'd recommend using getter and setter
  because ...`, or ask questions 'did you consider to use getter and setter?' or
  refer to a source 'According to the java style guide...'
- Is it necessary? e.g. 'there is a space missing here' is pedantic, 'this code
  sends a chill down my spine, but I see your intention' first part has no sense
  and makes the author feel attacked. 'we should refactor the whole package'
  might not be necessary in the context of the current feature.
- Is it kind? `A factory is badly over-engineered here. The trivial solution is
  to just use the constructor' is shaming the author, but rather do 'this
  factory feels complicated to me. Have you considered to use a constructor
  instead?'

== Google Code Review Docs ==

*The standard of Code Review:*
primary purpose of review it to make sure overall code health of google's code
base is improving over time. For this to happen, devs must be able to submit
improvements to the codebase and reviewers should make it easy for such changes
to get in, but also ensure the change is such that the overall health of the
codebase is improving. Codebases degrade through small decreases in code health
over time, especially when a team is time constrained and takes shortcuts.

rule: reviewers should favor approving a CL once it is in a state where it
definitely improves the overall code health of the system being worked on, even
if the CL isn't perfect.

Mentoring
leave comments that help devs learn something new but prefix them with "Nit:" if
not critical or indicate it's not mandatory to be resolved.

Resolving conflict:
first action is for dev and reviewer to try to come to a consensus, prefer a
face-to-face meeting and record the results in a comment in the PR. It this
doesn't resolve the situation, escalate to broader team, TL, Eng Manager.

*What to Look for in a Code Review:*
design: do the interactions of various code pieces make sense? Does this change
belong in the code base or a library? Does it integrate well with the rest of
the system?
Functionality: think about edge cases, look for concurrency problems, try to
think like a user and make sure there are no bugs that you see just by reading
the code. You can validate the change, especially if it has a user facing impact
e.g. UI change.
Complexity: `too complex` means `can't be understood quickly by code readers`
or `developers are likely to introduce bugs when they try to call or modify this
code`. Look out for over-engineering, where devs have made the code more generic
than it needs to be or added functionality that isn't needed by the system.
Tests: tests should be added in same CL as the code unless its an emergency.
Make sure tests in CL are correct, sensible and useful. Will tests fail when the
code is broken? If code changes will they start producing false positives? Does
each test make simple and useful assertions? Are tests separated appropriately?
Tests are also code that has to be maintained, so don't accept complexity in
them just because they aren't part of the main binary.
Naming: a good name is long enough to fully communicate what the item is/does
without being so long that its hard to read.
Comments: Are all comments necessay? Usually, comments are useful when they
explain why some code exists, not what some code is doing. Code should be simple
enough that someone can get the what (an exception is regex and complex algos).
Note that comments are different from documentation of classes, modules,
functions that should instead express the purpose of a piece of code, how it's
used and how it behaves when used.
Style: CL should follow style guides. Prefix style comments with nit.
Consistency: maintain consistency with existing code.
Documentation: ensure CL updates associated documentation, including READMEs,
etc. If it deletes/deprecates code, check if the documentation should also be
deleted. If documentation is missing, ask for it.
Every Line: look at every line of code you've been assigned to review. If its
too hard to read the code and it's slowing the review, notify the dev and wait
for clarifications. If you understand the code but you don't feel qualified to
do some part of the review, make sure there's a reviewer on the CL that's
qualified.
Exceptions: If it doesn't make sense to review every line, note in a comments
the parts you've review, If you want to grant merge after confirming other
reviewers have reviewed parts of the CL, note this explicitly in a comment to
set expectations.
Context: look at the CL in a broad context, e.g. you might have to look at the
whole file to see if the 2 line changes make sense, or think of the CL in the
context of the system as a whole, is it improving code health of system or
degrading it.
Good things: if you see something nice in a CL, tell the dev, especially when
they addressed one of you comments in a great way. Offer appreciation and
encouragement for good practices as well.

Summary

In doing a code review, you should make sure that:

    The code is well-designed.
    The functionality is good for the users of the code.
    Any UI changes are sensible and look good.
    Any parallel programming is done safely.
    The code isn’t more complex than it needs to be.
    The developer isn’t implementing things they might need in the future but don’t know they need now.
    Code has appropriate unit tests.
    Tests are well-designed.
    The developer used clear names for everything.
    Comments are clear and useful, and mostly explain why instead of what.
    Code is appropriately documented (generally in g3doc).
    The code conforms to our style guides.


Navigating a CL in review
-------------------------
Summary:

- does the change make sense? Does it have a good description?
  If this change shouldn't have happened in the first place, respond immediately
  with an explanation of why, and suggest what the dev should have done instead
  e.g. 'Looks like you put some good work into this, thanks! However, we're
  actually going in the direction of removing the FooWidget system that you're
  modifying here, and so we don't want to make any new modifications to it rn.
  How about instead you refactor our new BarWidget class?' If you get more than
  a few CL changes that you don't want to make, consider re-working your team's
  dev process. It's better to tell people no before they've done a ton of work.
- look at the most important part of the change first. Is it well designed
  overall? There should be one file with the largest number of logical changes
  and it's the major piece of the CL, so looking at this helps give context of
  the other changes and accelerates the review. If you can't figure out the
  major part, ask the dev for this or ask them to split up the CL into multiple
  CLs. Send comments immediately if there are errors in this major part, even if
  you won't review the other changes.
- Look at the rest of the CL in an appropriate sequence


Speed of Code Reviews
---------------------
Slow code review has the following impact:
- velocity of the team as a whole is decreased: individual that doesn't respond
  quickly to the review gets other work done, but new feature and bug fixes for
  the rest of the team are delayed by days, weeks, monght as each CL waits for
  review and re-review.
- developers start to protest the code review process, where if a reviewer
  responds every few days but requests majore changes to the PR each time, it's
  frustrating and difficult for developers. This is expressed as complaints
  about how "strict" the reviewer is being. If the reviewer responds quickly
  every time the dev makes an update, the complaints tend to disappear. Most
  complaints about the code review process are actually resolved by making the
  process faster.
- Code health is impacted. With slow reviews, there's increased pressure to
  allow devs to submit PRs that are not as good as they could be. Slow reviews
  also discourage code cleanups, refactorings and further improvemetns to
  existing PRs.

How Fast Should Code Reviews Be?

TODO: next section https://google.github.io/eng-practices/review/reviewer/speed.html
If not in the middle of a focused task, you should do a code review shortly
after it comes in. One business day is the maximum time it should take to
respond to a code review request. Using these guidelines a typical CL should get
multiple rounds of review within a single day.

Speed vs Interruption:
If you're in the middle of a focused task e.g. writing code, don't interrupt
yourself to do a code review.

Instead wait for a break point in your work before you review e.g. after
completing coding, after lunch, after a meeting, coming from break room.

Fast Responses:
Response time = speed of code reviews.

It's more important for individual responses to come quickly than it is for the
whole process to happen rapidly.

If you're too busy to do a full review, you can still send a quick response to
let the dev know when to expect this, suggest other reviewers, provide some
initial broad comments.

It's important that reviewers spend enough time on review that they're certain
their LGTM meant the "code meets our standard".

Cross Time Zone Reviews:
try to get back to author while they have time to respond before end of of
working hours.

LGTM with Comments:
Do this when:
- you're confident author will appropriately address all the remaining comments.
- the remaining changes are minor and don't have to be done by the dev.

The reviewer should specify which of these they intend.

Large CLs:
if the PR is so large you're unsure when you'll be able to have time to review
it, you should ask for the CL to be split into several smaller CLs. If it can't
be broken down and you don't have time to review the entire thing, then at least
write some comments on the overall design and set it back to the dev for
improvement. Always unblock the dev / enable them to take some sort of further
action quickly, without sacrificing code health to do so.

Code Review Improvements Over Time:
These guidelines means the entire code review process tends to go faster and
faster over time. Devs learn what is required for healthy code, and send you CLs
that are great from the start, requiring less and less review time. 

Don't compromise on the code review standards or quality for an imagined
improvement on velocity.

How to Write Code Review Comments
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
https://google.github.io/eng-practices/review/reviewer/comments.html

Summary: be kind, explain your reasoning, balance giving explicit directions
with just pointing out problems and letting the dev decide, ecnourage devs to
simplify code or add code comments instead of just explaining the complexity to
you.

Courtesy: be kind while also being clear and helpful in the review. Make
comments about the code and never about the developer.

Explain Why:



TODO: next https://google.github.io/eng-practices/review/reviewer/comments.html
Other resources to summarize:
TODO: https://google.github.io/eng-practices/review/reviewer/




