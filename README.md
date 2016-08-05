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

## Support tools

For an easier use of docker images for developemnt environment, you can just add the [dev](support/dev) script to your execution path (environment `PATH`) and start using it.

```
$ dev -h
Development environment in docker containers
Synopsys:
  dev [-h] [-u <user>] [-d <working_directory>] [-e <key=value>] <command> <image> [<commands>]

Arguments:
  <command> : Command to be executed:
    run     : run a new container instance.
    exec    : execute <commands> in running instance.
    ps      : process status for running instances.
  <image>   : Docker image name or id.

Options:
  -d <working_dir> : Working directory that will be mounted in the development container under '/workspace'.
  -e <key>[=<value>] : environments parameters which should be passed to the docker instance.
  -u <user> : Username.
  -h        : This help message.
```

### Usage example

Start a container and mount the current working directory:

```
$ id
uid=2376(dev) gid=2376(dev) groups=2376(dev),10(wheel),977(dockerroot),2377(docker)

$ dev run iconoeugen/fedora-dev
Activating nss_wrapper for dev:dev

bash-4.3$ id
uid=2376(dev) gid=2376(dev) groups=2376(dev)

bash-4.3$ pwd
/workspace

bash-4.3$ ls -l
total 20
-rw-r--r--. 1 dev dev  556 Aug  4 14:12 Dockerfile
-rw-rw-r--. 1 dev dev  187 Aug  4 07:22 Makefile
-rw-r--r--. 1 dev dev 1624 Aug  4 18:37 README.md
-rwxr--r--. 1 dev dev  591 Aug  4 14:11 entrypoint.sh
-rw-r--r--. 1 dev dev  185 Aug  4 14:03 nss_wrapper.sh
drwxrwxr-x. 2 dev dev   16 Aug  4 18:33 support
bash-4.3$
```

Execute command in running container:

```
$ pwd
/home/dev

$ dev exec iconoeugen/fedora-dev
No container found for image 'iconoeugen/fedora-dev' running in working directory '/home/dev'.

$ dev -d /home/dev/github/iconoeugen/docker-fedora-dev exec iconoeugen/fedora-dev
bash-4.3$ exit

$ cd /home/dev/github/iconoeugen/docker-fedora-dev

$ dev exec iconoeugen/fedora-dev
bash-4.3$
```

List containers:

```
$ pwd
/home/dev

$ dev ps iconoeugen/fedora-dev
No container found for image 'iconoeugen/fedora-dev' running in working directory '/home/vlad'.

$ dev -d /home/dev/github/iconoeugen/docker-fedora-dev ps iconoeugen/fedora-dev
CONTAINER ID        IMAGE                   COMMAND                  CREATED             STATUS              PORTS               NAMES
969c9d041e31        iconoeugen/fedora-dev   "/entrypoint.sh /bin/"   7 minutes ago       Up 7 minutes                            evil_bohr

$ cd /home/dev/github/iconoeugen/docker-fedora-dev

$ dev ps iconoeugen/fedora-dev
CONTAINER ID        IMAGE                   COMMAND                  CREATED             STATUS              PORTS               NAMES
969c9d041e31        iconoeugen/fedora-dev   "/entrypoint.sh /bin/"   8 minutes ago       Up 8 minutes                            evil_bohr
```
