#!/bin/bash

mkdir -p output/

docker run -ti \
  -e "CROSS_COMPILE=aarch64-linux-gnu-" \
  -u `id -u`:`id -g` \
  -v `pwd`/:/base \
     aarch64-builder \
       /bin/bash -e -c '\
  echo "===== Building Kernel =====" && \
  cd /base/components/linux/ && \
  cp /base/config/kernel.config .config && \
  ARCH=arm64 make clean && \
  ARCH=arm64 make oldconfig && \
  ARCH=arm64 make -j5 deb-pkg KBUILD_IMAGE=arch/arm64/boot/Image && \
  cp ../*.deb /base/output/ && \
  echo "===== Building Meta Package ====" && \
  KERNELVERSION=`cd /base/components/linux && make kernelversion` && \
  PKGVERSION=`cd /base/linux-image-pine64/ && dpkg-parsechangelog -S Version` && \
  ( [ "$KERNELVERSION" != "$PKGVERSION" ] && (echo "Updating meta package..." && cd /base/linux-image-pine64/ && ./update.sh $KERNELVERSION) || (echo "No need for update")) ; \
  cd /base/linux-image-pine64 && \
  dpkg-buildpackage && \
  mv /base/linux-image-pine64*.deb /base/output/ && \
  rm /base/linux-image-pine64*.changes'
