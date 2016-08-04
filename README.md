# docker-fedora-dev

Development environment based on Fedora in Docker container.

## Requirements

* Docker 1.9+
* An X11 socker (if GUI is used)

## Quickstart

## Making data persist between sessions

The data is usually persisted in the home directory of an user, so if you want to persist the data for a later session you have to share it with your host:

For example:
```
mkdir -p .home
docker run -it --rm --net=host \
    -e USER=$(id -u -n) -e GROUP=$(id -g -n) -u "$(id -u):$(id -g)" \
    -v $PWD:/workspace \
    -v $PWD/.home:/home/default \
    -v ~/.ssh:/home/default/.ssh \
    -e DISPLAY=${DISPLAY} -v ~/.Xauthority:/home/default/.Xauthority \
    -v /dev/shm:/dev/shm \
    iconoeugen/fedora-dev /bin/bash
```
