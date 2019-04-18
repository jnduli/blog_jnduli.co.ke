########################
VueJS Django ToDo Part 2
########################

:date: 2019-03-04


I start creating the django backed. To do this I first set up a
virtual environment.

.. code-block:: bash

    python -m venv .env

Then source the virtual environment.

.. code-block:: bash

    source .env/bin/activate


Install some python packages required and freeze them for use
later on.

.. code-block:: bash
    
    pip install django djangorestframework
    pip freeze > requirements.txt


Then create a new django project.

.. code-block:: bash

    django-admin startproject todo

This creates a folder named todo. Cd into that folder and start a
new django app using:

.. code-block:: bash

    python manage.py startapp tasks


Open up the todo/settings.py and edit the INSTALLED_APPS array to
include 'rest_framework' and 'tasks'

.. code-block:: python

    INSTALLED_APPS = [
        'django.contrib.admin',
        'django.contrib.auth',
        'django.contrib.contenttypes',
        'django.contrib.sessions',
        'django.contrib.messages',
        'django.contrib.staticfiles',
        'rest_framework',
        'tasks',
    ]

Now to start off create some tests. 

.. code-block:: python

    File: tasks/tests.py

    from django.test import TestCase
    from django.urls import reverse
    from rest_framework import status
    from rest_framework.test import APITransactionTestCase
    from tasks.models import Account
    # Create your tests here.

    class TasksTest(APITransactionTestCase):
        def test_task_created(self):
            """
            Ensure we can create a new account object.
            """
            url = reverse('task-list')
            data = {
                    'name': 'create the server code',
                    'description' : 'this is so that the app has a backed',
                    'done' : False
                    }
            response = self.client.post(url, data, format='json')
            self.assertEqual(response.status_code, status.HTTP_201_CREATED)
            self.assertEqual(Task.objects.count(), 1)
            self.assertEqual(Task.objects.get().name, 'create the server code')
            return

        def test_task_deleted(self):
            return

        def test_task_completed(self):
            return

This fails with the following error:

.. code-block:: bash

   ImportError: cannot import name 'Task'

To fix this, create the model and run the test again.

.. code-block:: python

    from django.db import models

    # Create your models here.
    class Task(models.Model):
        name = models.CharField(max_length=200)
        description = models.TextField(null=True)
        done = models.BooleanField(default=False)

The error got after this is : no such table: tasks_task
To fix this:

.. code-block:: bash

    python manage.py makemigration
    python manage.py migrate


The next error got after this is: Reverse for 'task-list' not
found. To fix this:

.. code-block:: python

    File: todo/urls.py
    from django.conf.urls import url, include
    from django.contrib import admin

    urlpatterns = [
        url(r'^admin/', admin.site.urls),
        url(r'^/', include('tasks.urls')),

.. code-block:: python

    from django.conf.urls import url
    from tasks import views

    urlpatterns = [
            url(r'^system/', views.index, name='task-list'), 
            ]

With this, the error that appear is an implementation error. To
start implementation, first create a serializers class.

.. code-block:: python

    from rest_framework import serializers
    from tasks.models import Task

    class TaskSerializer(serializers.ModelSerializer):
        class Meta:
            model = Task
            fields = ('id','name','description','done')

To implement the serializer class, I use django rest frameworks'
generec views:

+ ListCreateAPIView: lists items and also can create a new item
+ RetrieveUpdateDestroyAPIView: get an item, update it and delete
  it

.. code-block:: python

    from tasks.serializers import TaskSerializer
    from tasks.models import Task
    from rest_framework import generics

    # Create your views here.

    class TaskList(generics.ListCreateAPIView):
        queryset = Task.objects.all()
        serializer_class = TaskSerializer

    class TaskDetail(generics.RetrieveUpdateDestroyAPIView):
        queryset = Task.objects.all()
        serializer_class = TaskSerializer


With this the test code runs successfully. I also add more tests
for deleting and completing a task.

.. code-block:: python

    from django.test import TestCase
    from django.urls import reverse
    from rest_framework import status
    from rest_framework.test import APITransactionTestCase
    from tasks.models import Task
    # Create your tests here.

    class TasksTest(APITransactionTestCase):
        fixtures = ['tasks/tasks.json']
        def test_task_created(self):
            """
            Ensure we can create a new task object.
            """
            self.assertEqual(Task.objects.count(), 4)
            url = reverse('task-list')
            data = {
                    'name': 'create the server code',
                    'description' : 'this is so that the app has a backend',
                    'done' : False
                    }
            response = self.client.post(url, data, format='json')
            self.assertEqual(response.status_code, status.HTTP_201_CREATED)
            self.assertEqual(Task.objects.count(), 5)
            self.assertEqual(Task.objects.get(name='create the server code').description, 'this is so that the app has a backend')
            return

        def test_task_deleted(self):
            #  Ensure we can delete a task 
            number = Task.objects.count()
            url = reverse('task-detail', args=[1])        
            response = self.client.delete(url)
            self.assertTrue(status.is_success(response.status_code))
            self.assertEqual(Task.objects.count(), number-1)
            return

        def test_task_completed(self):
            url = reverse('task-detail', args=[3])
            response = self.client.get(url)
            self.assertEqual(response.data, {'id': 3, 'name':'finish system', 'description': None,  'done' : False})

            response = self.client.patch(url, {"done":True})
            self.assertEqual(response.data, {'id': 3, 'name':'finish system', 'description': None,  'done' : True})
            return


In the tests, there is a fixture. This setup the database to use
some predefined data.

.. code-block:: json

   File: tasks/tasks.json
   [
       {
           "model" : "tasks.task",
           "pk" : 1,
           "fields" : {
               "name" : "play football",
               "description": "helps keep me fit",
               "done" : true
           }
       },
       {
           "model" : "tasks.task",
           "pk" : 2,
           "fields" : {
               "name" : "sing attention",
               "description" : "This improves my ambition",
               "done" : false
           }
       },
       {
           "model" : "tasks.task",
           "pk" : 3,
           "fields" : {
               "name" : "finish system",
               "done" : false
           }
       },
       {
           "model" : "tasks.task",
           "pk" : 4,
           "fields" : {
               "name" : "clean utensils",
               "done" : false
           }
       }
   ]


With this the server works well enough. I can now tag this as
another version.

.. code-block:: bash

    git tag v0.0.2

Next up is linking the server code and the vue front end together.

