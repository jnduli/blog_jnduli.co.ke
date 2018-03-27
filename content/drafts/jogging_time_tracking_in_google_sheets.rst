######################################
Jogging Time Tracking In Google Sheets
######################################
:date: 2018-03-27 19:00
:tags: projects
:category: Computer
:slug: joggin-time-tracking=in-google-sheets
:author: John Nduli
:status: draft

I go for jogging alot. However I needed a method of tracking the
various times I make that would be convenient. I tried various
android apps, but their biggest failing is that I had to carry a
bulky phone with me when going for jogging, which is a huge NOO.

So I decided to store my times using google sheets. A sample table
would look like:

+------------+---------+----------+
| A          | B       | C        |
+------------+---------+----------+
| Date       | Route   | Time     |
+------------+---------+----------+
| 2018-01-04 | Route A | 21.40.60 |
+------------+---------+----------+
| 2018-01-05 | Route A | 21.78.80 |
+------------+---------+----------+

There isn't a default function I could find that would take the
Time in my formatting and provide the average or best time. So I
had to write my own google functions.

Before doing calculations in time, it is best to convert it all to
the smallest unit you have (in my case it was milliseconds). This
is the function I came up with:

.. code-block:: javascript

    function getTimeInMicroSeconds(timeGiven) {
      var time = String(timeGiven).split('.');
      return parseInt(time[0])*60000 + parseInt(time[1])*100 + parseInt(time[2]);
    }

So to get the average of mutliple times, you just add up the
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
      return minutes+"."+seconds+"."+microseconds;
    }

To find the best time, I converted the same, but this time
maintained the index of the least time.

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



