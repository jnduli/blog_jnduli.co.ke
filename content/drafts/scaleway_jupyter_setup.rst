##################################
Jupyter Notebook Setup in Scaleway
##################################


:date: 2017-06-04 15:00
:tags: projects
:category: Computer
:slug: jupyter-notebook-setup-in-scaleway
:author: John Nduli
:status: draft

Get a server and set up ubuntu in it. Afterwards, update ubuntu
before anything else.

.. code-block:: bash

    sudo apt update
    sudo apt upgrade

Create a user and switch to the user:

.. code-block:: bash
   useradd -m -s /bin/bash user
   usermod -aG sudo username
   su - user

The install pip using python3 environment

.. code-block:: bash

   sudo apt install python3-pip

Install jupyter notebook

.. code-block:: bash

    pip3 install -U 'ipython[notebook]'
    pip3 install -U jupyter


Set up jupyter notebook:

.. code-block:: bash

    jupyter notebook --generate-config

A file is generated in ~/.jupyter/jupyter_notebook_config.py

Enter the file and change the following:

.. code-block:: python

    c.Notebook.open_browser = false
    c.Notebook.ip = '0.0.0.0'

To set up the password to be used on logging in do:

.. code-block:: bash

    jupyter notebook password

Then start jupyter with:

.. code-block:: bash

    nohup jupyter notebook

The jupyter can be accessed from : ip_address:8888 using any browser.

To install libraries:

kaggle-cli

sudo apt-get install libxml2-dev libxslt1-dev python3-lxml
python3 -m pip install --user kaggle-cli

Numpy, Scipy, matplotlib, etc

# dependencies for pillow
sudo apt-get install libtiff5-dev libjpeg8-dev zlib1g-dev \
    libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk

python3 -m pip install --user numpy scipy matplotlib ipython jupyter pandas sympy nose seaborn pillow keras tensorflow


