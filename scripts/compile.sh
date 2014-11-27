#!/bin/sh

# compile all at once


path=../src

mpicc -O3 -W -Wall -o distributed-jacobi \
	$path/jacobi.c \
	$path/jacobi-mpi.c \
	$path/matrix.c \
	$path/results.c \
	$path/timer.c \
	-lm 


# compile only

#mpicc -O3 -W -Wall -c jacobi-mpi.c -o jacobi-mpi.o
#mpicc -O3 -W -Wall -c jacobi.c -o jacobi.o
#mpicc -O3 -W -Wall -c matrix.c -o matrix.o
#mpicc -O3 -W -Wall -c results.c -o results.o
#mpicc -O3 -W -Wall -c timer.c -o timer.o

# link
  
#mpicc -O3 -W -Wall -o distributed-jacobi jacobi.o jacobi-mpi.o matrix.o results.o timer.o -lm

# -Idir : compiler, included header files
# -Ldir : linker, object files

#mpicc -O3 -Wall -c -fmessage-length=0 -MMD -MP -MF"src/jacobi.d" -MT"src/jacobi.d" -o "src/jacobi.o" "../src/jacobi.c"
#mpicc -O3 -Wall -c -fmessage-length=0 -MMD -MP -MF"src/matrix.d" -MT"src/matrix.d" -o "src/matrix.o" "../src/matrix.c"

