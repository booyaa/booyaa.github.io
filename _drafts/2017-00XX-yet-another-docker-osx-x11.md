extends: post.liquid
title: Make this meaningful
date: 4 Jun 2017 16:49:09 +0100
path: YYYY/pretty/name
tags: abc, cde
---
open -a Xquartz
launch preferences > security > allow connections from network clients

export DISPLAY=$MY_IP_IS:0
xhost + $MY_IP_IS
xterm # to prove it works

# now you can launch vscode
docker run -d \
    -v /tmp/.X11-unix:/tmp/.    X11-unix \
    -v $HOME:/home/user \
    -e DISPLAY=$DISPLAY \
    --name vscode \
    jess/vscode

https://medium.com/@dimitris.kapanidis/running-gui-apps-in-docker-containers-3bd25efa862a
https://fredrikaverpil.github.io/2016/07/31/docker-for-mac-and-gui-applications/
https://github.com/moby/moby/issues/8710