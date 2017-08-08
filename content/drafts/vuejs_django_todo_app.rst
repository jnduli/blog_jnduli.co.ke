#####################
VueJS Django TODO App
#####################
:date: 2017-06-28 15:00
:tags: asus, archlinux, linux
:category: Computer
:slug: vuejs-django-todo-app 
:author: John Nduli
:status: draft

Setup
=====

First install npm:

.. code-block:: bash

    sudo pacman -S npm
    npm install --global vue-cli

THen go to the folder with the vue js project and do:

.. code-block:: bash

    vue-init webpack todo_app

Then choose the defaults for most of the options. These include:

.. code-block:: bash

    ? Project name todo_app                
    ? Project description To do app with django backend                            
    ? Author John Nduli <yohanaizraeli@gmail.com>                                  
    ? Vue build standalone                 
    ? Install vue-router? Yes              
    ? Use ESLint to lint your code? Yes    
    ? Pick an ESLint preset Standard       
    ? Setup unit tests with Karma + Mocha? Yes                                     
    ? Setup e2e tests with Nightwatch? Yes 





Then to run the default app do:
.. code-block:: bash

    cd todo_app                       
    npm install                       
    npm run dev 






I will use `MUIcss <https://www.muicss.com/>`_ for my styling so
to include it, I open the index.html file and include the MUI
boilder plate, and create a simple vue component in the
src/components folder.

.. code-block:: bash

   Filename: src/components/todo.vue
   <template>
    <div class="mui-container">
      <div class="mui-panel">
        <h1>{{ msg }}</h1>
        <button class="mui-btn mui-btn--primary mui-btn--raised">My Button</button>
      </div>
    </div>
   </template>
   <script>
   export default {
    name: 'todo',
    data () {
      return {
        msg: 'This should be really good'
      }
    }
   }
   </script>


I then add this to the router file in src/router/index.js:

.. code-block:: bash

    import Vue from 'vue'
    import Router from 'vue-router'
    // import Hello from '@/components/Hello'
    import Todo from '@/components/Todo'

    Vue.use(Router)

    export default new Router({
      routes: [
        {
          path: '/',
          name: 'todo',
          component: Todo
        }
      ]
    })

Now the page loads containing the new elements. However, there is
still this Vue logo. To remove it, open the src/App.vue file and
delete the line containing the <img> tag.

Basic Tests
===========

Next is to add some functional tests to the project. To do this,
go to the test/e2e/specs folder and add the following tests in
todo_tests.js

.. code-block:: javascript

    module.exports = {
      'default e2e tests': function (browser) {
        const devServer = browser.globals.devServerURL

        browser
        // Sam visits the page
          .url(devServer)
          .waitForElementVisible('#app', 5000)
        // He sees the title todo
          .assert.elementPresent('.todo')
          .assert.containsText('h2', 'Todo App')
        // He sees some previous tasks he had set up on the app
        // He decides to add another task
        // The task is for baking a cake
        // He clicks the add task button and types in the words
        // Bake a cake
        // He adds a time line and date for the task
        // He then clicks on OK
        // The task is added at the bottom of the list
        // Sam also sees the task do homework
        // He has completed this task, so he clicks on task completed
        // The task changes status to done
        // He also wants to see how may tasks are not done
        // He clicks a done button at the top and only tasks done are shown
        // HE also aclikcs a not done at the top and tasks not done are shown
        // He sees another task: fix tv which he does not want to do
        // He clicks a button and the task is removed

          .end()
      }
    }


When you run:

.. code-block:: bash

    npm run test

from the terminal, you will get some failed tests. This is because
the original test provided fails with this one too. To fix this
one, remove the original test ie. tests.js from this file. To fix
the other test, some code change has to occur.

I add another functional test to check if tasks are present.

.. code-block:: javascript

    // He sees some previous tasks he had set up on the app
    .assert.elementCount('.task', 3)
    .assert.containsText('.task h4:first-of-type', 'task A')

