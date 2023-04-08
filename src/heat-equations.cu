#include <heat-equations.h>

__global__ void jacobi_iteration(float* temperature_old, float* temperature_new)
{
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;

    if (row >= 1 && row < HEIGHT - 1 && col >= 1 && col < WIDTH - 1) {
        int index = row * WIDTH + col;
        temperature_new[index] = (temperature_old[index - 1] + temperature_old[index + 1] +
                                  temperature_old[index - WIDTH] + temperature_old[index + WIDTH]) / 4.0f;
    }
}

int main()
{
    float* temperature_old, * temperature_new;
    cudaMallocManaged(&temperature_old, WIDTH * HEIGHT * sizeof(float));
    cudaMallocManaged(&temperature_new, WIDTH * HEIGHT * sizeof(float));

    // Initialize temperature_old to a constant value
    for (int i = 0; i < WIDTH * HEIGHT; i++) {
        temperature_old[i] = 25.0f;
    }

    // Set boundary conditions (fixed temperature on all four sides)
    for (int i = 0; i < WIDTH; i++) {
        temperature_old[i] = 100.0f;
        temperature_old[(HEIGHT - 1) * WIDTH + i] = 0.0f;
    }
    for (int i = 0; i < HEIGHT; i++) {
        temperature_old[i * WIDTH] = 75.0f;
        temperature_old[(i + 1) * WIDTH - 1] = 50.0f;
    }

    dim3 block_size(BLOCK_SIZE, BLOCK_SIZE);
    dim3 num_blocks(WIDTH / BLOCK_SIZE, HEIGHT / BLOCK_SIZE);

    for (int i = 0; i < NUM_ITERATIONS; i++) {
        jacobi_iteration<<<num_blocks, block_size>>>(temperature_old, temperature_new);
        cudaDeviceSynchronize();

        // Swap old and new temperature arrays
        float* temp = temperature_old;
        temperature_old = temperature_new;
        temperature_new = temp;
    }

    // Print out the final temperature values
    for (int row = 0; row < HEIGHT; row++) {
        for (int col = 0; col < WIDTH; col++) {
            printf("%.2f ", temperature_old[row * WIDTH + col]);
        }
        printf("\n");
    }

    cudaFree(temperature_old);
    cudaFree(temperature_new);

    return 0;
}
