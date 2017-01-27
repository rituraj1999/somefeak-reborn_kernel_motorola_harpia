#!/bin/bash
tar -xvf arm-cortex_a7-linux-gnueabihf-linaro_4.9.3-2015.03-build_2015_03_15.tar.xz
make ARCH=arm CROSS_COMPILE=./arm-cortex_a7-linux-gnueabihf-linaro_4.9.4-2015.06/bin/arm-eabi- -j4 all