When I run the test again, it fails, so I add code to make the
test pass. To fix this, I add an array to the data variables on
the component. I also add a v-for to loop through the array
creating elements required for the test.

.. code-block:: javascript

    <template>
      <div class='mui-container todo'>
        <div class='mui-panel'>
          <h2>{{ title }}</h2>
          <div class='task' v-for='task in tasks'>
            <h4>{{ task.name }}</h4>
            <h6>{{ task.status }}</h6>
            <div class="mui-divider"></div>
          </div>
          <h3>{{ msg }}</h3>
          <button class='mui-btn mui-btn--primary mui-btn--raised'>My Button</button>
        </div>
      </div>
    </template>

    <script>
    export default {
      name: 'todo',
      data () {
        return {
          title: 'Todo App',
          tasks: [
            {name: 'task A',
              status: 'done'
            }, {
              name: 'task B',
              status: 'not done'
            }, {
              name: 'task C',
              status: 'not done'
            }
          ],
          msg: 'This should be really good'
        }
      }
    }
    </script>

Now the tests pass. I then add the test to add a component to the
list. To do this, there is a form I create that will be visible or
invisible based on whether one wants to add a task.

.. code-block:: html

   <button class="mui-btn mui-btn--primary mui-btn--raised" id="add-task" v-on:click="showAddTaskForm">Add Task </button>
   <div class="mui-form" id="add-task-form" v-show="addTaskActive">
     <div class="mui-textfield">
       <input type="text" name="name" id="name" v-model="taskName">
       <label>Name</label>
     </div>
     <button id="submit" class="mui-btn mui-btn--raised" v-on:click="addTask">Submit</button>
     <button class="mui-btn" v-on:click="hideAddTaskForm">Cancel</button>
   </div>

The addTaskActive is a boolean variable. It is set to true by the
showAddTaskForm function and set to false by the hideAddTaskForm.

.. code-block:: javascript

   <script>
   export default {
     name: 'todo',
     data () {
       return {
         title: 'Todo App',
         addTaskActive: false,
         taskName: '',
         tasks: [
           {name: 'task A',
             status: 'done'
           }, {
             name: 'task B',
             status: 'not done'
           }, {
             name: 'task C',
             status: 'not done'
           }
         ],
         msg: 'This should be really good'
       }
     },
     methods: {
       showAddTaskForm () {
         this.addTaskActive = true
       },
       hideAddTaskForm () {
         this.addTaskActive = false
       },
       addTask () {
         const localtask = this.taskName
         this.tasks.push({
           name: localtask,
           status: 'not done'
         })
         console.log(this.tasks)
         this.taskName = ''
         this.addTaskActive = false
       }
     }
   }
   </script>


This now works. Its time to do some refactoring by removing the
form and placing it into another component. So I create another
component called AddTodo.vue and transfer all the logic to that
file. Since the todo list is a component of the parent i.e.
Todo.vue, I need a means of sending data from the child to the
parent. For this I use v-on and emit.

.. code-block:: javascript

    <template>      
      <div>
        <button class="mui-btn mui-btn--primary mui-btn--raised" id="add-task" v-on:click="showAddTaskForm">Add Task </button>
        <div class="mui-form" id="add-task-form" v-show="addTaskActive">
          <div class="mui-textfield">
            <input type="text" name="name" id="name" v-model="taskName">
            <label>Name</label>
          </div>
          <button id="submit" class="mui-btn mui-btn--raised" v-on:click="addTask">Submit</button>
          <button class="mui-btn" v-on:click="hideAddTaskForm">Cancel</button>
        </div>
      </div>
    </template>

    <script>
    export default {
      name: 'add-task',
      data () {
        return {
          addTaskActive: false,
          taskName: '',
          tasks: []
        }
      },
      methods: {
        showAddTaskForm () {
          this.addTaskActive = true
        },
        hideAddTaskForm () {
          this.addTaskActive = false
        },
        addTask () {
          this.$emit('formAddTask', this.taskName)
          this.taskName = ''
          this.addTaskActive = false
        }
      }
    }
    </script>

