FROM debian:stretch

ARG BUILD_PKGS="build-essential gcc-aarch64-linux-gnu libc6-dev-arm64-cross device-tree-compiler"
ARG SUPPORT_PKGS="bc git wget gawk ca-certificates fakeroot debhelper dpkg-dev"
ARG UBOOT_PKGS="python python-dev swig libfdt-dev libfdt1"

RUN apt-get update && \
    apt-get install -y ${BUILD_PKGS} ${SUPPORT_PKGS} ${UBOOT_PKGS} --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*
