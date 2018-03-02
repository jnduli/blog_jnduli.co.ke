################################
Jupyter Notebook Setup on a VPS
################################


:date: 2017-06-04 15:00
:tags: projects
:category: Computer
:slug: jupyter-notebook-setup-in-vps
:author: John Nduli
:status: draft

These steps have been tested on Digital Ocean server and a
scaleway server.

Get a server and set up ubuntu in it. Afterwards, update ubuntu
before anything else.

.. code-block:: bash

    sudo apt update
    sudo apt upgrade

Create a user and switch to the user:

.. code-block:: bash

    useradd -m -s /bin/bash user
    usermod -aG sudo username
    sudo passwd username
    su - user

The install pip using python3 environment

.. code-block:: bash

   sudo apt install python3-pip

Install various ml libraries:

.. code-block:: bash

    python3 -m pip install --user numpy scipy matplotlib pandas sympy nose seaborn pillow keras tensorflow scikit-learn scikit-image

When setting up scaleay, some of the libraries might fail to
install. Here are the dependenices I had to install for pillow:

.. code-block:: bash

    sudo apt-get install libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk

And here are the dependencies I had to install for scikit:

.. code-block:: bash

    sudo apt-get install gcc gfortran python-dev libopenblas-dev liblapack-dev


Add this to the ~/.profile file to be able to use jupyter from the
terminal:

.. code-block:: bash

    if [ -d "$HOME/.local/bin" ] ; then
            PATH="$HOME/.local/bin:$PATH"
    fi


Set up jupyter notebook:

.. code-block:: bash

    jupyter notebook --generate-config

A file is generated in ~/.jupyter/jupyter_notebook_config.py

Enter the file and change the following:

.. code-block:: python

    c.NotebookApp.open_browser = False
    c.NotebookApp.ip = '0.0.0.0'

To set up the password to be used on logging in do:

.. code-block:: bash

    jupyter notebook password

Then start jupyter with:

.. code-block:: bash

    nohup jupyter notebook

The jupyter can be accessed from : ip_address:8888 using any browser.

I then install kaggle-cli to be used to get data from kaggle:

.. code-block:: bash

    python3 -m pip install --user kaggle-cli

On scaleway, I had to install the following first before
kaggle-cli:

.. code-block:: bash

    sudo apt-get install libxml2-dev libxslt1-dev python3-lxml

To install Tensorflow on scaleway's arm processors, I found
instructions for a custom build `here <https://github.com/lherman-cs/tensorflow-aarch64>`_.

The instructions are to:

.. code-block:: bash

    curl -L
    https://github.com/lherman-cs/tensorflow-aarch64/releases/download/r1.4/tensorflow-1.4.0rc0-cp35-cp35m-linux_aarch64.whl
    > /tmp/tensorflow-1.4.0rc0-cp35-cp35m-linux_aarch64.whlpython3 -m
    pip inst
    all /tmp/tensorflow-1.4.0rc0-cp35-cp35m-linux_aarch64.whl
