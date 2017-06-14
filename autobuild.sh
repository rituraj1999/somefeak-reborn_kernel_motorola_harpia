#!/bin/bash
# ===================================== #
# Automatically build the kernel.       #
# ===================================== #
# Facundo Montero (facumo.fm@gmail.com) #
# ===================================== #
# Variable definition
DEVCODENAME="$1"
# Function definition
function buildkernel {
 printf '\nClean the build environment.\n'
# make -j8 clean
 printf "\nBegin building...\n"
 make -j8 all
 bash build_cwm_zip.sh $DEVCODENAME
}
function yesno {
 printf '\nWould you like to set it up right now? (type Y for 'yes', or N or everything else for 'no'): '
 read YESNO
 if [ "$YESNO" == 'Y' ]
 then
  :
 else
  exit 1
 fi
}
# Check if user wrote device name.
if [ -z "$1" ]
then
 printf '\nYou must type your device codename before beginning.\n\n  i.e.: bash autobuild.sh harpia\n'
 yesno
 printf '\nPlease type your device codename: '
 read DEVCODENAME
else
 printf "\nDevice codename: $1\n"
fi
# Check if ARCH is defined.
if [ -z "$ARCH" ]
then
 printf '\nVariable $ARCH is not defined. Define it and try again.\n\n  i.e.: ARCH='arm'\n'
 yesno
 printf '\nPlease type the architecture: '
 read ARCH
else
 printf "\nArchitecture: $ARCH\n"
fi
# Check if CROSS_COMPILE (toolchain) is defined.
if [ -z "$CROSS_COMPILE" ]
then
 printf '\n$CROSS_COMPILE is not defined. Define it and try again.\n\n  i.e.: CROSS_COMPILE='~/toolchain/bin/arm-eabi-'\n'
 yesno
 printf '\nPlease type the toolchain path: '
 read CROSS_COMPILE
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
 make -j8 $DEVCODENAME_defconfig
 if [ "$?" -ne 0 ]
 then
  exit 1
 else
  buildkernel
 fi
fi
