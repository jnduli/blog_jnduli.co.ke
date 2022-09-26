###############################
Summary of How to Do PR Reviews
###############################

:date: 2022-05-06
:category: Computer
:slug: summary_of_ho_to_do_pr_reviews

Plan
====
- DONE: Summarize code review guidelines for humans
- DONE: Summarize google code eng review guide
- DONE: Summarize reddit review summary: 100 words
- DONE: Summarize swarma review summary: 200 words -> reached 301
- DONE: Summarize stackoverflow review summary: 200 words -> reached 680
- DONE: Summarize code guidelines for humans summary: now 800 words -> 652 words
- DONE: Summarize google code eng review guide: 2223 -> 1232 words
- Create first article draft from summaries


Draft
-----
.. # Mostly from swarmia
PR reviews are a way to improve the code health of a system, while also sharing
knowledge and spreading ownership of code.

The review process should be fast to be efficient, so automate trivial checks
and have style guidelines to remove the easy checks out of the way. High level
discussions need to happen before the PR to prevent rewrites (make a POC to
spark the discussion if necessary).

The reviewer should:

- provide feedback on code, not the author.
- accept there are many solutions to a problem
- be aware that the PR author is human.
- Use the "Yes, and ... " technique to keep an innovative atmosphere. Don't
  dismiss fresh and fragile ideas in a draft PR.
- Have positive comments.
- Have discussions in public, and ensure code documents these.
- Be explicit about the action you want.
- Fast reviews (Needs a separate paragraph)
- Have a bias for action e.g. approve a PR with minor comments.


Author should ensure:
- clear PR descriptions with test set up, surprising implementation details and
  visual demos added.






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
ref: https://google.github.io/eng-practices/review/reviewer/

Reviews ensure code health is improving over time. Devs can submit improvements
and reviewers should make it easy for these changes to get in, while ensuring
code health is improving.

Reviewers should favor approving a PR once it improves the code health of the
system even if it isn't perfect.

Mentoring: leave comments that teach dev but prefix with "nit:"
Resolving conflict: prefer face-to-face to get a consensus, and record the
    result in a PR comment.

What do you look for in a PR:

- design: interactions of code pieces, does change belong to code/library
- functionality: edge cases, concurrency problems, bugs, validate UI changes.
- complexity: complex code isn't quickly understood and bugs can be introduced
  when modified. Check for over-engineering (e.g. code is too generic, has
  functionality that isn't needed)
- Add tests in the same PR as code. Tests are correct, sensible and useful, are
  separated appropriately, are simple (tests are maintained too).
- naming: are long enough to communicate what it does without being so long that
  it's hard to read.
- comments: are they all necessary? Comments should explain why the code exists
  not what it's doing. Comments aren't documentation for classes, modules,
  functions which instead express purpose of piece of code, how it's used and
  how it behaves.
- Style: CL should follow style guides. Prefix style comments with nit.
- Consistency: maintain consistency with existing code.
- Documentation: PR updates relevant documentation e.g. READMEs. If it
  deletes/deprecates code, the docs should be deleted. Ask for missing docs.
- Every line: look at every line of code. If something is too hard, notify the
  dev. If you understand the code but aren't qualified for some parts, make sure
  there's a reviewer on the PR that's qualified.
- Context: look at PR in broader context (e.g. whole file instead of just the 2
  lines changed) or PR in the context of the whole system. Does it improve the
  health or degrade it?
- Tell the dev when you see something good in a PR e.g. they addressed a comment
  in a great way. Appreciate and encourage good practices.

To navigate a PR:

- see if the change makes sense and has a good description. If not, explain
  immediately why and suggest alternatives e.g. Looks like you put some good
  work into this, thanks, but we're actually going in the direction of removing
  this Widget system that you're modifying here and so we don't want to make any
  new changes to it right now. How about you refactor BarWidget class?
- if above happens a couple of times, consider changing the team's dev process
  because it's better to tell someone no before they've put in a lot of work.
- start with the most important part of the change, and see if it's well
  designed. This gives context of the other changes and accelerates review. If
  you can't figure this out, ask the dev and suggest they split up the PR into
  multiple ones. Immediately comment on errors in this major part, even if you
  don't review other changes.
- go to other parts of PR in proper sequence.

Slow code reviews:

- reduce team velocity.
- cause protests with the review process (e.g. we have strict reviewers)
  especially when someone responds after some days and requests major
  changes. Quick responses make the complaints disappear.
- reduce code health since devs submit PRs that aren't as good as they could be,
  discourage code cleanups and refactors and code improvements.

If not in the middle of deep work, respond to a review request shortly after it
comes. One business day is the max time to respond to a review request, and
typically multiple rounds of review occur in a single day.

Don't interrupt yourself to do a review, but use break points for these e.g.
after lunch, after a meeting, coming from break.

Response time = speed of code reviews.

It's important that reviewers spend time on review s.t. their 'LGTM' means the
code meets our standard. If you're too busy to do a full review, you can send
quick responses to let the dev know when to expect this, suggest other reviews
and provide initial broad comments. If working across time zones, try to get
back to author while they still have time to respond.

Have LGTM with comments when you're confident the author will address all the
remaining comments or the remaining changes are minor, and specify which of
these you mean.

Request for large PRs to be split. If it can't be split and you don't have time
to review, then at least comment on the overall design. Always unblock the dev
and enable them to take some sort of further action quickly.

Improving the quality of PRs and their speed leads to a feedback loop where devs
learn what's healthy code and send PRs that are great from the start, needing
less and less review time. Don't compromise on review standards for an imagined
improvement on velocity.

When writing review comments:
- be kind while being clear and helpful. Comment on the code and not the
  reviewer e.g. "why did you use threads here where there's obviously no benefit
  to be gained from concurrency" is bad, and can be rephrased as "The
  concurrency model here is adding more complexity to the system without any
  actual performance benefit that I can see. Because there's no performance
  benefit, it's best for this code to be single-threaded instead of using
  multiple threads."
- Explain why sometimes when you want to give your intent, the best practices or
  how the suggestion improves code health.
- Balance giving explicit directions (helps get PR in best condition) and
  pointing out problems (this helps the dev learn, making future reviews easier
  and can lead to better solns since the dev is closer to the code).
- Comment on things you like in the PR and why you liked them.
- Consider labelling your comments to differential guidance from suggestions
  e.g. nit, optional, FYI, helping the author prioritize comments and avoid
  misunderstandings (e.g. all comments need to be addressed).
- If you ask for an explanation, this should result in a rewrite or a comment
  added in the code. Review tool only explanations don't help future code
  readers and are only ok when its an area of code you aren't familiar with.

If a dev disagrees with a suggestion, consider they may be right, since they're
closer to the code, and if so let them know this and drop the issue. If not,
explain your beliefs further and demonstrate both an understanding of the dev's
reply and any extra info on why the change was made. It might take a few
back-and-forths for this, so be polite and let dev know that you hear them but
don't agree.

Reviewers can believe they'll upset the dev if they insist on an improvement,
but upsets are more about how they write the comments than the insistence on
code quality.

Its best to insist that some clean up happens in the current PR or create a bug
for the clean up and assign it to the dev. If not, the clean up won't happen
since it gets forgotten while doing other work.

If you switch from lax to strict reviews, some devs will complain, but improving
the speed of reviews will cause these complaints to stop.
