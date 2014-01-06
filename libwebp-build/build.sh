#!/bin/sh
#
# Note: This build script assumes it can find the archive for libwebp 
# in the current directory. You can download it from the following URL:
#  http://code.google.com/speed/webp/download.html
#
# The resulting framework will can be found in the current directory 
# with the name WebP.framework
#

SDK=7.0
PLATFORMS="iPhoneSimulator iPhoneOS-V7 iPhoneOS-V7s"
DEVELOPER=`xcode-select -print-path`
TOPDIR=`pwd`
BUILDDIR="$TOPDIR/tmp"
FINALDIR="$TOPDIR/WebP.framework"
LIBLIST=''
DEVROOT="${DEVELOPER}/Toolchains/XcodeDefault.xctoolchain"

mkdir -p $BUILDDIR
mkdir -p $FINALDIR
mkdir $FINALDIR/Headers/

for PLATFORM in ${PLATFORMS}
do
  if [ "${PLATFORM}" == "iPhoneOS-V7" ]
  then
    SDKPATH="${DEVELOPER}/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS7.0.sdk/"
    ARCH="armv7"
  elif [ "${PLATFORM}" == "iPhoneOS-V7s" ]
  then
    SDKPATH="${DEVELOPER}/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS7.0.sdk/"
    ARCH="armv7s"
  else
    SDKPATH="${DEVELOPER}/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator7.0.sdk/"
    ARCH="i386"
  fi

  export CC=${DEVROOT}/usr/bin/cc
  export LD=${DEVROOT}/usr/bin/ld
  export CPP=${DEVROOT}/usr/bin/cpp
  export CXX=${DEVROOT}/usr/bin/g++
  export AR=${DEVROOT}/usr/bin/ar
  export AS=${DEVROOT}/usr/bin/as
  export NM=${DEVROOT}/usr/bin/nm
  export CXXCPP=${DEVROOT}/usr/bin/cpp
  export RANLIB=${DEVROOT}/usr/bin/ranlib

  rm -rf libwebp-0.4.0
  tar xzf libwebp-0.4.0.tar.gz
  cd libwebp-0.4.0

  sh autogen.sh

  ROOTDIR="/tmp/install.$$.${ARCH}"
  rm -rf "${ROOTDIR}"
  mkdir -p "${ROOTDIR}"

  export LDFLAGS="-arch ${ARCH} -miphoneos-version-min=5.0 -pipe -no-cpp-precomp -isysroot ${SDKPATH}"
  export CFLAGS="-arch ${ARCH} -miphoneos-version-min=5.0 -pipe -no-cpp-precomp -isysroot ${SDKPATH}"
  export CXXFLAGS="-arch ${ARCH} -miphoneos-version-min=5.0 -pipe -no-cpp-precomp -isysroot ${SDKPATH}"

  ./configure --host=${ARCH}-apple-darwin --prefix=${ROOTDIR} --disable-shared --enable-static
  make
  make install

  LIBLIST="${LIBLIST} ${ROOTDIR}/lib/libwebp.a"
  cp -Rp ${ROOTDIR}/include/webp/* $FINALDIR/Headers/

  cd ..
done

${DEVROOT}/usr/bin/lipo -create $LIBLIST -output $FINALDIR/WebP

rm -rf libwebp-0.4.0
rm -rf ${BUILDDIR}
