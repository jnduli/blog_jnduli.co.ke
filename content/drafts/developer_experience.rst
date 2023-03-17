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

dev experience teams improve developer productivity by reducing friction from
suboptimal tools and processes i.e. making software engineering easier.

The journery for DevEx team follows the path:
- an existing team takes on a specific devex project e.g. Synk found that builds
  were failing 70% of the team.
- a dedicated team is formed that sits where the problem exists e.g. in one eng
  team, product vertical. This team works to solve the problem within one team
  first, and once the value is clear, scales this more broadly to the org.
- a centralized devex team is formed since the initial project deserves more
  work/support or other needs arise.
  Devex team expands their work into:
  - strategic bets: project that solve issues experienced across the org and
    result in org-wide productivity gains
  - support requests from other devs
  devx team runs risk of becoming an everything dept since many problems
  surfaced are not owned by any other teams, and they may slip into treating
  their backlog like a roadmap instead of proactively prioritizing work that'll
  have the biggest impact on the organization.
- DevX team sets a charter and roadmap, and proactively identifies top needs
  across the organisation. It will eventually create a formal process for
  identifying and prioritizing strategic work as well as for managing support in
  a way that does not interfere with the teams strategic bets.

How DevEx teams prioritize strategic work:
can use surveys, in-context feedback (tool like slackbot/browser plugin that
asks for feedback when dev uses a tool), ask/feedback channels (e.g. slack
channel), office hours, 1:1 interviews, customer advisory boards,
embedded/shadowing (devs work alongside devs to better understand what they're
experiencing).
Team considers:
- is issue isolated to specific team or systemic across organisation? There are
  things team can change e.g. tools, tests, builds, environments, documentation
  and things they can influence e.g. issues isolated to specific teams.
- Which dev persona do we need to serve? e.g. prioritize work for teams on
  mission critical projects.
- What level of ongoing work will this problem require moving forward? e.g. new
  tool requires support and maintenance, documentation needs coaching on how to
  write or find it, tech debt can need focus on preventing high interest tech
  debt long term.
- What is the cost of this problem? Expected gain to the company( and try to
  calculate the expected boost in productivity), cost of time wasted( take avg
  eng salaray, multiply by 1.5X to get cost per minute/hour, then multiply this
  time by the amount spent waiting, redoing, conktext switching within a part of
  development process), cost of delayed investment (if the problem costs the org
  an avg of 400K per week, we can calculate the cost of not investing in the
  problem for 5 months).

How devex teams get adoption for tools or processes?
before releasing for general availability:
- identify early adopters
- release a prototype to early adopters
- get feedback on change from users

interesting tactics for getting adoption:
- all hands meetings, show-and-tell meetings
- events like hackdays
- community: create a place where people can learn about the work and talk with
  other users.
- embedding: devx team member joins a team for a sprint and helps adoption
- showcase team/internal champion: have a team using the tool share their case
  study on the benefits
- build the golden path: build tool into automated processes for common tasks.

If the change isn't catching on, its possible the team missed something in their
research with regards to pain points experienced.

The Case For Developer Experience
---------------------------------
https://future.com/the-case-for-developer-experience/
What's holding back devex is that most of the conversations around developer
experience are about how to make it easier to write new code, in a vacuum, when
in reality most devs are writing new code that needs to play well with old code,
which goes beyond the obvious complaints of tech debt, lack of explainability
and other issues. There are 2 categories of tools, thus 2 categories of devex
needs:
- abstraction tools (assume we code in a vaccuum)
- complexity exploring tools (assume we work in complex environs)

the dark side of abstreaction is that at some point you need to cross the
abstraction barried e.g. reach inside the db, and different problems require
different abstractions.

It's empowering to the dev to help explore and embrace existing complexity,
rather than introduce more complexity when trying to automate things away.

Developers work in rainforests, not planned gardens
TODO: Continue from here


Blogs to read:
https://news.ycombinator.com/item?id=23455741
https://news.ycombinator.com/item?id=24755730

https://redmonk.com/jgovernor/2022/02/21/what-is-developer-experience-a-roundup-of-links-and-goodness/
