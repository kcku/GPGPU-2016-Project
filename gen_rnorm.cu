#include "CUDA_Rmath/Rmath.h"
#include <curand_kernel.h>

__global__ void gen_rnorm_kernel(unsigned seed, double rbetas[5][7][10000][5], double *rnorms) {
	int id = blockDim.x*blockIdx.x+threadIdx.x;
	int i = id/10000, j = id;
	if (i < 70) i = 0;
	else if (i < 175) i = 1, j -= 700000;
	else if (i < 315) i = 2, j -= 1750000;
	else if (i < 490) i = 3, j -= 3150000;
	else if (i < 700) i = 4, j -= 4900000;
	int k = j%((i+2)*5*10000)/((i+2)*5);
	j /= ((i+2)*5*10000);
	
	curandState_t state;
	curand_init(seed, id, 0, &state);
	for (int l = 0; l < 5; l++) {
		rnorms[id*5+l] = rnorm(curand(&state), curand(&state), rbetas[i][j][k][l], 1);
	}
}
extern "C" void gen_rnorm(double *rbetas, double *rnorms)  {
	double *d_rbetas, *d_rnorms;
	cudaMalloc(&d_rbetas, sizeof(double)*1750000);
	cudaMalloc(&d_rnorms, sizeof(double)*35000000);
	cudaMemcpy(d_rbetas, rbetas, sizeof(double)*1750000, cudaMemcpyHostToDevice);
	
	gen_rnorm_kernel<<<7000, 1000>>>(time(0), (double (*)[7][10000][5])d_rbetas, d_rnorms);
	
	cudaMemcpy(rnorms, d_rnorms, sizeof(double)*35000000, cudaMemcpyDeviceToHost);
	cudaFree(d_rbetas);
	cudaFree(d_rnorms);
}