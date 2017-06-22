#!/bin/bash
# wget "https://github.com/FacuM/android_kernel_motorola_msm8916/blob/squid_nougat/arm-cortex_a7-linux-gnueabihf-linaro_4.9.4-2015.06-build_2015_07_15.tar.xz?raw=true"
git clone https://bitbucket.org/UBERTC/arm-eabi-4.9.git
# mv "arm-cortex_a7-linux-gnueabihf-linaro_4.9.4-2015.06-build_2015_07_15.tar.xz?raw=true" "arm-cortex_a7-linux-gnueabihf-linaro_4.9.3-2015.03-build_2015_03_15.tar.xz"
# tar -xvf arm-cortex_a7-linux-gnueabihf-linaro_4.9.3-2015.03-build_2015_03_15.tar.xz
make ARCH='arm' CROSS_COMPILE='./arm-eabi-4.9/bin/arm-eabi-' -j8 all
# bash build_cwm_zip.sh
