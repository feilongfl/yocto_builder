#!/usr/bin/env sh

docker run -it --rm --name yocto_builder -v /home/feilong/Program-ext/yocto/poky:/home/yocto/poky yoctobuilder
