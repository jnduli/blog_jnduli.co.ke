##########################################################
VueJS Djanog APP part 3 : linking up server with front end
##########################################################

:date: 2018-03-04 15:00

Install axios and axios-mock-adapter

.. code-block:: bash

    npm install --save axios
    npm install --save-dev axios-mock-adapter


I modify the main code to work with axios:

.. code-block:: javascript

    File: Todo.vue
    created () {
      this.getServerTask()
    },
    
The getServerTask method is defined in the methods group:

.. code-block:: javascript

    getServerTask () {
      axios.get('http://localhost:8000/system')
        .then(response => {
          console.log(response)
          this.tasks = response.data
        })
    }

Also import axios library at the top of the scripts section:

.. code-block:: javascript

    import axios from 'axios'

When I run it I get the following error in the console:

.. code-block:: bash

    Cross-Origin Request Blocked: The Same Origin Policy disallows reading the remote resource at http://localhost:8000/system. (Reason: CORS header ‘Access-Control-Allow-Origin’ missing).


To fix this, I have to enable this in my django server. First I
install django-cors-headers and enable it based off the
instructions found `here <https://github.com/ottoyiu/django-cors-headers>`_

For its configuration, I just added this to the bottom of django's
settings file:

.. code-block:: python

    CORS_ORIGIN_ALLOW_ALL = True




Modify the test to use the axios-mock-adpater.



