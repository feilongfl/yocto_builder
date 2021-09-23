#!/usr/bin/env bash

pushd poky
source oe-init-build-env
bitbake core-image-sato
