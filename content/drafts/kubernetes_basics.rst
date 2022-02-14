#################
Kubernetes Basics
#################

:date: 2022-02-05
:category: Computer
:slug: kubernetes_basics
:author: John Nduli

"We've got this project on kubernetes that you'll be helping maintain"

This started my journey with kubernetes. I only knew that it existed so
I had to level up to be able to help. I found a great tutorial from
`freecodecaamp
<https://www.freecodecamp.org/news/the-kubernetes-handbook/>`_ and this
blog is an attempt to set up some personal projects using it. It's best
to read the original though as it's more in-depth.

I wanted to serve an `index.html` for a first project. A `pod
<https://kubernetes.io/docs/concepts/workloads/pods/#working-with-pods>`_
would be used for this. A pod is the smallest deployable unit in
kubernetes, and it can contain one or more containers (e.g. docker
containers). Its an isolated environment to run a docker image,
providing storage and networking.

To create a pod, I can create one manually or use a `workload resource
<https://kubernetes.io/docs/concepts/workloads/pods/#pods-and-controllers>`_,
which provide extra features like replication, recreating pods when one
stops working and more. The work resources have a pod template, which
provides a description of how to create the pods we want.

A `deployment
<https://kubernetes.io/docs/concepts/workloads/controllers/deployment/>`_
is a work resource that creates replicas of the pod. I wanted 3 pods
serving the `index.html` file, so I'd use a deployment.

To start off, I installed packages to help me play with kubernetes
locally:

.. code-block:: bash

    sudo pacman -S minikube kubectl docker
    sudo systemctl start docker
    minikube config set driver docker
    minikube start


I also created a dockerfile that served the `index.html` file using
nginx.

.. code-block:: dockerfile

    # tagged static:0.1.0 
    FROM nginx:1.21.1
    COPY index.html /usr/share/nginx/html/index.html

I created a yml file that defined the deployment resource that would be
created in minikube.

.. code-block:: yaml

    # static_deployment.yml
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: static-website-deployment
    spec:
      replicas: 3
      selector:
        matchLabels:
          app: static-website-pod
      template:
        metadata:
          labels:
            app: static-website-pod
        # pod template section
        spec:
          containers:
          - name: static-website-container
            image: static:0.1.0
            ports:
            - containerPort: 80

This creates a deployment work resource with the name
`static-website-deployment`. The deployment ensures that there are 3
pods running the docker image at any one time (defined in replicas). The
selector is used to define what pods are being managed, and are the same
as the metadata.lables.app found in the template section. This metadata
is applied to each pod that is created. The pod template defines how the
pod are created, so in each of the 3 pods there will be a running
container named static-website-container, and the pod would expose port
80.

To run the above:

.. code-block:: bash

    minikube start
    eval $(minikube -p minikube docker-env) # ensure docker images are built in minikube context
    docker build -t static:0.1.0 -f Dockerfile_static_content .
    kubectl apply -f k8s/deployment.yml

To check that things are running as expected:

.. code-block:: bash

    ╰─$ kubectl get deployment
    NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
    static-website-deployment   3/3     3            3           17s
    ╰─$ kubectl get pods
    NAME                                         READY   STATUS    RESTARTS   AGE
    static-website-deployment-57bdbf7d94-7ngwt   1/1     Running   0          4s
    static-website-deployment-57bdbf7d94-9l5cv   1/1     Running   0          4s
    static-website-deployment-57bdbf7d94-gj59k   1/1     Running   0          4s


I wanted to curl into this server, but couldn't because the kubernetes
environment is isolated. To deal with this, kubernetes has `services
<https://kubernetes.io/docs/concepts/services-networking/service/>`_
which provide a means of exposing a set of pods. I set up a
`LoadBalancer` service, which provides an ip address that can be used to
access the pods. In minikube, it uses a random port on the minikube
service. TODO: rename this to not use minikube service.

.. code-block:: yml

    # static_load_balancer.yml
    apiVersion: v1
    kind: Service
    metadata:
      name: static-load-balancer
    spec:
      selector:
        app: static-website-pod
      ports:
        - port: 80
          targetPort: 80
      type: LoadBalancer

and ran the following:

.. code-block:: bash

    ╰─$ kubectl apply -f static_load_balancer.yml
    service/static-load-balancer unchanged
    ╰─$ kubectl get services
    NAME                   TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
    kubernetes             ClusterIP      10.96.0.1       <none>        443/TCP        6d5h
    static-load-balancer   LoadBalancer   10.105.222.19   <pending>     80:30133/TCP   116s
    ╰─$ curl $(minikube ip):30133
    <!DOCTYPE html>
    <html lang="en">
        <head>


`minikube ip` provides the ip address of minikube, and the port is the
second part of the PORTS section of the static-load-balancer service.

Since what we're exposing is http traffic, I could also use an `ingress
object
<https://kubernetes.io/docs/concepts/services-networking/ingress/>`_,
which is a type of controller that can expose http and https traffic.
Other advantages include ssl termination and name-based virtual
hosting. I first needed to enable ingress in minikube with:

.. code-block:: bash

    minikube addons enable ingress


The ingress controller links up with a service, so we could use the
LoadBalancer service previously created.

.. code-block:: yml

    ---
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: static-ingress
      annotations:
        nginx.ingress.kubernetes.io/rewrite-target: /
    spec:
      rules:
        - http:
            paths:
              - path: /
                pathType: Prefix
                backend:
                  service:
                    name: static-load-balancer
                    port:
                      number: 80


However, it doesn't make much sense to have both an ingress object and a
load balancer pointing to the same thing. Another service I could use
was the `ClusterIP` which provides an ip internal to the cluster. This
way we only have one entry point into minikube.

.. code-block:: yml

    # static_ingress.yml
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: static-clusterip
    spec:
      selector:
        app: static-website-pod
      ports:
        - port: 80
          targetPort: 80
      type: ClusterIP

    ---
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: static-ingress
      annotations:
        nginx.ingress.kubernetes.io/rewrite-target: /
    spec:
      rules:
        - http:
            paths:
              - path: /
                pathType: Prefix
                backend:
                  service:
                    name: static-clusterip
                    port:
                      number: 80


And now running:

.. code-block:: bash

    ╰─$ kubectl get services
    NAME                   TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
    kubernetes             ClusterIP      10.96.0.1       <none>        443/TCP        6d6h
    static-clusterip       ClusterIP      10.109.227.9    <none>        80/TCP         108s
    static-load-balancer   LoadBalancer   10.105.222.19   <pending>     80:30133/TCP   81m
    ╰─$ kubectl get ingress
    NAME             CLASS    HOSTS   ADDRESS     PORTS   AGE
    static-ingress   <none>   *       localhost   80      25m
    ╰─$ curl $(minikube ip)
    <!DOCTYPE html>
    <html lang="en">
        <head>
        .
        .


Having the basics of kubernetes i.e. controllers, services and ingress
down, I tried to set up a django project. I'll add a link to this when
it's ready. 
