################################
Jupyter Notebook Setup on a VPS
################################


:date: 2018-03-02 15:00
:tags: projects
:category: Computer
:slug: jupyter-notebook-setup-in-vps
:author: John Nduli
:status: published

These steps have been tested on Digital Ocean server and a
scaleway ARM64 server. I used the cheapest provided options for my
setups.

First, set up ubuntu on the server. Both Digital Ocean and
Scaleway provide an easy way to do this. Just follow their
prompts, and you'll have your server up and running. After the
server is ready, update ubuntu:

.. code-block:: bash

    sudo apt update
    sudo apt upgrade

The server only has the root user. It is not advisable to use root
for normal work. So, I create a new user and switch to it:

.. code-block:: bash

    useradd -m -s /bin/bash user
    usermod -aG sudo username
    sudo passwd username
    su - user

Pip will be used to install various python packages. To install
it:

.. code-block:: bash

   sudo apt install python3-pip

I then install various ml libraries I'll use later:

.. code-block:: bash

    python3 -m pip install --user numpy scipy matplotlib pandas sympy nose seaborn pillow keras tensorflow scikit-learn scikit-image kaggle-cli
    pythom3 -m pip install ipython[notebook] jupyter



When setting up scaleway, some of the libraries failed to
install. Here are the dependenices I had to install for pillow:

.. code-block:: bash

    sudo apt-get install libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk

And here are the dependencies I had to install for scikit:

.. code-block:: bash

    sudo apt-get install gcc gfortran python-dev libopenblas-dev liblapack-dev

And for kaggle-cli too, I had to do this:

.. code-block:: bash

    sudo apt-get install libxml2-dev libxslt1-dev python3-lxml

Tensorflow cannot be installed in the arm64 scaleway instance
using pip. So remove it from the packages.

The packages are installed, but cannot be got from the terminal.
This is because the bash environment does not have it in its PATH
variable. To fix this, add this to the ~/.profile file:

.. code-block:: bash

    if [ -d "$HOME/.local/bin" ] ; then
            PATH="$HOME/.local/bin:$PATH"
    fi

Having set up most of the libraries I'll need, I have to configure
jupyter so that I can access it from my browser.

.. code-block:: bash

    jupyter notebook --generate-config

A file is generated in ~/.jupyter/jupyter_notebook_config.py. This
file contains various configuration options for jupyter.

I change the following:

.. code-block:: python

    c.NotebookApp.open_browser = False
    c.NotebookApp.ip = '0.0.0.0'

To set up the password to be used on logging in do:

.. code-block:: bash

    jupyter notebook password

I then start jupyter using:

.. code-block:: bash

    nohup jupyter notebook

The jupyter can be accessed from : ip_address:8888 using any browser.

To install Tensorflow on scaleway's arm processors, I found
instructions for a custom build `here <https://github.com/lherman-cs/tensorflow-aarch64>`_.

The instructions are to:

.. code-block:: bash

    curl -L https://github.com/lherman-cs/tensorflow-aarch64/releases/download/r1.4/tensorflow-1.4.0rc0-cp35-cp35m-linux_aarch64.whl > /tmp/tensorflow-1.4.0rc0-cp35-cp35m-linux_aarch64.whl
    python3 -m pip install /tmp/tensorflow-1.4.0rc0-cp35-cp35m-linux_aarch64.whl
