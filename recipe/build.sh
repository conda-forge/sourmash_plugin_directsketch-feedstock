#!/bin/bash

set -ex

export BINDGEN_EXTRA_CLANG_ARGS="$CFLAGS"
export LIBCLANG_PATH=$BUILD_PREFIX/lib/libclang${SHLIB_EXT}

if [[ "$PY_VER" == "3.14" ]]; then
  export PYO3_USE_ABI3_FORWARD_COMPATIBILITY=1
fi

maturin build --release --strip --manylinux off --interpreter="${PYTHON}" -m Cargo.toml

"${PYTHON}" -m pip install $SRC_DIR/target/wheels/*.whl --no-deps -vv

#cargo-bundle-licenses --format yaml --output THIRDPARTY.yml 
