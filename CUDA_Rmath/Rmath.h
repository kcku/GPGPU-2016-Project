#include <math.h>
#include <cfloat>

__device__ double fmin2(double x, double y);
__device__ double fmax2(double x, double y);
__device__ double rnorm(unsigned I1, unsigned I2, double mu, double sigma);
__device__ double rbeta(unsigned I1, unsigned I2, double aa, double bb);
__device__ double unif_rand(unsigned I1, unsigned I2);
__device__ double norm_rand(unsigned I1, unsigned I2);
__device__ double qnorm5(double p, double mu, double sigma, int lower_tail, int log_p);