###################################
Project Management in Google Sheets
###################################

:date: 2017-12-16 08:00
:category: Computer
:slug: project-management-in-google-sheets
:author: John Nduli
:status: draft

Outline of Project
==================
I wanted a google sheet file that could manage simple projects.
This meant that it could track tasks, send notifications when
tasks were late and differentiate done, undone and late tasks when
the file was opened and editted. To do this, I decided to research
into Google Sheets Scripts, which ended up being a powerful tool
that I could use to achieve my means.

Sending notifications for Late Tasks
------------------------------------
For this I first had to set a trigger. There are 2 methods of
doing this that I know of currently:

+ Using the menu bar by going to:
  Edit > Current project's triggers > Add a new trigger
+ Programmatically by creating a function and running it once.

I went with the programmatic way because this would enable me to
easier set it up on other sheets.

So assuming there is a function called mainFunction, I write the
following trigger:

.. code-block:: javascript

    function createTimeDrivenTriggers() {
      ScriptApp.newTrigger('mainFunction')
          .timeBased()
          .everyDays(1)
          .create();
    }

This will run the function 'mainFunction' once per day. To
activate the trigger, click on Run >> Run Function >>
createTimeDrivenTriggers. The trigger can now be seen in the
triggers list menu. When running the trigger for the first time, a
page will pop up requesting for some permissions to be allowed.

To send a mail using the script is also fairly easy. Since the
project sheet might have may participants, I set up a function
that sends emails to an array provided to it with a particular
message.

.. code-block:: javascript

    function sendEmail(emails, message, subject){
      for (var i=0; i<emails.length; i++){
        MailApp.sendEmail(emails[i], subject, message);
      }
    }

The emails are set in a sheet called 'lookup'. So once the script
loops through all the sheet and once the sheet with the name
'lookup' is found, the following script runs:

.. code-block:: javascript

    function getEmailsToNotify(data) {
      var emailCol = getColumnByName(PropertiesService.getScriptProperties().getProperty('EMAILS_COLUMN'), data);
      var emails = [];
      if (emailCol < 0)
        return emails;
      for (var i=1; i<data.length; i++) {
        var email = data[i][emailCol];
        if (email.trim() !== ''){
          emails.push(email);
        }
      }
      return emails;                 
    }

For my script, the preconditions I set for it to be able to run
was that the first row should have the following names in the
various cells:

+ Features
+ Status
+ DateDue

This means that each sheet has to follow this pattern. To do this
I wrote the following script:

.. code-block:: javascript

    function getColumnByName(colName, data) {
      var col = data[0].indexOf(colName);
      return col;
    }

    function getNotificationsFromSheet(range) {
      var data = range.getValues();
      var dateDueCol = getColumnByName('DateDue', data);
      var featuresCol = getColumnByName('Features', data);
      var statusCol = getColumnByName('Status', data);
      if (dateDueCol < 0 || featuresCol < 0 || statusCol < 0 ){
        return ["error : Sheet does not follow expected format"];
      } else {
        messages = getLateDateDues(dateDueCol, statusCol, featuresCol, range);
        return messages;
      }
      // checkLateDateDues(dateDueCol, statusCol, featuresCol, data);
      // return ['this is cool', 'this is another one', 'I love this'];
    }


The function getColumnByName checks the first row for any
columnName provided to it. If a columnName is not found it returns
-1. So in the function getNotificationsFromSheet, we check for the
3 cells, and if there is any that is missing and error is
returned.

The getLateDateDues function just loops through all the dates
comparing them to the current date. If any date is late and its
status is not 'done', it adds this to the messages for alerting
and also colors that particular row red.

.. code-block:: javascript

    function getLateDateDues(dateDueCol, statusCol, featuresCol, range) {
      // loop through the date due column only
      var data = range.getValues();
      var dateNow = new Date();
      var messages = [];
      for (var i =0; i<data.length; i++) {
        var dateDue = new Date(data[i][dateDueCol]);
        var rowRange = range.offset(i, 0, 1);
        if (dateNow > dateDue && data[i][statusCol] !== 'done'){
          messages.push(data[i][featuresCol] + ' was due on ' + dateDue);
          rowRange.setBackground('#ffcdd2');
        }
      }
      return messages;
    }

You can find a copy of the complete gist `here:late <https://gist.github.com/jnduli/ad6ef7e12715c63a6d933368e0c61be0>`_

Changing Colors while Editting
------------------------------


While editing the file, you also need to get some visual feedback
on deadlines and errors. To do this, google sheets provides simple
triggers that help out. For example, you can try this out:

.. code-block:: javascript

    function onEdit(e) {
      Logger.log('The sheet has been editted');
    }

If you save this, and edit any cell on the sheet, you will see
that message on the logger. To access the logger : View > Logs

The first thing to check for is if the editted cell belongs to the
DateDue or status column. To do this, you need to get the
activeSheet and the DataRange.

.. code-block:: javascript

   function onEdit(e) {
       var activeSheet = e.source.getActiveSheet();
       var sheetName = activeSheet.getDataRange();
       var range = activeSheet.getDataRange();
   }

Then we can get the column editted and row editted. Note that
e.range.getColumn() and e.range.getRow(), start their indexes at
1, so to work properly with arrays we need to subtract 1 from the
values we get.

.. code-block:: javascript

    function editTasksSheet(range, e){
      var data = range.getValues();
      var columnEditted = e.range.getColumn()-1;
      var rowEditted = e.range.getRow()-1;
      var valueInput = data[rowEditted][columnEditted];
      var dateDueCol = getColumnByName('DateDue', data);
      var statusCol = getColumnByName('Status', data);
      if (dateDueCol < 0 || statusCol < 0){
        return;
      } else if (columnEditted === dateDueCol) {
        var rowRange = range.offset(rowEditted, 0, 1);
        // var dateInput = data[rowEditted][columnEditted];
        formatBasedOnDate(rowRange, valueInput);
      } else if (columnEditted === statusCol) {
        if (valueInput === 'done') {
          var rowRange = range.offset(rowEditted, 0, 1);
          rowRange.setBackground('#c8e6c9');
        } else {
          formatBasedOnDate(rowRange, data[rowEditted][dateDueCol]);
        }
      }
    }


From the above code snippet, we first look for the columns named
'DateDue' and 'Status'. If they are not existent, the script stops
working ans the sheet is not editted properly. Afterwards we just
format the sheet appropriately based off this:

+ If the date input is older than the current date, color the row
  red since it is a late task
+ If date input is later than current task, rest the background
  color to white.
+ If status input is done, color the row green
+ If status is something other than done, do the date formatting.

The completed file can be found in the following gist `here:edit <https://gist.github.com/jnduli/ad6ef7e12715c63a6d933368e0c61be0>`_
