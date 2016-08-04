if [ -e /tmp/passwd ] ; then
    export LD_PRELOAD=/usr/lib64/libnss_wrapper.so
    export NSS_WRAPPER_PASSWD=/tmp/passwd
    [ -e /tmp/group ] && export NSS_WRAPPER_GROUP=/tmp/group
fi