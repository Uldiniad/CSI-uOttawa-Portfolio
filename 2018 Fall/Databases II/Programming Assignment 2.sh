#!/bin/bash
ecpg -t a2q6.pgc a2q7.pgc a2q8.pgc
cc -c a2q6.c a2q7.c a2q8.c -I/usr/include/postgresql
cc -o a2q8 a2q8.o -lecpg -lm