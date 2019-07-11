ACSONE docker image for running Odoo CI workloads
=================================================

This Odoo image has the following characteristics:

- Based on Ubuntu 18.04.
- Minimal dependencies to run ACSONE Odoo CI jobs (i.e. git,
  python2/3.5/3.6/3.7, pip, postgresql client, lessc, wkhtmltopdf, unbuffer,
  git-autoshare, openssh-client).
- Disable ssh host key checking
- Odoo 8, 9, 10, 11, 12 are supported.
- Odoo is *not* preinstalled.

Recommended mounts
------------------

It is recommended to bind mount the following volumes to host directories:

- `/home/$LOCAL_USER_NAME/.cache/pip`
- `/home/$LOCAL_USER_NAME/.cache/acsoo-wheel`
- `/home/$LOCAL_USER_NAME/.cache/git-autoshare`
- `/home/$LOCAL_USER_NAME/.config/git-autoshare`
