######################################
Jogging Time Tracking In Google Sheets
######################################
:date: 2018-03-31 19:00
:tags: projects
:category: Computer
:slug: joggin-time-tracking=in-google-sheets
:author: John Nduli
:status: published

I jog frequently. I needed to track the various times I spend
jogging my various routes. There are pretty awesome android apps
for this but carrying a phone with me while jogging did not work.
I was ok with a wrist watch though. So I jog and afterwards store
the time and route taken in google sheets. A sample table would
look like this:

+------------+---------+----------+
| A          | B       | C        |
+------------+---------+----------+
| Date       | Route   | Time     |
+------------+---------+----------+
| 2018-01-04 | Route A | 21.40.60 |
+------------+---------+----------+
| 2018-01-05 | Route A | 21.78.80 |
+------------+---------+----------+

It becomes hard to gain insight into this table if it becomes too
long. So I needed a method of getting basic metrics from this
data. This was the average times I spend on a route and the best
time recorded on a route.

I could not find a function I could easily use to get this
information. This was because I store my times in a weird format,
that is Minutes.Seconds.Centiseconds. I used this because it is
what my wrist watch gave me. So I had to write my own custom
functions.

Before doing calculations in time, it is best to convert it all to
the smallest unit you have (in my case it was centiseconds). This
is the function I came up with:

.. code-block:: javascript

    function getTimeInMicroSeconds(timeGiven) {
      var time = String(timeGiven).split('.');
      return parseInt(time[0])*6000 + parseInt(time[1])*100 + parseInt(time[2]);
    }

So to get the average of a group of times, you just add up the
times in milliseconds, then find the average in milliseconds, and
convert the average back to minutes, seconds and hours. To do
that:

.. code-block:: javascript
    function AVERAGETIME(input) {
      if (!input.map) //test if it is not an array
        return input
    
      var total_time = 0;
      var total = input.length;
    
      for (var i =0 ; i<total; i++){
        var time = getTimeInMicroSeconds(input[i]);
        total_time += time;    
      }
  
      var average_time = Math.floor(total_time/total);
      var microseconds = average_time % 100;
      var seconds = Math.floor(average_time/100) % 60;
      var minutes = Math.floor(average_time/60000);
      return correctSizeString(minutes,2)+"."+correctSizeString(seconds,2)+"."+correctSizeString(microseconds,2);
    }

The function correctSizeString just ensures the times are
appropriately sized e.g. instead of showing 6 in seconds time, it
will show 06.

To find the best time, I came up with this function:

.. code-block:: javascript

    function BESTTIME(input) {
      if (!input.map)
        return input;
 
      minimum_time = Infinity;
      index_minimum = -1;
  
      for (var i=0; i<input.length; i++) {
        var time = getTimeInMicroSeconds(input[i]);
        if (time < minimum_time){
          minimum_time = time;
          index_minimum = i;
        }
      }
      return input[index_minimum];
    }


And this is one of the functions I use to get average time:

.. code-block:: javascript

   =AVERAGETIME(FILTER($C$2:$C,$B$2:$B=$E2))

The function filters the input based on what is in row B (which is
the route) and finds the average of the times of a particular
route.

The complete script can be viewed from this `gist <https://gist.github.com/jnduli/9805e638c5da083070df033592fb1b13>`_.
