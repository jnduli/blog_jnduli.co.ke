###############################
Summary of How to Do PR Reviews
###############################

:date: 2022-05-06
:category: Computer
:slug: summary_of_ho_to_do_pr_reviews

From: https://www.reddit.com/r/ExperiencedDevs/comments/u6fxbm/do_people_think_your_pr_comments_sound_arrogant/

- Use we instead of I/me/you. This makes comments sound less judgemental,
  removing the implication of blame, shortcoming or that my way is right e.g. we
  may want to do things this other way, could we change this code to do it that
  way?
- Limit character count of each comment to 300, otherwise it looks like a wall
  of complaints. You can keep this wall in another document and summarize it for
  the comment, and follow up with dev if they want to talk through them.
- Use emojis, which helps communicate the intent behind your words.
- Use questions instead of statements, but don't shy from being direct if you
  already know the answer e.g:

    - I find this confusing becomes 'Could you elaborate on how this works?'
    - This is unmaintainable becomes 'What was your vision on maintaining this?'
    - This is broken, it will lose the db connection becomes 'What happens if we
      lose the db connection here?'

- Include positive feedback. If you're only complaining about the code in PRs
  then you're doing it wrong, you need to celebrate the small victories 
- Unless it's plainly obvious that something is wrong or won't work, assume the
  author knows more than I do so I mainly ask questions.


A complete guide to code reviews
--------------------------------
https://www.swarmia.com/blog/a-complete-guide-to-code-reviews/

The goals for code reviews are:

- sharing knowledge
- spreading ownership
- unifying development practices
- quality control

Best practices:

- decide on a process:
  draft PR -> ready for review -> PR reviews -> PR author merges
- focus on the right things: functionality, software design, complexity, tests,
  naming, comments, documentation. Developers shouldn't spent their time
  reviewing things that can be automatically checked.
- discuss high level approach early, preventing rewrite of PR. If PR rewrites
  happen often, its a sign you might want to talk more often before
  implementation. If a POC is needed to ignite the discussion, then start a
  draft PR of the approach and make architecture decisions based on gained
  information.
- Optimize for the team: team should understand the implications of fast reviews
  and agree on suitable max time for responding to a PR. Key is to minimize
  response lag between the author and the reviewer, even if the whole review
  process takes long. Devs shouldn't interrupt their focus to do reviews, and
  instead prioritize them when there's a fitting gap e.g. after lunch. Review is
  both the reviewer's and author's responsibility.
- Default to action: reviews can stall for various reasons, so have a bias for
  action. One can approve a PR even if there's some input left for the author to
  consider. Deciding something relatively quickly is better than slowly
  concluding an "ideal" solution, so reserve time for technical decisions but
  move on before you reach analysis paralysis. Be more inclined to merge code
  instead of focussing on punching holes in the implementation.
- Keep pull requests small 
- Foster a positive feedback culture:
    - give feedback about the code, not the author
    - pick your battles
    - accept that there are multiple correct solutions to a problem
      you're in the same boat
    - PR authors are humans with feelings
    - Use the "Yes, and ..." technique to keep an innovative atmosphere. It's
      ungracious to dismiss fresh and fragile ideas in a draft PR stage.
    - Keep feedback balanced with positive comments.
- Use CI effectively: automate quality checks allowing reviewers to focus on
  more important things like s/ware design, architecture and readability. Checks
  can include tests, test coverage, code style enforcements, commit message
  conventions, static analysis, etc.
- Delegate nit-picking to a computer e.g. code-formatting.
- Communicate explicitly:  be explicit about the action you request from the
  author.
- Use explicit review requests: set up CODEOWNERS to automate requesting a
  review, which can also be requested from a team using the same CODEOWNDERS,
  and make sure they're done evenly across the team instead of siloing these to
  a single person.
- Review your own code.
- Document as much as possible in code. If you receive a comment/suggestion, try
  to document the discussion in code, this way future devs can understand
  functionality without reading PR discussions.
- Write clear PR descriptions: you can include setup needed to test PR,
  surprising implementation details, anything that will make reviewer's job
  smoother, visual demos.
- Prefer shared repository model to the forking model.
- Keep discussions public


== Stackoverflow blog on good code reviews ==
https://stackoverflow.blog/2019/09/30/how-to-make-good-code-reviews-better/

Areas Covered by code review:
- good: cover code correctness, test coverage, functionality changes, code
  guidelines and best practices, and point out obvious improvments like hard to
  understand code, unclear names, commented out code, untested code, unhandled
  edge cases. Also not when too many changes are crammed into one review, and
  suggest keeping code changes single-purposed/breaking the change into more
  focussed parts.
- better: look at change in context of larger system, and check that changes are
  easy to maintain. Ask questions on necessity of change or how it impacts other
  parts of the system, look at abstractions introduced and how they fit into
  existing s/ware arch. Note maintainability observations like complex logic
  that could be simplified, improve test structure, remove duplication.

Tone of Review:
Reviews with harsh tone contribute to feeling of hostile env, opinionated
language turns people defensive. Professional and positive tones contribute to
more inclusive environment.
- good: open ended questions instead of strong opinionated statements. Offer
  alternatives and possible workarounds but don't insist these solns are the
  best/only way to process. Assume reviewer might be missing something and ask
  for clarification instead of correction.
- better: empathetic, know that coder spent a lot of time and effort on change.
  Kind and unassuming, applaud nice solutions and all-round positive.

Approving vs Requesting Changes:
After a review, the changes can either be approved, blocked with change requests
of without a specific status.
- good: don't approve changes while there are open-ended questions, but make it
  clear which questions/comments are non-blocking/unimportant marking them
  distinctly. Are explicit when approving a change or when requesting a follow
  up.
- Better code reviews: firm on principle but flexible on practice. Allow some
  comments to be addressed in follow-up code changes. Reviewers make themselves
  available for urgent changes.

From Code Reviews to talking to Each Other:
- TODO:



Other resources to summarize:
https://phauer.com/2018/code-review-guidelines/
https://google.github.io/eng-practices/review/reviewer/




