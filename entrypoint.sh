#!/bin/bash

[[ $DEBUG =~ (1|true) ]] && set -x

USER_ID=$(id -u)
GROUP_ID=$(id -g)
if [[ $USER_ID -ne 0 ]] ; then
    echo "Activating nss_wrapper for ${USER}:${GROUP}"
    cat /etc/passwd | sed -e "s/default:\([^:]*\):[^:]*:[^:]*:\(.*\)/${USER}:\1:${USER_ID}:${GROUP_ID}:\2/" > /tmp/passwd
    cat /etc/group | sed \
        -e "s/default:\([^:]*\):[^:]*:\(.*\)/${GROUP}:\1:${GROUP_ID}:\2/" \
        -e "s/wheel:\([^:]*:[^:]*\):.*/wheel:\1:${USER}/" > /tmp/group
fi

cp -u /etc/skel/.bash* ${HOME}/
. ${HOME}/.bashrc

exec "$@"
