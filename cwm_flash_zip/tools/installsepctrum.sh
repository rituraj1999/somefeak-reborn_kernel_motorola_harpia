#!/sbin/sh
# This script adds Spectrum support to the kernel ramdisk.
mkdir /tmp/ramdisk
cd /tmp/ramdisk
gzip -dc ../boot.img-ramdisk.gz | cpio -i
rm /tmp/ramdisk/boot.img-ramdisk.gz
cp -Rf /tmp/spectrum/* /tmp/ramdisk/
find . | cpio -o -H newc | gzip > ../boot.img-ramdisk.gz
