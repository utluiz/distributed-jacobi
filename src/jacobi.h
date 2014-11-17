#include <stdbool.h>
#include "matrix.h"

#ifndef JACOBI_SERIAL_H_
#define JACOBI_SERIAL_H_

#define precision 0.0001

typedef struct jacobi_result_t {
	double* x;
	int k;
	double e;
} jacobi_result;

jacobi_result* jacobi_mpi(matrix *m, bool verbose, int process_num, int process_count);

#endif /* JACOBI_SERIAL_H_ */
