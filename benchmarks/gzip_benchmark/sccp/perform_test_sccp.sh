#!/bin/bash
$1/clang -c -emit-llvm -O0 $2.c
$1/opt -mem2reg -sccp $2.bc -simplifycfg -dot-cfg -time-passes -o $2.opt.bc
$1/llc $2.opt.bc
gcc $2.opt.s -o $2.o
chmod +x $2.o
