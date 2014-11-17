#!/bin/sh

# compile only

mpicc -O3 -W -Wall -c src/jacobi-mpi.c -o generated/jacobi-mpi.o
mpicc -O3 -W -Wall -c src/jacobi.c -o generated/jacobi.o
mpicc -O3 -W -Wall -c src/matrix.c -o generated/matrix.o
mpicc -O3 -W -Wall -c src/results.c -o generated/results.o
mpicc -O3 -W -Wall -c src/timer.c -o generated/timer.o

# link
  
mpicc -O3 -W -Wall -o distributed-jacobi generated/jacobi.o generated/jacobi-mpi.o generated/matrix.o generated/results.o generated/timer.o

# all at once

mpicc -O3 -W -Wall -o distributed-jacobi src/jacobi.c src/jacobi-mpi.c src/matrix.c src/results.c src/timer.c

# -Idir : compiler, included header files
# -Ldir : linker, object files

#mpicc -O3 -Wall -c -fmessage-length=0 -MMD -MP -MF"src/jacobi.d" -MT"src/jacobi.d" -o "src/jacobi.o" "../src/jacobi.c"
#mpicc -O3 -Wall -c -fmessage-length=0 -MMD -MP -MF"src/matrix.d" -MT"src/matrix.d" -o "src/matrix.o" "../src/matrix.c"

mpirun -np 4 -hostfile nodes distributed-jacobi