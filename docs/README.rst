.. _readme:

asterisk-formula
================

|img_travis| |img_sr|

.. |img_travis| image:: https://api.travis-ci.com/litnialex/asterisk-formula.svg?branch=master
   :alt: Travis CI Build Status
   :scale: 100%
   :target: https://travis-ci.com/github/litnialex/asterisk-formula
.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release

A SaltStack formula to build `Asterisk IP PBX <http://asterisk.org>`_ from sources.


.. contents:: **Table of Contents**
   :depth: 1

General notes
-------------

It takes a while (about 10 min at a medium PC) to configure and compile Asterisk from sources.

This formula uses `template-formula
<https://github.com/saltstack-formulas/template-formula>`_ as a base.


Contributing to this repo
-------------------------

**Commit message formatting is significant!!**

Please see `How to contribute <https://github.com/saltstack-formulas/.github/blob/master/CONTRIBUTING.rst>`_ for more details.

Available states
----------------

``asterisk``
^^^^^^^^^^^^
Meta-state which includes: 
 * `asterisk.prereq`_
 * `asterisk.sources`_
 * `asterisk.compile`_
 * `asterisk.install`_
 * `asterisk.configs`_
 * `asterisk.service`_
 * `asterisk.sounds`_


``asterisk.prereq``
^^^^^^^^^^^^^^^^^^^
Install packages required to successfully compile asterisk from sources.
Package list is taken from ``./contrib/scripts/install_prereq`` script from asterisk sources.

``asterisk.sources``
^^^^^^^^^^^^^^^^^^^^
Download Asterisk sources from https://github.com/asterisk/asterisk.git.
Default Asterisk version is ``certified/16.8``. Use pillar's value ``asterisk.rev`` to change it.

``asterisk.compile``
^^^^^^^^^^^^^^^^^^^^
Compile Asterisk sources. Executes ``./configure`` and ``./make``.

``asterisk.install``
^^^^^^^^^^^^^^^^^^^^
Install Asterisk binary, libriries, etc. Executes ``./make install``.

``asterisk.configs``
^^^^^^^^^^^^^^^^^^^^
Install configuration files from ``files/configs`` into `/etc/asterisk` directory.
Different sets of configuration files will be added later invoking ``files_switch`` macro.

``asterisk.service``
^^^^^^^^^^^^^^^^^^^^
Install, run and enable systemd service ``asterisk``.

``asterisk.sounds``
^^^^^^^^^^^^^^^^^^^
Download sound file packages. You can modify the list of sound packages in the pillar.
Defaults are defined in ``defaults.yaml``.


Testing
-------

Linux testing is done with ``kitchen-salt``.

Requirements
^^^^^^^^^^^^

* Ruby
* Docker

.. code-block:: bash

   $ gem install bundler
   $ bundle install
   $ bin/kitchen test [platform]

Where ``[platform]`` is the platform name defined in ``kitchen.yml``,
e.g. ``debian-9-2019-2-py3``.

``bin/kitchen converge``
^^^^^^^^^^^^^^^^^^^^^^^^

Creates the docker instance and runs the ``asterisk`` main state, ready for testing.

``bin/kitchen verify``
^^^^^^^^^^^^^^^^^^^^^^

Runs the ``inspec`` tests on the actual instance.

``bin/kitchen destroy``
^^^^^^^^^^^^^^^^^^^^^^^

Removes the docker instance.

``bin/kitchen test``
^^^^^^^^^^^^^^^^^^^^

Runs all of the stages above in one go: i.e. ``destroy`` + ``converge`` + ``verify`` + ``destroy``.

``bin/kitchen login``
^^^^^^^^^^^^^^^^^^^^^

Gives you SSH access to the instance for manual testing.

