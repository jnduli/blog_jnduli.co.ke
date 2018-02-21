##########################################
Control: Controllability and Observability
##########################################


:date: 2018-02-21 15:00
:tags: control
:category: Engineering
:slug: control-controllability-and-observability
:author: John Nduli
:status: published

The state space equations are given by:

.. math::
    x'(t) = Ax(t) + Bu(t)\\
    y(t) = Cx(t) + Du(t)

If we discretize the system, the equation can be written as:

.. math::
    x(n+1) = A_dx(n) + B_du(n)\\
    y(n) = C_dx(n) + D_du(n)

The discretization steps can be found `here:discretization
<https://en.wikibooks.org/wiki/Control_Systems/State-Space_Equations#Discretization>`_

Controllability
===============
A system is said to be controllable if the state can be changed by
changing the inputs.

Using the discretized equation, we can come up with the following:

.. math::
    x(1) &= A_dx(0) + B_du(0)\\
    x(2) &= A_dx(1) + B_du(1) = A_d^2 x(0) + A_dB_du(0) + B_du(1)\\
    .\\
    x(n) &= A_d^n x(0) + A_d^{n-1}B_du(0) + A_d^{n-2}B_du(1) + ...
    + B_du(n-1)

The last equation can be written as:

.. math::
    x(n) -  A_d^n x(0)= 
    \begin{bmatrix}
    B_d & A_dB_d & A_d^2B_d & ... & A_d^{n-2}B_d & A_d^{n-1}B_d
    \end{bmatrix} *
    \begin{bmatrix}
    u(n-1) \\ . \\ . \\ . \\u(2) \\ u(1) \\ u(0)
    \end{bmatrix}

Replacing with the controllability matrix with C, we get:

.. math::
    x(n) - A_d^n x(0) = C * U \\
    \therefore\\
    U = C^{-1} * (x(n) - A_d^n x(0))

This means that the equation is solvable when :math:`C^{-1}` exists,
i.e. its a non singular matrix.

Therefore a system is controllable when: 

.. math::

    \begin{bmatrix}
    B_d & A_dB_d & A_d^2B_d & ... & A_d^{n-2}B_d & A_d^{n-1}B_d
    \end{bmatrix} 

has a determinant.

Observability
=============

Using the discretized equation too:

.. math::
    y(0) = C_dx(0)\\
    y(1) = C_dx(1) = C_dA_dx(0)\\
    y(2) = C_dx(2) = C_dA_d^2x(0) \\
    y(n) = C_dx(n) = C_dA_d^nx(0)

This can be written as:

.. math::
    \begin{bmatrix}
    y(0)\\y(1)\\y(2)\\.\\y(n)
    \end{bmatrix} = 
    \begin{bmatrix}
    C_d \\ C_dA_d \\ C_dA_d^2 \\ . \\C_dA_d^n
    \end{bmatrix} * 
    x(0)

The observability matrix is:

.. math::
    
    \begin{bmatrix}
    C_d \\ C_dA_d \\ C_dA_d^2 \\ . \\C_dA_d^n
    \end{bmatrix}

And the systems has a unique solution if the system has a rank n.
If the system is a square matrix, the solution is of rank n if the
determinant is not 0.

The observability and controllability derivations can be found
from `here:rutgers
<http://www.ece.rutgers.edu/~gajic/psfiles/chap5.pdf>`_
