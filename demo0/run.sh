#!/bin/bash

#==============================1.exit==================
# as exit.s -o exit.o
# ld exit.o -o exit

# run program and echo output
# rm exit.o
# ./exit
# echo $?


#==============================1.exit==================
as maximum.s -o maximum.o
ld maximum.o -o maximum

# run program and echo output
rm maximum.o
./maximum
echo $?
