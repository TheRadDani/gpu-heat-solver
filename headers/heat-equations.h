#include <stdio.h>

#define WIDTH 256
#define HEIGHT 256
#define BLOCK_SIZE 16
#define NUM_ITERATIONS 1000

__global__ void jacobi_iteration(float* temperature_old, float* temperature_new);
