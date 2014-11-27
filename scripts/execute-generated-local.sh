#!/bin/sh

cd ..

execute(){
	for i in `seq 2 2 128`; do
		filename=m$i-1.txt
		echo $filename
		for j in `seq 1 5`; do
			mpirun -np $1 ./Release/distributed-jacobi \
				"/home/luiz/git/parallel-jacobi/generated/$filename" \
				0 \
				"/home/luiz/git/distributed-jacobi/results"
		done
	done
}

execute 2
execute 3
execute 4
execute 5

