#!/usr/bin/env bash
set -eu

CURRENTDIR=$(pwd)
KERNELVERSION=4.14.17

cd components && \
git clone https://git.busybox.net/busybox && \
git clone https://github.com/apritzel/arm-trusted-firmware.git && \
git clone https://github.com/u-boot/u-boot.git && \
git clone https://github.com/CallMeFoxie/linux.git && \
cd linux && \
git checkout v${KERNELVERSION}-pine64 && \
cd ${CURRENTDIR}

unset CURRENTDIR
