#################
Kubernetes Basics
#################

:date: 2021-08-31
:category: Computer
:slug: kubernetes_basics
:author: John Nduli


We need to install: minikube and kubectl

.. code-block:: bash

    sudo pacman -S minikube kubectl
    minikube config set driver docker
    minikube start

Smallest deployable unit in kubes is a pod. It contains one or more
containers. The can be exposed using services, for example:
- the ClusterIP service provides an internal IP to be used by other
  pods/services that want to access a particular group of pods.
- LoadBalancer is used to provide external access to a pod within the
  cluster.

TODO: I mignt need to explain controllers above and what they do.
Also we might also want to use and IngressController here.

To demonstrate the above, we'll deploy a small vuejs project on kubes:
TODO: use staafu, and expose this using LoadBalancer and ClusterIP.


The advantage of the staafu project is that it's stateless. When we want
to have state, and dont want to mess things up, we can use a
statefulset.

TODO: set up my comic project, using postgresql as statefulset and the
django side as a replicaset. For image hosting, I'll set up something
different as a stateful set too.





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
