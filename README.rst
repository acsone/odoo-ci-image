ACSONE docker image for running Odoo CI workloads
=================================================

This Odoo image has the following characteristics:

- Based on Ubuntu 18.04.
- Minimal dependencies to run ACSONE Odoo CI jobs (ie git, python2/3, pip, postgresql client, 
  lessc, wkhtmltopdf, unbuffer, git-autoshare).
- The entrypoint steps down from root (using gosu) to a user named `$LOCAL_USER_NAME` that is created with the uid
  found in `$LOCAL_USER_ID`. It also changes the current directory to `/home/$LOCAL_USER_NAME` and sets the owner
  of `/home/$LOCAL_USER_NAME` and `/home/$LOCAL_USER_NAME/{.cache,.config}` to `$LOCAL_USER_NAME:$LOCAL_USER_NAME`.
- Odoo 8, 9, 10, 11, 12 are supported.
- Odoo is *not* preinstalled.

Environment variables
---------------------

- **LOCAL_USER_NAME**: name of the step down user (default: `odoo`).
- **LOCAL_USER_ID**: uid to use for the `$LOCAL_USER_NAME` user (default: `9001`).

Recommended mounts
------------------

It is recommended to bind mount the following volumes to host directories owned by `$LOCAL_USER_ID`:

- `/home/$LOCAL_USER_NAME/.cache/pip`
- `/home/$LOCAL_USER_NAME/.cache/git-autoshare`
- `/home/$LOCAL_USER_NAME/.config/git-autoshare`
- `/home/$LOCAL_USER_NAME/.cache/acsoo-wheel`

Typical commands for testing
----------------------------

  .. code:: bash

    # temporary postgres image
    docker run -d \
       --name my-postgres \
       --tmpfs /var/lib/postgresql/data \
       postgres

    # run bash in acsone/odoo-ci image
    docker run --rm -it \
      -v ~/.config/git-autoshare:/home/odoo/.config/git-autoshare \
      -v ~/.cache/git-autoshare:/home/odoo/.cache/git-autoshare:rw \
      -v ~/.cache/pip:/home/odoo/.cache/pip:rw \
      -e LOCAL_USER_ID=`id -u` \
      --link my-postgres:postgres \
      acsone/odoo-ci \
      /bin/bash

    # kill postgres
    docker kill my-postgres
    docker rm my-postgres

Build and push
--------------

Use `make build` to build locally. 

Push to github to have docker cloud build the image.
