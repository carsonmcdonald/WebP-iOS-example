#!/bin/sh
#
# Note: This build script assumes it can find the archive for libwebp 
# in the current directory. You can download it from the following URL:
#  http://code.google.com/speed/webp/download.html
#
# The resulting framework will can be found in the current directory 
# with the name WebP.framework
#

SDK=4.3
PLATFORMS="iPhoneSimulator iPhoneOS-V6 iPhoneOS-V7"
DEVELOPER=/Developer
TOPDIR=`pwd`
BUILDDIR="$TOPDIR/tmp"
FINALDIR="$TOPDIR/WebP.framework"
LIBLIST=''

mkdir -p $BUILDDIR
mkdir -p $FINALDIR
mkdir $FINALDIR/Headers/

for PLATFORM in ${PLATFORMS}
do
  if [ "${PLATFORM}" == "iPhoneOS-V7" ]
  then
    PLATFORM="iPhoneOS"
    ARCH="armv7"
  elif [ "${PLATFORM}" == "iPhoneOS-V6" ]
  then
    PLATFORM="iPhoneOS"
    ARCH="armv6"
  else
    ARCH="i386"
  fi

  ROOTDIR="${BUILDDIR}/${PLATFORM}-${SDK}-${ARCH}"
  rm -rf "${ROOTDIR}"
  mkdir -p "${ROOTDIR}"

  export DEVROOT="${DEVELOPER}/Platforms/${PLATFORM}.platform/Developer"
  export SDKROOT="${DEVROOT}/SDKs/${PLATFORM}${SDK}.sdk"
  export CC=${DEVROOT}/usr/bin/gcc
  export LD=${DEVROOT}/usr/bin/ld
  export CPP=${DEVROOT}/usr/bin/cpp
  export CXX=${DEVROOT}/usr/bin/g++
  export AR=${DEVROOT}/usr/bin/ar
  export AS=${DEVROOT}/usr/bin/as
  export NM=${DEVROOT}/usr/bin/nm
  export CXXCPP=$DEVROOT/usr/bin/cpp
  export RANLIB=$DEVROOT/usr/bin/ranlib
  export LDFLAGS="-arch ${ARCH} -pipe -no-cpp-precomp -isysroot ${SDKROOT} -L${ROOTDIR}/lib"
  export CFLAGS="-arch ${ARCH} -pipe -no-cpp-precomp -isysroot ${SDKROOT} -I${ROOTDIR}/include"
  export CXXFLAGS="-arch ${ARCH} -pipe -no-cpp-precomp -isysroot ${SDKROOT} -I${ROOTDIR}/include"

  rm -rf libwebp-0.1.2
  tar xzf libwebp-0.1.2.tar.gz
  cd libwebp-0.1.2

  sh autogen.sh

  ./configure --host=${ARCH}-apple-darwin --prefix=${ROOTDIR} --disable-shared --enable-static
  make
  make install

  LIBLIST="${LIBLIST} ${ROOTDIR}/lib/libwebp.a"
  cp -Rp ${ROOTDIR}/include/webp/* $FINALDIR/Headers/

  cd ..
done

${DEVROOT}/usr/bin/lipo -create $LIBLIST -output $FINALDIR/WebP

rm -rf libwebp-0.1.2
rm -rf ${BUILDDIR}
