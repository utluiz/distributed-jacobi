#!/bin/sh

#	/home/luiz/git/distributed-jacobi/generated/m120-1.txt
#	/home/luiz/git/distributed-jacobi/big/c-33.mtx
#	/home/luiz/git/distributed-jacobi/big/3D_51448_3D.mtx
#	/home/luiz/git/distributed-jacobi/big/powersim.mtx

mpirun -np 4 ../Release/distributed-jacobi \
	"/home/luiz/git/distributed-jacobi/big/powersim.mtx" \
	0 \
	"/home/luiz/git/distributed-jacobi/results"
	