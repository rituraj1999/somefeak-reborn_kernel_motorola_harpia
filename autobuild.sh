#!/bin/bash
# ===================================== #
# Automatically build the kernel.       #
# ===================================== #
# Facundo Montero (facumo.fm@gmail.com) #
# ===================================== #
# Function definition
function buildkernel {
 printf '\nClean the build environment.\n'
 make -j8 clean
 printf "\nBegin building...\n"
 make -j8 all
 bash build_cwm_zip.sh $1
}
# Check if user wrote device name.
if [ -z "$1" ]
then
 printf '\nYou must type your device codename before beginning.\n\n  i.e.: bash autobuild.sh harpia\n'
 exit 1
else
 printf "\nDevice codename: $1\n"
fi
# Check if ARCH is defined.
if [ -z "$ARCH" ]
then
 printf '\nVariable $ARCH is not defined. Define it and try again.\n\n  i.e.: ARCH='arm'\n'
 exit 1
else
 printf "\nArchitecture: $ARCH\n"
fi
# Check if CROSS_COMPILE (toolchain) is defined.
if [ -z "$CROSS_COMPILE" ]
then
 printf '\n$CROSS_COMPILE is not defined. Define it and try again.\n\n  i.e.: CROSS_COMPILE='~/toolchain/bin/arm-eabi-'\n'
 exit 1
else
 printf "\nToolchain path: $CROSS_COMPILE\n"
fi
# Look for .config file in root.
if [ -f ".config" ]
then
 printf "\n.config file found.\n"
 buildkernel
else
 printf "\n.config file not existing. Loading defaults...\n"
 make -j8 $1_defconfig
 if [ "$?" -ne 0 ]
 then
  exit 1
 else
  buildkernel
 fi
fi
