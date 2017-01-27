#!/bin/bash
wget http://download1337.mediafire.com/7st1l15yrsbg/4nwy86xivvbsib7/arm-cortex_a7-linux-gnueabihf-linaro_4.9.3-2015.03-build_2015_03_15.tar.xz
tar -xvf arm-cortex_a7-linux-gnueabihf-linaro_4.9.3-2015.03-build_2015_03_15.tar.xz
make ARCH=arm CROSS_COMPILE=./arm-cortex_a7-linux-gnueabihf-linaro_4.9.4-2015.06/bin/arm-eabi- -j4 all
