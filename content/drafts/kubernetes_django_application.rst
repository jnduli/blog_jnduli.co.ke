################################
Django Application in Kubernetes
################# ##############

:date: 2021-11-19
:category: Computer
:slug: django_application_in_kubernetes
:author: John Nduli



Deploying a django application
------------------------------
The application uses a database, so we'll need something that maintains
state. A `statefulset
<https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/>`_
is a controller that can help. When a pod is recreated, it has its data
since it's stored in persistent storage and has the same name. Each pods
name is of the form ${statefulset name}-${ordinal}, with ordinal being
an integer from 0 to N, depending on the names.

Note: It isn't really a good idea to have a dbase in kubernetes.


.. code-block:: yaml

    ---
    apiVersion: apps/v1
    kind: StatefulSet
    metadata:
      name: postgres-comicserver
      labels:
        app: postgres-comicserver
    spec:
       serviceName: "postgresql-service"
       volumeClaimTemplates:
       - metadata:
           name: dbase
         spec:
           accessModes: [ "ReadWriteOnce" ]
           resources:
             requests:
               storage: 1Gi
       replicas: 1
       selector:
          matchLabels:
             app: postgres-container
       template:
          metadata:
             labels:
                app: postgres-container
          spec:
             containers:
               - name: postgres-container
                 image: postgres
                 ports:
                   - containerPort: 5432
                 volumeMounts:
                   - name: dbase
                     mountPath: /dbase/db
                 env:
                   - name: POSTGRES_USER
                     value: admin
                   - name: POSTGRES_PASSWORD
                     value: randompassword
                   - name: POSTGRES_DB
                     value: comicsite

On the django side, we'll create a ClusterIP that points to the
statefulset and use this as the db host for the django app.


.. code-block:: yaml

    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: postgres-cluster-ip
    spec:
      selector:
        app: postgres-container
      ports:
        - port: 5432 
          targetPort: 5432
      type: ClusterIP

    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: comic-server
    spec:
      selector:
        matchLabels:
          app: comic-server
      replicas: 1
      template:
        metadata:
          labels:
            app: comic-server
        spec:
          containers:
            - name: comic-server-container
              image: comic-server:0.1.0
              imagePullPolicy: Never
              ports:
                - containerPort: 8000
              env:
                - name: "ALLOWED_HOSTS"
                  value: "*"
                - name: "DJANGO_SETTINGS_MODULE"
                  value: "comicsite.production_settings"
                - name: "SECRET_KEY"
                  value: "randomstring"
                - name: "DB_NAME"
                  value: "comicsite"
                - name: "DB_USER"
                  value: "admin"
                - name: "DB_PASSWORD"
                  value: "randompassword"
                - name: "DB_HOST"
                  value: postgres-cluster-ip

Note: I've avoided dealing with image storage, but this would involve
another statefulset.

Note: A better way to store secrets is to use secrets config.

And link up everything to the nginx controller with:

.. code-block:: yaml

    ---
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: comic-server-ingress
      annotations:
        nginx.ingress.kubernetes.io/rewrite-target: /$1
    spec:
      rules:
        - http:
            paths:
              - path: /?(.*)
                pathType: Prefix
                backend:
                  service:
                    name: comic-server-clusterip
                    port:
                      number: 8000

.. code-block:: bash

    cd django_project
    minikube start
    eval $(minikube -p minikube docker-env)
    docker build -t comic-server:0.1.0 -f Dockerfile .
    kubectl apply -f k8s/


.. code-block:: bash

    minikube start
    eval $(minikube -p minikube docker-env)
    docker build -t vue:0.1.0 -f dockerfile .
    minikube addons enable ingress
    kubectl apply -f k8s/
    kubectl get ingress
    kubectl get services



.. TODO: look at custom operators for postgresql

- https://cloud.google.com/blog/products/databases/to-run-or-not-to-run-a-database-on-kubernetes-what-to-consider
- https://stackoverflow.com/questions/68157219/when-should-i-use-statefulsetcan-i-deploy-database-in-statefulset

.. TODO: add auto scaler examples here too
