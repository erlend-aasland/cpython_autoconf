#!/bin/sh
set -e

SENTINEL=/src/pyconfig.h.in

if [ ! -e ${SENTINEL} ]; then
    echo "ERROR: ${SENTINEL} not found "
    echo "Did you forget to mount Python work directory with '-v.:/src'?"
    echo
    echo "  docker run -v\$PWD:/src ghcr.io/corona10/cpython_autoconf"
    echo "  podman run -v\$PWD:/src:Z ghcr.io/corona10/cpython_autoconf"
    exit 2
fi

BIN=/usr/local/bin
AUTOCONF=$BIN/autoconf
AUTORECONF=$BIN/autoreconf

if [ "$#" = "0" ]; then
    echo "Rebuilding configure script using $($AUTOCONF --version | head -n 1)"
    exec gosu $AUTORECONF -ivf -Werror $@
fi

exec "$@"
