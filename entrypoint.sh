#!/bin/bash

set -e -o pipefail

# allow to customize the UID of the local user,
# so we can share the same than the host's.
# If no user id is set, we use 9001
USER_ID=${LOCAL_USER_ID:-9001}
USER_NAME=${LOCAL_USER_NAME:-odoo}
HOME=/home/$USER_NAME

function dochown {
  if [ -e $1 ] ; then
    chown $USER_NAME:$USER_NAME $1
  fi
}

id -u $USER_NAME &> /dev/null || useradd --shell /bin/bash -u $USER_ID -o -c "" $USER_NAME

mkdir -p $HOME

unset PIPSI_BIN_DIR
unset PIPSI_HOME
export PATH=$HOME/.local/bin:$PATH

cd $HOME

# disable ssh strict hostkey checking
if [ ! -f .ssh/config ] ; then
    mkdir -p .ssh 
    chmod og-rwx .ssh
    cat >> .ssh/config <<EOF 
Host *
  StrictHostKeyChecking no
EOF
fi

dochown $HOME 
dochown $HOME/.cache 
dochown $HOME/.config
dochown $HOME/.ssh
dochown $HOME/.ssh/config

echo "Starting with user $USER_NAME (uid=$USER_ID) in $PWD with PATH=$PATH"

exec gosu $USER_NAME "$@"
