#!/bin/bash

git submodule --init --recursive 

mkdir llvm-project/build && cd llvm-project/build 

cmake -G Ninja ../llvm \
   -DLLVM_ENABLE_PROJECTS=mlir \
   -DLLVM_BUILD_EXAMPLES=ON \
   -DLLVM_TARGETS_TO_BUILD="X86;NVPTX;AMDGPU" \
   -DCMAKE_BUILD_TYPE=Release \
   -DLLVM_ENABLE_ASSERTIONS=ON 

ninja 

export MLIR_DIR=$(pwd)/lib/cmake/mlir
export LLVM_EXTERNAL_LIT=$(pwd)/bin/llvm-lit

cd ../../

mkdir -p build && cd build

cmake -G Ninja .. 
cmake --build . --target check-standalone-opt
