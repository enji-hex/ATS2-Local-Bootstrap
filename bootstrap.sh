#!/bin/sh

# Used release 0.4.2 from https://sourceforge.net/projects/ats2-lang/

install(){
    mkdir -p build
    cd ./build
    extracted="./ATS2-Postiats-int-0.4.2"
    [ -d "$extracted"  ] && {
        echo "Delete old build"
        rm -rf "$extracted"
    }
    tar -xzf ./ATS2-Postiats-0.4.2.tgz
    cd "$extracted"

    file="./prelude/CATS/array.cats"

    start=$(grep -n '^void \*bsearch$' "$file" | tail -n 1 | cut -d: -f1)
    end=$(grep -nF 'end of [bsearch]' "$file"  | cut -d: -f1)
    start=$((start - 1))

    echo "Cut bsearch $((start)) $end"
    sed -i "${start},${end}d" "$file"

    ./configure
    make CFLAGS="-Wno-implicit-function-declaration -I. -I./ccomp/runtime" all

    echo "Build complete, you can install ATS2 system-wide with 'make install' from ./build/$extracted"
}

smoketest(){
    extracted="../build/ATS2-Postiats-int-0.4.2"
    export PATSHOME="$extracted"
    export PATH="$PATSHOME/bin:$PATH"

    cd ats2-from-c

    rm -f math_dats.c math_dats.o main.o demo

    patsopt -o math_dats.c -d math.dats
    patscc -c math_dats.c -o math_dats.o
    gcc -Wall -Wextra -c main.c -o main.o
    gcc -o demo main.o math_dats.o
    ./demo
    retcode=$?

    echo "Exit code $retcode"
    if [ "$retcode" -eq 0 ]; then
        echo "== Array test OK == "
    else
        echo "== Array test FAIL == "
    fi
}

case "$1" in
    --test|-t)
        ( smoketest );;
    *)
        ( install )
        ( smoketest );;
esac






