################
Dev Experience
################
:date: 2022-01-15
:category: Computer
:slug: dev_experience
:author: John Nduli
.. :status: published


Developer experience makes software development easier. This includes:

- clear documentation on how to set up.
- clear documentation on manual steps and links to non-obvious solutions
- support for debug-mode to help introspection.
- automated testing.
- well designed code, which covers a lot but at least have:
    - functions do what they say they do
    - comments in complicated function
- provide a fast way to manually test changes (e.g. see UI changes while I'm
  developing)

I've found my personal projects suffer from having poor developer experience.
Any time I've had to fix a bug or move a service to another server, I experience
`a lot of frustration
<https://comics.jnduli.co.ke/pub/looking-at-something-i-set-up-some-years-back/>`_.

For example, I wanted to change the UI of my pomodoro script to include colors,
some way of marking tasks as done or cancelled and better messaging. I spent too
much time figuring out how the original script worked and when I made the
changes, the output broke. It took me a long time to clean this up, but it still
was a mish-mash of fixes and I'm not confident the next improvement have a
better experience. The biggest problem was that I didn't have any sort of
automated tests that would tell me early on that I'd broken something, and I
instead had to run the tool for this (It doesn't help that this was in bash).

I set up my first server without documentation. It involved a lot of trial and
error, which means I don't know everything I installed there, what's required
and what's was an optional experiment. It's running fine but it's frustrating to
migrate away to a more structured. A better way would have been to document this
in ansible, with clear comments explaining why I needed some tool.

It's hard to get a good developer experience from the get-go, especially when
prototyping. This provides a good practice ground for this though, where I can
document that what I'm doing is a prototype and try to provide verbose
documentation so that I'm able to build up on it when I'm done with my POC,
rather than bang my head trying to get the context of a lot of things. I'd argue
that documentation should be the bare minimum for all projects, even the
prototypes I make.


.. TODO: add other examples


Lead Dev Notes
^^^^^^^^^^^^^^
https://leaddev.com/productivity-eng-velocity/what-developer-experience-team

Dev experience teams make software engineering easier. The teams are created by:

- a team takes on a specific devex project e.g. builds fail 70% of the time.
- a dedicated team is formed that sits where the problem exists. It solves the
  problem first within one team, and once value is clear, scales this more
  broadly to the organisation.
- a centralized devex team is formed since more work/support is needed for
  initial project or other needs arise.

The devex team runs the risk of becoming an `everything` team since a lot of the
problems aren't owned by other teams, and they may slip to treating their
backlog like a roadmap rather than prioritizing work that'll have the biggest
impact on the org.

Devex team works on strategic bets (projects that solve issues experienced
across the org and result in org-wide productivity gains) and support requests
from other devs.

The team sets a charter and a roadmap, and proactively identifies top needs
across the org and later on formalizes the process for finding and prioritizing
strategic work as well as managing support in a way that doesn't interfere with
the strategic bets.

The team collects feedback through surveys, in-context feedback (like
slackbot/browser plugin that asks for feedback when dev uses a tool), feedback
channels like slack channels, office hours, 1:1 interviews, shadowing devs, etc.

It considers the following while prioritizing strategic work:

- Is the issue isolated to one team or organization wide?
- Which dev persona needs to be served, and prioritize teams that are on mission
  critical projects.
- What level of ongoing work does the problem require, like support,
  maintenance, documentation, coaching.
- What is the cost of the problem, and the expected gain to the company? A
  simple way to do this is to get 1.5X average dev salary to get cost per
  minute/hour, then multiply this by the amount spent waiting, redoing, context
  switching within development process. Another is cost of delayed investment
  e.g. if the problem costs 400K per week, we can calculate the cost of not
  investing in this for 5 months.

Before releasing for general availability find early adopters and release a
prototype to them so that you get feedback.

In order to get wider adoption:

- all hands meeting, show-and-tell meetings, events like hack-days
- create a place where devs learn and discuss the work (community)
- embedding: devx team member joins a team for a sprint to help with adoption
- showcase an internal champion e.g. a team that uses the tool shares their use
  case and the benefits.
- build the tool into automated processes for common tasks.

If the change isn't catching on, its possible the team missed something in their
research with regard to pain points experienced.

.. TODO: further summary
The Case For Developer Experience
---------------------------------
https://future.com/the-case-for-developer-experience/

Most discussion on devex is about how to make it easier to write new code, which
doesn't usually include how to make new code play well with old code. There are
2 major categories of tools and hence devex:
- abstraction tools (assume we code in a vaccuum)
- complexity exploring tools (assume we work in complex environs)

With abstraction, you will need to cross the abstraction barrier at some point
e.g. query the db in an ORM.

Most systems have many languages and runtimes, yets most tools help and fix
issues that assume one language and framework. We should focus on observability
(not only logs, metrics and traces), which is building the models of your
software so you can build s/ware faster.

Looking at tools that make it like hashicorp, postman, github, the solution is
design, where we reduce friction. This isn't prettiness or user experience like
cute error messages or dark mode, not is it dev ergonomics, but rather digesting
large parts of the rainforest that's dev's ecosystem.

To achieve this:

- focus on the problem being solved e.g. don't look at logs, metric and traces
  only but also system behaviour or catching breaking changes, functional
  languages are ok but the goal should be to ship functional software on time.
- focus on fitting into existing workflows: If they can't get how it helps with
  their top of mind problems or can't reasonably transition to it, then its a
  non-starter e.g. slack/gh/jira integrations, integrates with language/infra.
- focus on packaging/prioritization i.e. output, query, beautiful results.


.. TODO summary


Blogs to read:
https://news.ycombinator.com/item?id=23455741
https://news.ycombinator.com/item?id=24755730

https://redmonk.com/jgovernor/2022/02/21/what-is-developer-experience-a-roundup-of-links-and-goodness/