The Todo.vue file also cnanges accordingly to:

.. code-block:: javascript

    <template>
      <div class='mui-container todo'>
        <div class='mui-panel'>
          <h2>{{ title }}</h2>
          <add-task v-on:formAddrask="addTask"></add-task>
          <div class='task' v-for='task in tasks'>
            <h4>{{ task.name }}</h4>
            <h6>{{ task.status }}</h6>
            <div class="mui-divider"></div>
          </div>
          <h3>{{ msg }}</h3>
          <button class='mui-btn mui-btn--primary mui-btn--raised'>My Button</button>
        </div>
      </div>
    </template>
    <script>
    import AddTask from '@/components/AddTask'
    export default {
      name: 'todo',
      components: {
        AddTask
      },
      data () {
        return {
          title: 'Todo App',
          tasks: [{
            name: 'task A',
            status: 'done'
          }, {
            name: 'task B',
            status: 'not done'
          }, {
            name: 'task C',
            status: 'not done'
          }
          ],
          msg: 'This should be really good'
        }
      },
      methods: {
        addTask (taskName) {
          this.tasks.push({
            name: taskName,
            status: 'not done'
          })
        }
      }
    }
    </script>

The tests remain the same and still work after this change.

After this the app works well enough. I finally did some
refactoring of the code. The changes include:

+ Changing status to done a boolean variable
+ Adding descriptions to the tasks item
+ One cannot add blank tasks to the todo list

The files now look as follows:

.. code-block:: javascript
   
    Filename: src/components/Todo.vue
    <template>
      <div class='mui-container todo'>
        <div class='mui-panel'>
          <h2>{{ title }}</h2>
          <add-task v-on:formAddTask="addTask"></add-task>
          <div class="mui-radio">
            <label>
              <input type="radio" name="optionsTasks" id="all" value="all" v-model="tasksStatus" checked>
              All
            </label>
            <label>
              <input type="radio" name="optionsTasks" id="done" value="done" v-model="tasksStatus">
              Done
            </label>
            <label>
              <input type="radio" name="optionsTasks" id="not-done" value="notDone" v-model="tasksStatus" checked>
              Not Done
            </label>
          </div>
          <div class="mui-container">
            <div class='task mui--text-left' v-for='task in getTasks()'>
              <h4>{{ task.name }}</h4>
              <p>{{ task.description }}</p>
              <h6 v-if="task.done">done</h6>
              <h6 v-else>not done</h6>
              <button class="mui-btn mui-btn--primary" id="complete" v-on:click="completeTask(task)">Complete</button>
              <button class="mui-btn mui-btn--primary" id="delete" v-on:click="deleteTask(task)">Delete</button>
              <div class="mui-divider"></div>
            </div>
          </div>
        </div>
      </div>
    </template>

    <script>
    import AddTask from '@/components/AddTask'

    export default {
      name: 'todo',
      components: {
        AddTask
      },
      data () {
        return {
          title: 'Todo App',
          tasksStatus: 'all',
          tasks: [{
            name: 'task A',
            description: ' Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            done: true
          }, {
            name: 'do homework',
            done: false
          }, {
            name: 'fix tv',
            done: false
          }]
        }
      },
      methods: {
        getTasks () {
          if (this.tasksStatus === 'all') {
            return this.tasks
          } else if (this.tasksStatus === 'done') {
            return this.tasks.filter(task => { return task.done === true })
          } else if (this.tasksStatus === 'notDone') {
            return this.tasks.filter(task => { return task.done === false })
          }
        },
        addTask (taskName, taskDescription) {
          if (taskName === '') {
            return
          } else {
            this.tasks.push({
              name: taskName,
              description: taskDescription,
              done: false
            })
          }
        },
        completeTask (task) {
          const taskIndex = this.tasks.indexOf(task)
          this.tasks[taskIndex].done = true
        },
        deleteTask (task) {
          const taskIndex = this.tasks.indexOf(task)
          this.tasks.splice(taskIndex, 1)
        }

      }
    }
    </script>


