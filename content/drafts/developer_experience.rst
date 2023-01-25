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
