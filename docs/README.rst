.. _readme:

asterisk-formula
================

A SaltStack formula to build `Asterisk IP PBX <http://asterisk.org>`_ from sources.

This formula is forked from `template-formula <https://github.com/saltstack-formulas/template-formula>`_


.. contents:: **Table of Contents**
   :depth: 1

General notes
-------------

It takes a while (about 10 min at a medium PC) to configure and compile Asterisk from sources.

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
