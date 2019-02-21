#!/bin/bash
ecpg a2q6.pgc a2q7.pgc a2q8.pgc
cc a2q8.c -I /usr/include/postgresql -lecpg -lm -o a2q8
