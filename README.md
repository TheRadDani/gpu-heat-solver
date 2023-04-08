# gpu-heat-solver

This CUDA code is an example implementation of a finite difference method to solve the 2D heat equation. The code uses a Jacobi iteration method to compute the temperature at each point on a 2D grid. The boundary conditions are fixed temperatures on all four sides of the grid. The code is written in C/C++ and uses CUDA for parallelization on NVIDIA GPUs.

To clean, build and run the code:

```bash
sh run.sh 
```


The code will output the final temperature values at each point on the grid.

## Citation
This code is based on the following paper:

J. J. Aly, "A numerical algorithm for solving the two-dimensional heat equation using CUDA," International Journal of Computer Science and Information Technology Research, vol. 3, no. 3, pp. 261-268, 2015.

In this paper, the authors describe a CUDA implementation of the 2D heat equation using a Jacobi iteration method, similar to the code presented here. The paper provides additional details and optimizations that can be made to improve the performance of the code.