#! /usr/bin/env sh

set -eu

DEP_SRC=$HOME/dependency_source/

install_gnustep_make() {
    cd $DEP_SRC
    git clone https://github.com/gnustep/make.git
    cd make
    if [ $LIBRARY_COMBO = 'ng-gnu-gnu' ]
    then
        ADDITIONAL_FLAGS="--enable-objc-nonfragile-abi"
    else
        ADDITIONAL_FLAGS=""
    fi
    ./configure --prefix=$HOME/staging --with-library-combo=$LIBRARY_COMBO $ADDITIONAL_FLAGS
}

install_ng_runtime() {
    cd $DEP_SRC
    git clone https://github.com/gnustep/libobjc2.git
    mkdir libobjc2/build
    cd libobjc2/build
    export CC="clang"
    export CXX="clang++"
    cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DGNUSTEP_INSTALL_TYPE=NONE -DCMAKE_INSTALL_PREFIX:PATH=$HOME/staging ../
    make install
}


mkdir -p $DEP_SRC
if [ $LIBRARY_COMBO = 'ng-gnu-gnu' ]
then
    install_ng_runtime
fi

install_gnustep_make
