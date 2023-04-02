################
Dev Experience
################
:date: 2022-01-15
:category: Computer
:slug: dev_experience
:author: John Nduli
.. :status: published

I wanted to make some UI changes to my pomodoro script which I assumed were
simple. I wrote a small design doc to ensure my ideas were concrete and came up
with a smaller script that had the gist of the idea. I tried to integrate this
with the main script and things seemed ok, I'd merge the changes, until I used
it for a full day. Things were not ok. The output was broken, it would either
cut out previous lines, or look all jumbled and I didn't know what was happening
or how to fix it. I just went in and brute forced my way through the whole
script and hoped that something would work. After a few days I realized the
pains of this process because it would follow the same path:

- Make a theory on what was wrong
- Implement a solution for this
- Run the script and wait for a few seconds before I could validate my output

The waiting part was the painful bit and I think this would be better handled
with some sort of test or automation. I also hadn't properly designed the tools
I was using so they broke a lot unfortunately.

I'll be investing time in developer experience but then I also need to find out
what this is and how many angles I can look at it. Before research, what I have
is:

- It should be easy to test my changes 
- If I break something, automated testing should provide feedback
- Functions should do what they say, not some weird amalgam of this
- Regular clean up of functions and code to better understand what is happening
- Have some way of getting debug output from the program (I didn't know about
  set -x)
- Code introspection
- If something isn't automated, then it should be well documented in an easy to
  find location.
- Prefer iteration over perfection


TODO: research more of these
TODO: dev experience and how to improve this


- comic: someone doesn't respect my ideas until they get them from someone 
- comic: nice feeling I get after helping someone out
- comic: why is this so complicated, because they want money


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

.. TODO summary

Developers work in rainforests, not planned gardens
We already have tools that help us find and fix issues in existing systems e.g.
graphQL mapping for APIs using Apollo, API gateways,etc. but these assume its
possible to put all your software into one language, framework or even a single
unified stack. 

Any system of sufficient size and maturity will always involve multiple
languages and runtimes. Software is heterogenous, and until the dev community
accepts this fact, we're upper bounding how far we can get with dev experience.

Using APIs etc. means we get problems due to inconsistent data format
assumptions.

Soln: we can't see what is supposed to happen, wo we need to see what IS
happening. this means shifting our mindset and approach of monitoring to one of
observing, thus future of devex is a better experience on observability. Most
people see observability as involving logs, metrics and traces, but this is like
saying s/ware is just about manipulating assembly instructions when its actually
about building the s/ware functionality you need. Observability is about
building models of your s/ware so you can build s/ware more quickly.

So what does this all mean for designing dev experience?
we can get a grasp by looking at developer tools and companies that make it and
those that don't. The answer is design (reducing friction to help developers get
to where they need to go). This isn't prettines or user experiences like cute
error messages, notifications or dark mode, nor is it dev ergonomics (which
values moving faster and more efficiently through slick interfaces). The tools
that have been catching on are abstraction tools (e.g. hashicorp, postman,
github, heroku), which digest large parts of the rainforest that are dev's
ecosystem. To achieve this, you need to:

- Focus on the problem being solved: e.g. people focus on pillars of
  observability as logs, metrics and traces instead of goals like understand
  system behaviour or catch breaking changes. Devs may want beautiful code and
  zero bugs e.g. functional languages guaranteese but what they need is to be
  able to ship functional software on schedule.
- Focus on fitting into existing workflows: devs get how cool the tech is but
  they don't get how it helps them with their top-of-mind problems, or they
  can't reasonably transition from their workflows to completely new workflows
  e.g. choosing tool X since it works with their programming language/ingfra nd
  has slack/gh/jira integrations they want. Toolers also assume devs will switch
  to an entirely new toolchain to get relatively small set of benefits which is
  a non starter fro most teams. Instead, focus more on interoperability with
  existing dev tools and on incremental improvements that aren't a paradigm
  shift but that actually work with what exists.
- Focus on packaging and prioritization: if its a one time tool, then having
  clunky output, need to query over it and hand beautify results is ok. If its
  to be used regularly, then take the time to better package it.

Where do we go from here: Developers, buyers, the industry?
Tool creators and users assume a high learning curve, limiting the impact and
usefulness of the tools since there are alternatives that don't need to be hard
to use. It's easy to fall into polarized extremes where things are either
super-easy or hard-core. For example, we have a lot of frameworks and APIs that
are great examples of design, yet their debuggers, performance profilers and
observability/monitoring tools can't provide the same experience. We assume
complexity revealing tools are for "experts" instead of being meant to aid devs
in solving problems by revealing the necessary information. These tools can't
automate the problem away, but they can focus on providing the info to solve the
problem. The best tools combine abstraction with revealing complexity (similar
to peaking under the hood of a car, where even if you have a low-maintenance
car, it's still important if you can peek under the hood if theres a problem
without going back to the dealership).


TODO: Continue from here


Blogs to read:
https://news.ycombinator.com/item?id=23455741
https://news.ycombinator.com/item?id=24755730

https://redmonk.com/jgovernor/2022/02/21/what-is-developer-experience-a-roundup-of-links-and-goodness/