.. code-block:: javascript

    Filename: src/components/AddTask.vue
    <template>      
      <div>
        <button class="mui-btn mui-btn--primary mui-btn--raised" id="add-task" v-on:click="showAddTaskForm">Add Task </button>
        <div class="mui-form mui--text-left" id="add-task-form" v-show="addTaskActive">
          <div class="mui-textfield">
            <input type="text" name="name" id="name" v-model="taskName">
            <label>Name</label>
          </div>
          <div class="mui-textfield">
            <input type="text" name="description" id="description" v-model="taskDescription">
            <label>Description</label>
          </div>
          <button id="submit" class="mui-btn mui-btn--raised" v-on:click="addTask">Submit</button>
          <button class="mui-btn" v-on:click="hideAddTaskForm">Cancel</button>
        </div>
      </div>
    </template>

    <script>
    export default {
      name: 'add-task',
      data () {
        return {
          addTaskActive: false,
          taskName: '',
          taskDescription: '',
          tasks: []
        }
      },
      methods: {
        showAddTaskForm () {
          this.addTaskActive = true
        },
        hideAddTaskForm () {
          this.addTaskActive = false
        },
        addTask () {
          this.$emit('formAddTask', this.taskName, this.taskDescription)
          this.taskName = ''
          this.addTaskActive = false
        }
      }
    }
    </script>


.. code-block:: lua

    Filename: test/e2e/specs/todo_test.js
    module.exports = {
      'default e2e tests': function (browser) {
        const devServer = browser.globals.devServerURL

        browser
        // Sam visits the page
          .url(devServer)
          .waitForElementVisible('#app', 5000)
        // He sees the title todo
          .assert.elementPresent('.todo')
          .assert.containsText('h2', 'Todo App')
        // He sees some previous tasks he had set up on the app
          .assert.elementCount('.task', 3)
          .assert.containsText('.task:first-of-type h4', 'task A')
        // He decides to add another task
        // He clicks on AddTask
          .assert.hidden('#add-task-form')
          .click('#add-task')
          .assert.visible('#add-task-form')
        // The task is for baking a cake
          .setValue('#name', 'bake a cake')
        // He then clicks on OK
          .click('#add-task-form #submit')
        // The task is added at the bottom of the list
          .assert.containsText('.task:last-of-type h4', 'bake a cake')
        // Sam also sees the task do homework
          .assert.containsText('div.task:nth-of-type(2) h4', 'do homework')
        // He has completed this task, so he clicks on task completed
          .click('.task:nth-of-type(2) #complete')
        // The task changes status to done
          .expect.element('div.task:nth-of-type(2) h6').text.to.not.contain('not done');
        // He also wants to see how may tasks are not done
        // He clicks a done button at the top and only tasks done are shown
        browser
          .click('#done')
          .assert.elementCount('.task', 2)
        // HE also aclikcs a not done at the top and tasks not done are shown
          .click('#not-done')
          .assert.elementCount('.task', 2)
          .click('#all')
          .assert.elementCount('.task', 4)
        // He sees another task: fix tv which he does not want to do
          .assert.containsText('div.task:nth-of-type(3) h4', 'fix tv')
        // He clicks a button and the task is removed
          .click('div.task:nth-of-type(3) #delete')
          .assert.elementCount('.task', 3)
        // He tries to add another element but forgets to add the title
          .click('#add-task')
        // He clicks on submit but nothing has been added
          .click('#add-task-form #submit')
          .assert.elementCount('.task', 3)
          .end()
      }
    }


This seems like a good enough place to have a version number. The
front end app works well enough. Now its time to work on the
server and integrate the server code to the system.

.. code-block:: bash

    git tag v0.0.1



