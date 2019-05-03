#! /bin/bash
/opt/docker/install.sh && echo "ok install"
/usr/sbin/xinetd -dontfork && echo "xinetd OK" 
