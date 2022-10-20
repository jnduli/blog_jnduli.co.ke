################
PR Reviews Notes
################

:date: 2022-05-06
:category: Computer
:slug: pr_review_notes

Code reviews improve the health of a system while spreading ownership of code
and knowledge. A good review process is fast and we can handle low hanging
fruits by automating trivial checks (e.g. running unit tests, style choices) and
choosing style guidelines. We can have high level discussions on the changes
before coding to prevent rewrites.

Once the changes are ready, the reviewer:

- responds quickly to the review request (if not in the middle of deep work). At
  most 1 day shouldn't pass before you respond.
- checks the code and tests for
    - correctness, test coverage, functionality and best practices.
    - hard to understand code, unclear names, commented out code, untested code,
      unhandled edge cases, duplication, bad test structure
    - too many changes (if these are a lot, ask dev to split the PR).
    - comments. They should explain why not what the code is doing (comments !=
      documentation).
    - consistency
    - documentation updates.
- is kind when commenting on code. They:
    - comment on what they like in the PR (positive feedback)
    - comment on code and not the coder e.g. instead of `you're creating many db
      connections here` have `this code creates many db connections`.
    - Use questions instead of statements. Questions feel less like criticism
      and can trigger creative solutions while also assuming the author knows
      more than you do e.g:
           - `I find this confusing` becomes `Could you elaborate on how this works?`
           - `This is unmaintainable` becomes `What was your vision on maintaining this?`
    - Use I-messages instead of you-messages i.e. I suggest/think/believe/would,
      It's hard for me, For me it seems e.g. `you are writing cryptic code`
      becomes `It's hard for me to grasp what's going on in this code.`
      You-messages sound like an insinuation or an absolute statement, an attack
      to the author, and they get defensive.
    - Use we instead of I/me/you which makes comments less judgemental e.g.
      `could we change this function to do it this way?`
- ensures the dev implements explanations in code (i.e. rewrite or a comment).
  Explanations in the review tool won't help future devs.
- accepts that there are different solutions and distinguish between common best
  practices and personal taste. They are okay with compromises.
- Use the "Yes, and ... " technique to keep an innovative atmosphere. Don't
  dismiss fresh and fragile ideas in a draft PR.
- Have discussions in public, and ensure code documents these.
- is explicit about the action they want. Prefix your comments with emojis or
  the intent e.g. nit.
- Reach out to dev if they have too many comments or comments that are too long.
  This solving misunderstanding early on, which is easier and faster by
  talking.
- Have a bias for action e.g. approve a PR with minor comments.

References
============

- https://www.reddit.com/r/ExperiencedDevs/comments/u6fxbm/do_people_think_your_pr_comments_sound_arrogant/
- https://www.swarmia.com/blog/a-complete-guide-to-code-reviews/
- https://stackoverflow.blog/2019/09/30/how-to-make-good-code-reviews-better/
- https://phauer.com/2018/code-review-guidelines/
- https://google.github.io/eng-practices/review/reviewer/
