#!/bin/bash
# set -e
if [ -z "$1" ]
then
 printf "\nNo device picked, please type device name as an argument.\n\n  i.e.: bash build_cwm_zip.sh harpia\n"
 exit 1
else
 DEVCDN="$1"
 rm -f arch/arm/boot/dts/*.dtb
 rm -f arch/arm/boot/dt.img
 rm -f cwm_flash_zip/boot.img
 make ARCH=arm -j10 zImage
 make ARCH=arm -j10 dtimage
 make ARCH=arm -j10 modules
 rm -rf squid_install
 mkdir -p squid_install
 make ARCH=arm -j10 modules_install INSTALL_MOD_PATH=squid_install INSTALL_MOD_STRIP=1
 mkdir -p cwm_flash_zip/system/lib/modules/pronto
 find squid_install/ -name '*.ko' -type f -exec cp '{}' cwm_flash_zip/system/lib/modules/ \;
 mv cwm_flash_zip/system/lib/modules/wlan.ko cwm_flash_zip/system/lib/modules/pronto/pronto_wlan.ko
 cp arch/arm/boot/zImage cwm_flash_zip/tools/
 cp arch/arm/boot/dt.img cwm_flash_zip/tools/
 VERSION=$(cat Makefile | grep "EXTRAVERSION = -" | sed 's/EXTRAVERSION = -//')
 rm -f "arch/arm/boot/SomeFeaK$VERSION-$DEVCDN.zip"
 cd cwm_flash_zip
 zip -r "../arch/arm/boot/SomeFeaK$VERSION-$DEVCDN.zip" ./
 exit 0
fi
