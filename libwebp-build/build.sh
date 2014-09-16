#!/bin/sh
#
# Note: This build script assumes it can find the archive for libwebp 
# in the current directory. You can download it from the following URL:
#  http://code.google.com/speed/webp/download.html
#
# The resulting framework will can be found in the current directory 
# with the name WebP.framework
#

SDK=7.1
ARCHS="armv7 armv7s arm64 i386"
DEVELOPER=`xcode-select -print-path`
TOPDIR=`pwd`
BUILDDIR="$TOPDIR/tmp"
FINALDIR="$TOPDIR/WebP.framework"
LIBLIST=''
DEVROOT="${DEVELOPER}/Toolchains/XcodeDefault.xctoolchain"

mkdir -p $BUILDDIR
mkdir -p $FINALDIR
mkdir $FINALDIR/Headers/

for ARCH in ${ARCHS}
do
  if [ "${ARCH}" == "arm64" ]
  then
    HOST="arm-apple-darwin"
    MINOS="7.0"
  else
    HOST="${ARCH}-apple-darwin"
    MINOS="5.0"
  fi

  if [ "${ARCH}" == "i386" ]
  then
    SDKPATH="${DEVELOPER}/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator7.1.sdk/"
  else
    SDKPATH="${DEVELOPER}/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS7.1.sdk/"
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

  rm -rf libwebp-0.4.1
  tar xzf libwebp-0.4.1.tar.gz
  cd libwebp-0.4.1

  sh autogen.sh

  ROOTDIR="/tmp/install.$$.${ARCH}"
  rm -rf "${ROOTDIR}"
  mkdir -p "${ROOTDIR}"

  export LDFLAGS="-arch ${ARCH} -miphoneos-version-min=${MINOS} -pipe -no-cpp-precomp -isysroot ${SDKPATH}"
  export CFLAGS="-arch ${ARCH} -miphoneos-version-min=${MINOS} -pipe -no-cpp-precomp -isysroot ${SDKPATH}"
  export CXXFLAGS="-arch ${ARCH} -miphoneos-version-min=${MINOS} -pipe -no-cpp-precomp -isysroot ${SDKPATH}"

  ./configure --host=${HOST} --prefix=${ROOTDIR} --disable-shared --enable-static
  make
  make install

  LIBLIST="${LIBLIST} ${ROOTDIR}/lib/libwebp.a"
  cp -Rp ${ROOTDIR}/include/webp/* $FINALDIR/Headers/

  cd ..
done

${DEVROOT}/usr/bin/lipo -create $LIBLIST -output $FINALDIR/WebP

rm -rf libwebp-0.4.1
rm -rf ${BUILDDIR}
