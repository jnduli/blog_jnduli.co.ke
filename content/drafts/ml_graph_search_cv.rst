###########################
SciKit-Learn GraphSearch CV
###########################

:date: 2018-01-10 19:00
:tags: machine-learning
:category: Computer
:slug: scikit-learn-graphsearch-cv
:author: John Nduli
:status: draft

Scikit learn provides a lot of algorithms to help in machine
learning. However, sometimes those algorithms have too many
options. It is not usually evident which options will produce the
best results. One method of solving this is to loop through all
possible options and check the score.

.. TODO: include sample code for this

.. code-block:: python

   crit = ['gini', 'entropy']
   max_depth = [9,10,11,12]
   min_samples_split= [2,3,4,5]
   best score = 0

   for criterion in crit:
       for max_depth in max_depth:
           for min_samples in min_samples_split:
               tr = tree(criterion=criterion, max_depth=max_depth,
               min_samples_split=min_samples)
               tr.fit(X_train, y_train)
               tr.cross_val_score(test_data)
               if (cur_score = best_score):
                   // store the parameters that are the best




   

This is rather tedious. Luckily, scikitlearn provides a method of
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


