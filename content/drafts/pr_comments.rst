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



TODO: look at this: https://www.swarmia.com/blog/a-complete-guide-to-code-reviews/
