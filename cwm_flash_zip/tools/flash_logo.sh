#!/sbin/sh
cd /tmp/
/sbin/busybox dd if=/tmp/logo.bin of=/dev/block/bootdevice/by-name/logo
