#!/usr/bin/env sh

docker run -it --rm --name yocto_builder \
    -v /etc/localtime:/etc/localtime:ro \
    -v /home/feilong/Program-ext/yocto/poky:/home/yocto/poky \
    yoctobuilder
