#!/bin/sh

relpath=`dirname $0`
src=`cd $relpath && pwd`
if test "x$relpath" != "x/"; then
    src=$src/
fi
dst=$HOME
if test "x$dst" != "x/"; then
    dst=$dst/
fi

for f in `ls -A $src`; do
    test "x$f" = "x.git" && continue
    test "x$f" = "x.gitignore" && continue
    test "x$f" = "xbin" && continue
    test "x$f" = "xdeploy.sh" && continue
    ln -s $src$f $dst$f
done

mkdir -p ${dst}bin
for f in `ls -A ${src}bin`; do
    ln -s ${src}bin/$f ${dst}bin/$f
done
