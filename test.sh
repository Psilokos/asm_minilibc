#!/bin/bash
## test.sh for test-asm_minilibc in /home/lecouv/rendu/asm_minilibc
## 
## Made by Victorien LE COUVIOUR--TUFFET
## Login   <lecouv@epitech.eu>
## 
## Started on  Tue Feb 16 11:31:37 2016 Victorien LE COUVIOUR--TUFFET
## Last update Sun Mar 27 08:59:06 2016 Victorien LE COUVIOUR--TUFFET
##

make re ARCH=$1 > /dev/null

if [ $? -ne 0 ]; then
    exit 42
fi

if [ $1 = "i386" ]; then
    /usr/bin/gcc -m32 test.c $1-src/strcpbrk.o -fno-builtin
elif [ $1 = "x86_64" ]; then
    /usr/bin/gcc -m64 test.c $1-src/strcpbrk.o -fno-builtin
fi

if [ ${!#} = "-v" ]; then
    LD_PRELOAD=./libasm.so ./a.out "${@:2}"
else
    LD_PRELOAD=./libasm.so ./a.out "${@:2}" > /tmp/log_libasm
    ./a.out "${@:2}" > /tmp/log_glibc
    diff /tmp/log_libasm /tmp/log_glibc
    if [ ${!#} = "-c" ]; then
	rm /tmp/log_libasm /tmp/log_glibc
    fi
fi

rm a.out
make fclean ARCH=$1 > /dev/null
