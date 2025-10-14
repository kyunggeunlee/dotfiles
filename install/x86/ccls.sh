#!/bin/bash
set -ev

sudo apt update && sudo apt install -y wget

pushd /tmp

# clang
CLANG_VERSION=${VERSION:-12.0.1}

wget https://github.com/llvm/llvm-project/releases/download/llvmorg-$CLANG_VERSION/clang+llvm-$CLANG_VERSION-x86_64-linux-gnu-ubuntu-16.04.tar.xz
tar -xvf clang+llvm-$CLANG_VERSION-x86_64-linux-gnu-ubuntu-16.04.tar.xz

mkdir -p $HOME/.local/bin
rm -rf $HOME/.local/clang || true
mv clang+llvm-$CLANG_VERSION-x86_64-linux-gnu-ubuntu- $HOME/.local/clang

# ccls
git clone --depth=1 --recursive https://github.com/MaskRay/ccls
pushd ccls
cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$HOME/.local/clang
cmake --build Release
rm -f $HOME/.local/bin/ccls || true
mv Release/ccls $HOME/.local/bin
popd
rm -rf ccls

popd
