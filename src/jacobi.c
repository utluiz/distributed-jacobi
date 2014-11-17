#include <mpi.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include "matrix.h"
#include "stdlib.h"
#include "timer.h"
#include "results.h"
#include "jacobi.h"

/*
 * Accept as parameter:
 *  - input file
 *  - verbose (show data in console)
 *
 * Main steps
 *  1. Read matrix from file
 *  2. Solve linear system using Jacobi Method
 *  3. Write output
 *
 * Output
 * 	Result file with statistics
 */
int main(int argc, char *argv[]) {
	int			my_rank;		/* rank of process */
	int			num_procs;		/* number of processes */
	int			source;			/* rank of sender */
	int			dest = 0;		/* rank of receiver */
	int			tag = 0;		/* tag for messages */
	char		message[100];	/* storage for message */
	MPI_Status	status ;		/* return status for receive */

	//start up MPI
	MPI_Init(&argc, &argv);
	//MPI_Init(NULL, NULL);
	//find out process rank
	MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
	//find out number of processes
	MPI_Comm_size(MPI_COMM_WORLD, &num_procs);

	if ( argc != 4 ) {
		puts("Arguments are incorrect!");
		MPI_Finalize();
		exit(0);
	}

	//console output level
	int verbose = strtol(argv[2], NULL, 10);

	if (verbose) puts("---BEGIN---");

	//prints info
	if (verbose)
		printf("Input file: '%s', process number: %i, # of processes: %i\n\n",
				argv[1], my_rank, num_procs);

	//sanity check
	if (verbose && 0) {
		if (my_rank != 0) {
			/* create message */
			snprintf(message,26, "Greetings from process %d!", my_rank);
			/* use strlen+1 so that '\0' get transmitted */
			MPI_Send(message, strlen(message)+1, MPI_CHAR,
					dest, tag, MPI_COMM_WORLD);
		} else {
			printf("Num processes: %d\n",num_procs);
			for (source = 1; source < num_procs; source++) {
				MPI_Recv(message, 100, MPI_CHAR, source, tag,
						MPI_COMM_WORLD, &status);
				printf("Process 0 received \"%s\"\n",message);
			}

			/* now return the compliment */
			snprintf(message, 26, "Hi, how are you?           ");
		}
		MPI_Bcast(message, strlen(message)+1, MPI_CHAR, dest, MPI_COMM_WORLD);

		if (my_rank != 0) {
			printf("Process %d received \"%s\"\n", my_rank, message);
		}

	}

	//loads matrix
	matrix *m = matrix_load(argv[1]);

	//prints matrix
	if (verbose && my_rank == 0)
		matrix_print(m);

	//starts timer
	timer* t;
	if (my_rank == 0)
		t = start_timer();

	jacobi_result* result = jacobi_mpi(m, verbose, my_rank, num_procs);

	//stops timer
	if (my_rank == 0)
		stop_timer(t, verbose);

	//prints result
	if (verbose && my_rank == 0 && result != NULL) {
		int i;
		printf("\nResults: ");
		for (i = 0; i < m->size; i++) {
			printf("%f, ", result->x[i]);
		}
		printf("\nIterations: %i ", result->k);
	}

	//saves results
	if (my_rank == 0)
		write_results(t, argv[1], num_procs, 'M', m->size, argv[3]);

	//frees matrix
	matrix_destroy(m);

	//frees timer
	if (my_rank == 0 && result != NULL) {
		free(t);
		//free(result->x);
		free(result);
	}

	if (verbose) puts("\n\n---END---");

	//shut down MPI
	MPI_Finalize(); 

	return 0;
}
