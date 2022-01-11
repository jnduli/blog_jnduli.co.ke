################
Celery learnings
################

:date: 2022-01-15
:category: Computer
:author: John Nduli

https://docs.celeryproject.org/en/latest/getting-started/first-steps-with-celery.html#application


python -m venv env
source ./env/bin/activate
pip install -U "celery[redis]"
systemctl start redix

Create file: task.py

.. code-block:: bash


    from celery import Celery

    app = Celery('tasks', backend='redis', broker='redis://localhost:6379/0')
        
    @app.task
    def add(x, y):
        return x + y
    
    
Start celery with: celery -A task worker --loglevel=info 

In another window create a call file with:


from task import add

add.delay(4, 4)


and run python call.py

In the terminal with celery, we should see logs like:

[2021-02-05 12:19:57,427: INFO/MainProcess] Received task: task.add[4657eaff-f560-4968-9745-d02224df7324]  
[2021-02-05 12:19:57,432: INFO/ForkPoolWorker-8] Task task.add[4657eaff-f560-4968-9745-d02224df7324] succeeded in 0.0038930379996600095s: 8


result = add.delay(3, 4)
result.ready() # tells us if result is ready
result.get(timeout=1) # sync call to get result
    
    
