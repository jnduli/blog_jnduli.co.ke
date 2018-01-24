###########################
SciKit-Learn GraphSearch CV
###########################

:date: 2018-01-24 19:00
:tags: machine-learning
:category: Computer
:slug: scikit-learn-graphsearch-cv
:author: John Nduli
:status: published

Scikit learn provides a lot of algorithms to help in machine
learning. However, sometimes those algorithms have too many
options. It is not usually evident which options will produce the
best results. One method of solving this is to loop through all
possible options and check the score. 

.. code-block:: python

   crit = ['gini', 'entropy']
   max_depth = [9,10,11,12]
   min_samples_split= [2,3,4,5]
   best_score = 0
   best_tree = None

   for criterion in crit:
       for depth in max_depth:
           for min_samples in min_samples_split:
               tr = tree(criterion=criterion, max_depth=depth,
               min_samples_split=min_samples)
               tr.fit(X_train, y_train)
               cur_score = tr.score(X_test, y_test)
               if (cur_score > best_score):
                   best_core = cur_score
                   best_tree = tr


This is rather tedious and with more options to consider, the code
can become unreadable. Luckily, scikit-learn provides a method of
automatically doing this. All you do is provide a matrix of
options and scikit learn will loop through all possible
combinations to get the best fit for your data. It even provides
the options that worked best.

.. code-block:: python

    from sklearn.model_selection import cross_val_score
    from sklearn import tree
    from sklearn.model_selection import GridSearchCV

    X_train, X_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=2)

    parameters = {'criterion':('gini', 'entropy'), 
                  'min_samples_split':[2,3,4,5], 
                  'max_depth':[9,10,11,12],
                  'class_weight':('balanced', None),
                  'presort':(False,True),
                 }


    tr = tree.DecisionTreeClassifier()
    gsearch = GridSearchCV(tr, parameters)
    gsearch.fit(X_train, y_train)
    model = gsearch.best_estimator_

