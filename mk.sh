#!/bin/bash

find -name '*.ko' -exec cp -av {} ../initramfs/lib/modules/ \;
chmod 644 ../initramfs/lib/modules/*
${CROSS_COMPILE}strip --strip-unneeded ../initramfs/lib/modules/*

rm zImage
make clean
make -j8 arch=arm
cp arch/arm/boot/zImage zImage_in
cp -v /home/none/android/kernel/hack_stock/galaxys2_kernel_repack/recovery.cm10.tar.xz .
./mkshbootimg.py zImage zImage_in boot.img recovery.cm10.tar.xz
../../../maketar.sh

