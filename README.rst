ACSONE docker image for running Odoo CI workloads
=================================================

This Odoo image has the following characteristics:

- Based on Ubuntu 18.04.
- Minimal dependencies to run ACSONE Odoo CI jobs

  - git
  - git-autoshare
  - openssh-client
  - rsync
  - make
  - python2/3.5/3.6/3.7
  - postgresql client
  - lessc
  - wkhtmltopdf
  - unbuffer
  - gettext: useful to manipulate .po files
  - graphviz, poppler-utils, antiword: used by some Odoo versions
  - libreoffice-writer, libreoffice-calc: for py3o

- ssh client configuration

  - disable strict host key checking
  - default user is gitlab-runner

- Odoo 8, 9, 10, 11, 12 are supported.
- Odoo is *not* preinstalled.

Recommended mounts
------------------

It is recommended to bind mount the following volumes to host directories:

- `/root/.cache/pip`
- `/root/.cache/acsoo-wheel`
- `/root/.cache/git-autoshare`
