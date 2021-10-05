#################
Kubernetes Basics
#################

:date: 2021-08-31
:category: Computer
:slug: kubernetes_basics
:author: John Nduli


Think of this as telling a story. And start with something catching and
how things will go from there.

Kubernetes is pretty complex, and learning it is a tall order. However,
I think it provides a sane way of handling infra complexity and also
means as it becomes more and more popular it becomes easier/more
standard, and understanding different setups becomes easier since we
have a common base to build upon.

We need to install `docker`, `minikube` and `kubectl` before starting.

.. code-block:: bash

    sudo pacman -S minikube kubectl docker
    sudo systemctl start docker
    minikube config set driver docker
    minikube start


== Serving Static Html ==
We'll be deploying a simple html page on kubernetes. The dockerfile for
this is:

.. code-block:: Dockerfile

    # Dockerfile_static_content
    FROM nginx:1.21.1
    COPY static_website_with_pandoc.html /usr/share/nginx/html/index.html

The smallest deployable unit in kubernetes is a pod. So the above image
will be run in a pod. A pod can contain one or more containers. However,
managing pods individually isn't a good idea. Creation and termination
of pods is handled by controllers
(https://kubernetes.io/docs/concepts/workloads/pods/#pods-and-controllers).

One type of controller is a ReplicaSet that maintains a constant number
of pods running at the same type. A deployment is a higher level
controller that manages ReplicaSet, so its recommended to use
Deployments instead of ReplicaSets directly
(https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/#when-to-use-a-replicaset).

For example, assuming the above is in an image tagged `static:0.1.0`, a
deployment manifest for this would look like:

.. code-block:: yaml

    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: static-website
    spec:
      replicas: 3
      selector:
        matchLabels:
          app: static-website
      template:
        metadata:
          labels:
            app: static-website
        spec:
          containers:
          - name: static-website
            image: static:0.1.0
            ports:
            - containerPort: 80

TODO: explain the parts of the manifest.

This will create 3 different pods when run. Pods however cannot
communicate with each other. To be able to talk to a pod, or even access
it we have to use a service. A service is an abstract way to expose an
application running on a set of Pods as a network service
(https://kubernetes.io/docs/concepts/services-networking/service/).

A LoadBalance is a service that exposes some resource to the public
through an ip. Here's the once used to expose the static website.


.. code-block:: yaml

    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: static-load-balancer
    spec:
      selector:
        app: static-website
      ports:
        - port: 80
          targetPort: 80
      type: LoadBalancer


To run the above, we can do the following:


.. code-block:: bash

    # create the files or clone this repo <TODO Link to repo>
    minikube start
    eval $(minikube -p minikube docker-env)
    docker build -t static:0.1.0 -f Dockerfile_static_content .
    kubectl apply -f k8s/deployment.yml
    kubectl get services # TODO: might be deeployments
    kubectl get pods
    kubectl get services # notice port address of the load balancer service
    curl $(minikube ip):ip_from_above


You can find the set up for this here: `TODO: add link to github
folder`. We can run the above with:

TODO: I mignt need to explain controllers above and what they do.
Also we might also want to use and IngressController here.


TODO: Last point of first round draft clean up


Node JS Project
---------------
For the above, we using the loadbalancer exposes the ip address for use.
We can point a domain name to that ip, but if we have several subdomains
this would mean creating multiple LoadBalancers. We can use an
IngressController to control all inbound traffic into our system. This
will be demonstrated using a vue js project to see how it would work.

We create a docker image and a deployment similar to the above steps:

.. code-block:: bash

    cd vue_project
    docker build -t vue:0.1.0 -f Dockerfile .
    docker container run --publish 8080:8080 --name vue_example vue:0.1.0

.. code-block:: yml

    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: vue-website
    spec:
      replicas: 3
      selector:
        matchLabels:
          app: vue-website
      template:
        metadata:
          labels:
            app: vue-website
        spec:
          containers:
          - name: vue-website
            image: vue:0.1.0
            ports:
            - containerPort: 8080

To get an internal ip address that points to the vue project, we create
a clusterIP service. This just provides an endpoint that can be used to
access the project and can be linked up to other things.

.. code-block:: yaml

    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: vue-clusterip
    spec:
      type: ClusterIP
      ports:
        - port: 8080
          targetPort: 8080
      selector:
        app: vue-website

You can enter any container in the cluster and running 
`curl vue-clusterip1 will return something.
# TODO: show a demonstration of the above

An ingress controller is then created and pointed to the clusterIP. We
just provide an ip

.. code-block:: bash

    ---
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: vue-ingress
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
                    name: vue-clusterip
                    port:
                      number: 8080


To run the above we do:

.. code-block:: yaml

    minikube start
    eval $(minikube -p minikube docker-env)
    docker build -t vue:0.1.0 -f Dockerfile .
    minikube addons enable ingress
    kubectl apply -f k8s/
    kubectl get ingress
    kubectl get services

- the ClusterIP service provides an internal IP to be used by other
  pods/services that want to access a particular group of pods.

Deploying a django application with a db frontend
-------------------------------------------------
When we require state, we can use a statefulset instead of a deployment
because this can maintain state amongst the starting things.

To set up the postgresql cluster, we create a volume that has a store of
5gb, which will be persistent. This will persist the storage amongst
multiple restarts of the container.

The django bit runs similar to the nodejs project on a deployment stack.

# TODO: try and figure out how to deal with image storage.

.. code-block:: bash

    cd django_project
    minikube start
    eval $(minikube -p minikube docker-env)
    docker build -t comic-server:0.1.0 -f Dockerfile .
    kubectl apply -f k8s/




# Rough Notes
Kubernetes is an orchestration thingy, so its used to manage containers
and has other cool features like load balancers, scaling, etc.

Add definition of cluster.

We have a pod, which is a unit of work. It can contain one of many
containers. To create a pod (It seems we cannot create pods):

We can create a deployment that can contain multiple replicas. (TODO:
more details on this). Shouldn't this be replicaset??

Also add notes of persistentvolumes and such.

When we need to have state, that cannot be deleted, we can use a
statefulset. 

To expose the services internally, we can use the ClusterIP service.
This provides an internal ip that can be used by various processes.
(TODO: add example)

To expose externally, we can use an ingress controller or a load
balancer. An example of an ingress controller provides a nginx front end
that can be used to route http traffic into the cluster. A load balancer
exposes ports to the public at some ip address. This can be used to
access any type of traffic, be it http, tcp, https.

To store secrets, we can create a secrets config and apply it. This
creates a secretes service that we can use to get environment variables
from.

TODO:

- create docker image of staafu, and use to explain
  deployment/replicaset
- create docker image of the comic project, and use this to explain
  stateful sets and linking them up to the database with environment
  variable and secrets.
