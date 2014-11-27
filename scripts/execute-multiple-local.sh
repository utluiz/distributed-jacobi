#!/bin/sh

#	/home/luiz/git/distributed-jacobi/generated/m120-1.txt
#	/home/luiz/git/distributed-jacobi/big/c-33.mtx
#	/home/luiz/git/distributed-jacobi/big/3D_51448_3D.mtx
#	/home/luiz/git/distributed-jacobi/big/powersim.mtx

execute(){
	echo executing $1
	for j in `seq 1 20`; do
		mpirun -np 5 ../Release/distributed-jacobi \
			"/home/luiz/git/distributed-jacobi/big/$1" \
			0 \
			"/home/luiz/git/distributed-jacobi/results"
	done
}

execute c-33.mtx
execute 3D_51448_3D.mtx
execute powersim.mtx

	